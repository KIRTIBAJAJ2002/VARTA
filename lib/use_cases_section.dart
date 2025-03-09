import 'package:flutter/material.dart';

class UseCasesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center the heading
        children: [
          Text(
            'Use Cases',
            textAlign: TextAlign.center, // Ensure text is centered
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true, // Ensures GridView takes only required space
            physics: NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 4 boxes in a row
              crossAxisSpacing: 15, // Reduce spacing for compact look
              mainAxisSpacing: 15, // Reduce spacing for compact look
              childAspectRatio: 1.2, // Makes the cards smaller (Adjust as needed)
            ),
            itemCount: 8, // 8 boxes
            itemBuilder: (context, index) {
              List<Map<String, String>> useCases = [
                {'title': 'Data Analysis', 'description': 'Analyze datasets and generate insights.'},
                {'title': 'Code Generation', 'description': 'Generate code snippets and programs.'},
                {'title': 'Research Assistance', 'description': 'Conduct research and gather information.'},
                {'title': 'Predictive Analytics', 'description': 'Use AI to forecast trends.'},
                {'title': 'Automation', 'description': 'Streamline repetitive tasks and workflows.'},
                {'title': 'Content Creation', 'description': 'Generate articles and creative content.'},
                {'title': 'Customer Support', 'description': 'Provide AI-driven chatbots.'},
                {'title': 'Security & Fraud Detection', 'description': 'Detect anomalies and prevent fraud.'},
              ];
              
              return _buildUseCaseCard(
                title: useCases[index]['title']!,
                description: useCases[index]['description']!,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUseCaseCard({required String title, required String description}) {
    return Container(
      padding: EdgeInsets.all(10.0), // Reduce padding inside cards
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0), // Slightly smaller rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16, // Reduce title size
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5), // Reduce space between title and text
          Expanded(
            child: Text(
              description,
              style: TextStyle(fontSize: 12), // Reduce description font size
            ),
          ),
        ],
      ),
    );
  }
}
