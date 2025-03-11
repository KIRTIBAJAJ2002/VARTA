import 'package:flutter/material.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: width > 600 ? 100 : 50,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome to Varta',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: width * (width > 600 ? 0.6 : 0.9),
            child: Text(
              'Varta is a general AI agent that bridges minds and actions, delivering results efficiently.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, height: 1.5, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
