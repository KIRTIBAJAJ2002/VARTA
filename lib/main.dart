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
            child: Lottie.asset('assets/varta1.json'),
          ),
        ),
      ),
    );
  }
}
