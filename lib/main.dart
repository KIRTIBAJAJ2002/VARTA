import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart'; // Unused in provided code, but often useful
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

// --- Configuration ---
// IMPORTANT: Update this URL based on where your FastAPI backend is running:
// - If FastAPI is on your local machine and Flutter is on an Android emulator:
//   const String backendWsUrl = "ws://10.0.2.2:8000/ws";
// - If FastAPI is on your local machine and Flutter is on iOS simulator or web:
//   const String backendWsUrl = "ws://127.0.0.1:8000/ws";
// - If FastAPI is on a remote server (e.g., 34.47.173.157 is where your FastAPI is exposed):
//   const String backendWsUrl = "ws://YOUR_FASTAPI_SERVER_IP:8000/ws";
//   Example: const String backendWsUrl = "ws://34.47.173.157:8000/ws"; (if FastAPI runs on the same machine as your other services)
const String backendWsUrl = "ws://127.0.0.1:8000/ws"; // Default for local web/iOS dev

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real-Time Voice AI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true, // Opt-in for Material 3 design if desired
      ),
      home: const VoiceChatScreen(),
    );
  }
}

class VoiceChatScreen extends StatefulWidget {
  const VoiceChatScreen({super.key});

  @override
  State<VoiceChatScreen> createState() => _VoiceChatScreenState();
}

class _VoiceChatScreenState extends State<VoiceChatScreen> {
  WebSocketChannel? _channel;
  final _audioRecorder = AudioRecorder();
  final _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  String _currentTranscript = "Start speaking...";
  String _llmResponse = "";
  final List<String> _chatHistory = [];
  // Use Uuid().v4() if a truly unique ID for every session is needed,
  // otherwise, a timestamp-based ID is fine for a single user's session.
  final String _clientId = "flutter_user_${DateTime.now().millisecondsSinceEpoch}"; 

  StreamSubscription<Uint8List>? _audioStreamSubscription;
  StreamSubscription<RecordState>? _recordStateSubscription;
  
  // Timer for debouncing UI updates or other periodic checks if needed
  Timer? _reconnectTimer;

  @override
  void initState() {
    super.initState();
    _requestPermissions(); // Request permissions first
    _connectWebSocket();   // Then connect WebSocket
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      if (status.isPermanentlyDenied) {
        _showPermissionPermanentlyDeniedDialog();
      } else {
        _showPermissionDeniedDialog();
      }
    }
  }

  void _showPermissionDeniedDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Microphone Permission Denied"),
        content: const Text("Please grant microphone access to use voice features."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
        ],
      ),
    );
  }

  void _showPermissionPermanentlyDeniedDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Microphone Permission Permanently Denied"),
        content: const Text("Please enable microphone permission in app settings."),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
            openAppSettings(); // Opens app settings for the user to grant permission
          }, child: const Text("Open Settings")),
        ],
      ),
    );
  }

  void _connectWebSocket() {
    // Ensure previous channel is closed before opening a new one
    _channel?.sink.close(); 
    _channel = WebSocketChannel.connect(Uri.parse('$backendWsUrl/$_clientId'));
    print("Attempting to connect to WebSocket: $backendWsUrl/$_clientId");

    _channel?.stream.listen(
      (message) async {
        if (message is String) {
          try {
            final data = json.decode(message);
            if (data['type'] == 'transcript') {
              setState(() => _currentTranscript = data['text']);
            } else if (data['type'] == 'llm_response') {
              // Add user's last transcription and AI's response to chat history
              setState(() {
                if (_currentTranscript != "Listening..." && _currentTranscript.isNotEmpty && _currentTranscript != "Recording..." && _currentTranscript != "Start speaking...") {
                   _chatHistory.add("You: $_currentTranscript"); // Add last user input
                }
                _llmResponse = data['text'];
                _chatHistory.add("AI: $_llmResponse");
                _currentTranscript = "Listening..."; // Reset transcript display for next input
              });
            } else if (data['type'] == 'connection_status') {
              setState(() => _currentTranscript = "Connected. Say something!");
            } else if (data['type'] == 'error') {
              // Display error messages from the backend
              setState(() {
                _llmResponse = "Error: ${data['text']}";
                _currentTranscript = "Error occurred. Reconnecting...";
              });
              print("Backend Error: ${data['text']}");
            }
          } catch (e) {
            print("Error decoding JSON from WebSocket: $e, Message: $message");
            if (mounted) {
              setState(() => _currentTranscript = "Error: Invalid message format.");
            }
          }
        } else if (message is Uint8List) {
          try {
            // Stop current playback if any, then play the new audio
            if (_audioPlayer.playing) {
              await _audioPlayer.stop();
            }
            await _audioPlayer.setAudioSource(MyCustomAudioSource(message));
            await _audioPlayer.play();
          } catch (e) {
            print("Audio playback error: $e");
            if (mounted) {
              setState(() => _llmResponse = "Error playing audio.");
            }
          }
        }
      },
      onError: (e) {
        print("WebSocket error: $e");
        // If the sink is closed when we try to add data, this onError will catch it.
        if (mounted) {
          setState(() => _currentTranscript = "Disconnected. Reconnecting...");
        }
        _reconnect();
      },
      onDone: () {
        print("WebSocket closed.");
        if (mounted) {
          setState(() => _currentTranscript = "Disconnected. Reconnecting...");
        }
        _reconnect();
      },
    );
  }

  void _reconnect() {
    _channel?.sink.close(); // Close any existing connection
    _channel = null; // Clear the channel
    
    // Cancel any pending reconnect timers to avoid multiple attempts
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) { // Only attempt to reconnect if the widget is still mounted
        _connectWebSocket();
      }
    });
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      _audioStreamSubscription?.cancel();
      _audioStreamSubscription = null;
      _recordStateSubscription?.cancel();
      _recordStateSubscription = null;
      await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _currentTranscript = "Stopped recording. Waiting for response..."; // Indicate processing
      });
    } else {
      final hasPermission = await _audioRecorder.hasPermission();
      if (!hasPermission) {
        await _requestPermissions();
        return; // Do not proceed if permission is not granted
      }

      // Configuration for audio recording. This needs to match the backend's expectation.
      // 16-bit PCM, 16kHz sample rate, 1 channel (mono) is standard for Whisper models.
      const config = RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: 16000,
        numChannels: 1,
      );

      try {
        _audioStreamSubscription = (await _audioRecorder.startStream(config)).listen((chunk) {
          // Attempt to add chunk to the sink. If the WebSocket is not open,
          // the onError callback for the _channel.stream will be triggered.
          _channel?.sink.add(chunk);
        }, onError: (error) {
          print("Error sending audio chunk to WebSocket: $error");
          // This specific error might indicate a closed connection; trigger reconnect
          if (mounted) {
            setState(() => _currentTranscript = "WebSocket error during audio stream.");
          }
          _reconnect();
        });

        _recordStateSubscription = _audioRecorder.onStateChanged().listen((state) {
          print("Recording state: $state");
          // Optionally update UI based on recording state, e.g., if recording pauses
        });

        setState(() {
          _isRecording = true;
          _currentTranscript = "Recording... Speak clearly!";
          _llmResponse = ""; // Clear previous AI response when new recording starts
        });
      } catch (e) {
        print("Recording error: $e");
        setState(() {
          _isRecording = false;
          _currentTranscript = "Error starting recording. Check permissions.";
        });
        // Show an alert or snackbar to the user about the recording error
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to start recording: $e")),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _reconnectTimer?.cancel(); // Cancel any active timers
    _channel?.sink.close(1000, 'Client disconnected'); // Close WebSocket gracefully
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    _audioStreamSubscription?.cancel();
    _recordStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real-Time Voice AI')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true, // Show latest messages at the bottom
                itemCount: _chatHistory.length,
                itemBuilder: (context, index) {
                  final message = _chatHistory[_chatHistory.length - 1 - index]; // Display in correct order
                  final isUser = message.startsWith("You:");
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[100] : Colors.green[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(message),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            // Display current transcript and AI response prominently
            Text("Transcript: $_currentTranscript", style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16)),
            const SizedBox(height: 8),
            Text("AI Response: $_llmResponse", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),
            FloatingActionButton.extended(
              onPressed: _toggleRecording,
              label: Text(_isRecording ? "Stop Recording" : "Start Speaking"),
              icon: Icon(_isRecording ? Icons.mic_off : Icons.mic),
              backgroundColor: _isRecording ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _chatHistory.clear();
                  _llmResponse = "";
                  _currentTranscript = "Chat cleared. Start speaking...";
                });
              },
              child: const Text("Clear Chat"),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Custom audio source for just_audio from bytes ---
class MyCustomAudioSource extends StreamAudioSource {
  final Uint8List _bytes;
  MyCustomAudioSource(this._bytes) : super(tag: 'custom_tts');

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= _bytes.length;
    return StreamAudioResponse(
      sourceLength: _bytes.length,
      contentLength: end - start,
      offset: start,
      // Create a stream from the sublist of bytes
      stream: Stream.value(_bytes.sublist(start, end)),
      contentType: 'audio/wav', // Ensure this matches what your TTS service returns
    );
  }
}
