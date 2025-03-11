import 'package:flutter/material.dart';

class UseCasesSection extends StatelessWidget {
  const UseCasesSection({Key? key}) : super(key: key); // Accepting key

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double containerWidth = width > 1200 ? 1000 : width * 0.9;
    int crossAxisCount = 4; // Always 4 columns

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
                crossAxisCount: 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.7, // Vertical rectangle (height > width)
              ),
              itemCount: 8,
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
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
