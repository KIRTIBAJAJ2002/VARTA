import 'package:flutter/material.dart';

class IntroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center( // This will center the entire content in the available space
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // Set max width for better readability
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensures it takes only necessary space
          crossAxisAlignment: CrossAxisAlignment.center, // Center the text horizontally
          children: [
            const Text(
              'Introduction to Varta',
              textAlign: TextAlign.center, // Ensure text is centered
              style: TextStyle(
                fontSize: 31,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Varta is a cutting-edge AI solution designed to revolutionize how businesses operate. Varta integrates advanced machine learning algorithms and real-time data processing to deliver insights and automation. It can adapt to various business environments. It enhances decision-making and streamlines operations.',
              textAlign: TextAlign.center, // Center the text
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
