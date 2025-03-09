import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VARTA',
      theme: AppTheme.theme,
      home: Scaffold(
        body: Container(
          decoration: AppTheme.backgroundGradient,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/varta1.json'),
                const SizedBox(height: 40), // Add some space between the animation and the button
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        // Handle button press here
                        print('Get Started');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent, // Make the button background transparent
                        shadowColor: Colors.transparent, // Remove the default shadow
                        padding: const EdgeInsets.all(0), // Remove default padding
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Make the tap target as small as possible
                      ),
                      child: const Text(
                        'Get Started ',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Lottie.asset(
                      'assets/wave.json', // Use your Lottie file for the button background
                      width: 200, // Adjust the width to fit your button size
                      height: 60, // Adjust the height to fit your button size
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
