import 'package:flutter/material.dart';

class UseCasesSection extends StatelessWidget {
  const UseCasesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double containerWidth = width > 1200 ? 900 : width * 0.9;

    return Center(
      child: Container(
        width: containerWidth,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Use Cases',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.8, // Adjusted for better layout
              ),
              itemCount: 6, // Changed to 6 for a 3x2 grid
              itemBuilder: (context, index) {
                List<Map<String, String>> useCases = [
                  {
                    'title': 'Customer Service Automation',
                    'description': 'Automate customer support calls with AI-powered voice assistants.'
                  },
                  {
                    'title': 'Language Translation',
                    'description': 'Enable real-time language translation for global customer interactions.'
                  },
                  {
                    'title': 'Speech Analytics',
                    'description': 'Analyze customer calls to improve service quality and identify trends.'
                  },
                  {
                    'title': 'Voice-Activated Booking Systems',
                    'description': 'Implement voice-activated systems for booking appointments or services.'
                  },
                  {
                    'title': 'Personalized Voice Interactions',
                    'description': 'Provide personalized customer experiences through tailored voice interactions.'
                  },
                  {
                    'title': 'Virtual Assistants for Accessibility',
                    'description': 'Develop AI-powered virtual assistants to aid individuals with speech or hearing impairments.'
                  },
                ];
                return _buildUseCaseCard(useCases[index]['title']!, useCases[index]['description']!);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUseCaseCard(String title, String description) {
    return Card(
      elevation: 6, // Increased elevation for better depth effect
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Increased padding for better spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
                maxLines: 3, // Added maxLines to prevent overflow
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
