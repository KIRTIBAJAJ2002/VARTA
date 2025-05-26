import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';

class VoiceClient {
  final String clientId = "flutter_user_${DateTime.now().millisecondsSinceEpoch}";
  late WebSocketChannel _channel;
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final AudioPlayer _player = AudioPlayer();
  final ValueNotifier<List<String>> messages = ValueNotifier([]);
  bool _isRecording = false;
  Timer? _timer;

  Future<void> connect() async {
    final uri = Uri.parse('ws://34.93.142.196:8000/ws/$clientId');
    _channel = WebSocketChannel.connect(uri);

    _channel.stream.listen((event) async {
      if (event is String) {
        final data = json.decode(event);
        final type = data['type'];
        final text = data['text'];

        if (type == 'transcript') {
          messages.value = [...messages.value, "You: $text"];
        } else if (type == 'llm_response') {
          messages.value = [...messages.value, "Assistant: $text"];
        }
      } else if (event is Uint8List) {
        await _player.play(BytesSource(event));
      }
    });
  }

  Future<void> startRecording() async {
    final micPermission = await Permission.microphone.request();
    if (!micPermission.isGranted) return;

    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/record.wav';

    await _recorder.openRecorder();
    await _recorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
      sampleRate: 16000,
    );

    _isRecording = true;

    _timer = Timer.periodic(const Duration(milliseconds: 400), (timer) async {
      if (!_isRecording) {
        timer.cancel();
        return;
      }

      await _recorder.stopRecorder();
      final bytes = await File(filePath).readAsBytes();
      _channel.sink.add(bytes);

      await _recorder.startRecorder(
        toFile: filePath,
        codec: Codec.pcm16WAV,
        sampleRate: 16000,
      );
    });
  }

  Future<void> stopRecording() async {
    _isRecording = false;
    _timer?.cancel();
    await _recorder.stopRecorder();
    await _recorder.closeRecorder();
  }

  void dispose() {
    _channel.sink.close();
    _recorder.closeRecorder();
    _player.dispose();
    messages.dispose();
  }
}
