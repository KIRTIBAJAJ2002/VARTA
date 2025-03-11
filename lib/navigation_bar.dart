import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  final Function(GlobalKey) onItemSelected;
  final GlobalKey introKey;
  final GlobalKey useCasesKey;
  final GlobalKey benchmarksKey;

  const NavigationBar({
    Key? key,
    required this.onItemSelected,
    required this.introKey,
    required this.useCasesKey,
    required this.benchmarksKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 768;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: isMobile ? 20 : 40,
          ),
          color: Colors.white,
          child: isMobile
              ? _buildMobileNav()
              : _buildDesktopNav(),
        );
      },
    );
  }

  Widget _buildMobileNav() {
    return Column(
      children: [
        _buildMenuItem('About us', introKey),
        _buildMenuItem('Use Cases', useCasesKey),
        _buildMenuItem('Benchmarks', benchmarksKey),
        _buildNotificationIcon(),
        _buildCenteredGetStartedButton(null),
      ].map((child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: child,
          )).toList(),
    );
  }

  Widget _buildDesktopNav() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem('About us', introKey),
          _buildMenuItem('Use Cases', useCasesKey),
          _buildMenuItem('Benchmarks', benchmarksKey),
          _buildNotificationIcon(),
          _buildCenteredGetStartedButton(null),
        ].map((child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: child,
            )).toList(),
      ),
    );
  }

  Widget _buildMenuItem(String text, GlobalKey key) {
    return InkWell(
      onTap: () => onItemSelected(key),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return IconButton(
      icon: Stack(
        children: [
          const Icon(Icons.notifications),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: const BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: const Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      onPressed: () {},
    );
  }

  Widget _buildCenteredGetStartedButton(BuildContext? context) {
    return ElevatedButton(
      onPressed: () => print('Contact us'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text('Contact us'),
    );
  }
}
