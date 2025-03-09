import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'themes/theme.dart';
import 'navigation_bar.dart' as custom_navigation_bar;
import 'intro_section.dart'; // Import the intro section
import 'use_cases_section.dart'; // Import the use cases section

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Varta',
      theme: AppTheme.theme,
      home: Scaffold(
        body: Container(
          decoration: AppTheme.backgroundGradient,
          child: SingleChildScrollView(
            child: Column(
              children: [
                custom_navigation_bar.NavigationBar(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/varta1.json'),
                        const SizedBox(height: 40),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                print('Get Started');
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.all(0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Get Started ',
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                            Lottie.asset(
                              'assets/wave.json',
                              width: 200,
                              height: 60,
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        IntroSection(), // Add the intro section
                        SizedBox(height: 20),
                        UseCasesSection(), // Add the use cases section
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
