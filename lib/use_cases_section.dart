import 'package:flutter/material.dart';

class UseCasesSection extends StatelessWidget {
  const UseCasesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double width = MediaQuery.of(context).size.width;
    // Set container width: on larger screens, use a fixed width; on smaller screens, use a percentage of screen width
    double containerWidth = width > 1200 ? 900 : width * 0.9;
    
    // Determine grid columns based on screen width
    int crossAxisCount;
    if (width < 600) {
      crossAxisCount = 1; // Mobile: stack the cards
    } else if (width < 1200) {
      crossAxisCount = 2; // Tablet: 2 columns
    } else {
      crossAxisCount = 3; // Desktop: 3 columns (same as current)
    }
    
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.8, // Vertical rectangle shape
              ),
              itemCount: 6,
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
                return _buildUseCaseCard(
                  useCases[index]['title']!,
                  useCases[index]['description']!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUseCaseCard(String title, String description) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
