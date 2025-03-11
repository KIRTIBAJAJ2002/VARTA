import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Get in Touch', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('Have questions? We’d love to hear from you!', textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.email),
              SizedBox(width: 10),
              Text('contact@varta.com'),
            ],
          ),
          const SizedBox(height: 20),
          const Text('© 2024 Varta. All Rights Reserved.', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
