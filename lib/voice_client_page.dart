import 'package:flutter/material.dart';
import 'voice_client.dart';
import 'widgets/audio_button.dart'; // Adjust if needed

class VoiceClientPage extends StatefulWidget {
  const VoiceClientPage({super.key});

  @override
  State<VoiceClientPage> createState() => _VoiceClientPageState();
}

class _VoiceClientPageState extends State<VoiceClientPage> {
  final VoiceClient _client = VoiceClient();

  @override
  void initState() {
    super.initState();
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
          const SizedBox(height: 20),
          AudioButton(client: _client),
          const SizedBox(height: 20),
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: _client.messages,
              builder: (context, messages, _) {
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(messages[index]),
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
