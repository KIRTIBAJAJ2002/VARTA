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
              itemCount: 6, // Changed to 9 for a 3x3 grid
              itemBuilder: (context, index) {
                List<Map<String, String>> useCases = [
                  {'title': 'Data Analysis', 'description': 'Extract insights from datasets with AI-driven analytics.'},
                  {'title': 'Code Generation', 'description': 'Generate structured and optimized code snippets.'},
                  {'title': 'Research Assistance', 'description': 'Conduct thorough research and summarize findings.'},
                  {'title': 'Predictive Analytics', 'description': 'Forecast trends using AI and machine learning.'},
                  {'title': 'Automation', 'description': 'Automate repetitive tasks for enhanced productivity.'},
                  {'title': 'Content Creation', 'description': 'Generate engaging articles, blogs, and copies.'},
                  {'title': 'Customer Support', 'description': 'Deploy AI-powered chatbots for instant support.'},
                  {'title': 'Fraud Detection', 'description': 'Identify anomalies and detect fraudulent activities.'},
                  {'title': 'Cybersecurity', 'description': 'Enhance security with AI-driven threat detection.'},
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
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
