import 'package:flutter/material.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({Key? key}) : super(key: key); // Accepting key

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
          const Text(
            'Leave it to Varta',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: width * (width > 600 ? 0.6 : 0.9),
            child: const Text(
              'Varta is a general AI agent that bridges minds and actions, delivering results efficiently.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
