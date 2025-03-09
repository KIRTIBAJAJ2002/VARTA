import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AppTheme {
  /// **🌟 Main Theme Configuration**
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.transparent, // Allows global gradient background
      primarySwatch: Colors.purple,
      fontFamily: 'Poppins', // Set global font

      /// **🌟 Text Theme (Basic Styling)**
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  /// **🎨 Global Diagonal Gradient Background**
  static BoxDecoration get backgroundGradient {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white,
          Color.fromARGB(255, 226, 214, 245), // Light Purple
          Color.fromARGB(255, 245, 212, 242), // Soft Pink
          Color.fromARGB(255, 247, 255, 177), // Light Purple
          Colors.white,
        ],
      ),
      backgroundBlendMode: BlendMode.softLight, // Soft effect
    );
  }
}
