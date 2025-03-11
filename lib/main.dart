import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'themes/theme.dart';
import 'navigation_bar.dart' as custom_navigation_bar;
import 'intro_section.dart';
import 'use_cases_section.dart';
import 'footer.dart'; // Importing Footer

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // Keys for sections
  final GlobalKey _introKey = GlobalKey();
  final GlobalKey _useCasesKey = GlobalKey();
  final GlobalKey _benchmarksKey = GlobalKey(); // Add this line


  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.backgroundGradient,
        child: CustomScrollView(
          controller: _scrollController, // Attach scroll controller
          slivers: [
            SliverToBoxAdapter(
              child: custom_navigation_bar.NavigationBar(
                onItemSelected: _scrollToSection, // Pass function to Navbar
                introKey: _introKey,
                useCasesKey: _useCasesKey,
                  benchmarksKey: _benchmarksKey, // Pass the new key

              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Lottie.asset('assets/varta1.json'),
                    const SizedBox(height: 40),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            print('Get Started');
                          },
                          child: const Text(
                            'Get Started',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        Lottie.asset('assets/wave.json', width: 200, height: 60),
                      ],
                    ),
                    const SizedBox(height: 40),
                    IntroSection(key: _introKey), // Assign key
                    const SizedBox(height: 20),
                    UseCasesSection(key: _useCasesKey), // Assign key
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: Footer()), // Footer remains unchanged
          ],
        ),
      ),
    );
  }
}
