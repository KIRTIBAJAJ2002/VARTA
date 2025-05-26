import 'package:flutter/material.dart';
import '../voice_client.dart';

class AudioButton extends StatefulWidget {
  final VoiceClient client;

  const AudioButton({super.key, required this.client});

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  bool _isRecording = false;

  void _toggleRecording() async {
    if (_isRecording) {
      await widget.client.stopRecording();
    } else {
      await widget.client.startRecording();
    }
    setState(() => _isRecording = !_isRecording);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_isRecording ? Icons.stop : Icons.mic),
      onPressed: _toggleRecording,
      color: _isRecording ? Colors.red : Colors.black,
      iconSize: 40,
    );
  }
}
