import 'package:flutter/material.dart';
import 'voice_client.dart';
import 'widgets/audio_button.dart';

class VoiceClientPage extends StatefulWidget {
  const VoiceClientPage({super.key});

  @override
  State<VoiceClientPage> createState() => _VoiceClientPageState();
}

class _VoiceClientPageState extends State<VoiceClientPage> {
  late final VoiceClient _client;

  @override
  void initState() {
    super.initState();
    _client = VoiceClient();
    _client.connect();
  }

  @override
  void dispose() {
    _client.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Varta Assistant')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          AudioButton(client: _client),
          const SizedBox(height: 16),
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: _client.messages,
              builder: (context, messages, _) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        messages[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
