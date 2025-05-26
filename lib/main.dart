import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'themes/theme.dart';
import 'navigation_bar.dart' as custom_navigation_bar;
import 'intro_section.dart';
import 'use_cases_section.dart';
import 'footer.dart';
import 'voice_client_page.dart'; // ✅ correct import
import 'benchmarks_page.dart'; // Import the BenchmarksSection

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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/assistant': (context) => const VoiceClientPage(), // ✅ Add this
      },
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
  final GlobalKey _benchmarksKey = GlobalKey();
  
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
          controller: _scrollController,
          slivers: [
            // Navigation Bar at the top
            SliverToBoxAdapter(
              child: custom_navigation_bar.NavigationBar(
                onItemSelected: _scrollToSection,
                introKey: _introKey,
                useCasesKey: _useCasesKey,
                benchmarksKey: _benchmarksKey, // Not used here since benchmarks is separate
              ),
            ),
            // Main content
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
                            // Navigate to transition page that briefly shows wave.json before AssistantPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WaveTransitionPage(),
                              ),
                            );
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
                    IntroSection(key: _introKey),
                    const SizedBox(height: 20),
                    UseCasesSection(key: _useCasesKey),
                    const SizedBox(height: 40),
                    // Benchmarks Section (inserted below Use Cases)
                    const BenchmarksSection(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            // Footer at the bottom
            const SliverToBoxAdapter(child: Footer()),
          ],
        ),
      ),
    );
  }
}

// Transition page that plays wave.json briefly before navigating to AssistantPage
class WaveTransitionPage extends StatefulWidget {
  const WaveTransitionPage({Key? key}) : super(key: key);
  
  @override
  _WaveTransitionPageState createState() => _WaveTransitionPageState();
}

class _WaveTransitionPageState extends State<WaveTransitionPage> {
  @override
  void initState() {
    super.initState();
    // Delay for 1000 milliseconds then navigate to AssistantPage
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacementNamed(context, '/assistant');
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/wave.json', width: 200, height: 60),
      ),
    );
  }
}
