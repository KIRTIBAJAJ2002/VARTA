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
          Text(
            'The perfect Vartalaap, every time.',
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: width * (width > 600 ? 0.6 : 0.9),
            child: Text(
              'Varta. Conversations, elevated. Experience the art of refined communication, where every interaction is crafted to be seamless, sophisticated, and meaningful.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, height: 1.5, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
