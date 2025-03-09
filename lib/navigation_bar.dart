import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical:12,horizontal: 40),
      color: Colors.white,
      child: Center(  // Wrap the content in a Center widget
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,  // Center the content horizontally
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenuItem('Intro'),
            SizedBox(width: 20),
            _buildMenuItem('Use cases'),
            SizedBox(width: 20),
            _buildMenuItem('Benchmarks'),
            SizedBox(width: 20),
            _buildNotificationIcon(),
            SizedBox(width: 20),
            _buildCenteredGetStartedButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String text) {
    return InkWell(
      onTap: () {
        // Add navigation logic here
        print('$text tapped');
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return IconButton(
      icon: Stack(
        children: [
          Icon(Icons.notifications),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: Text(
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
      onPressed: () {
        // Add notification logic here
      },
    );
  }

  Widget _buildCenteredGetStartedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add "Get Started" logic here
        print('Get Started');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Make the button rounded
        ),
      ),
      child: Text('Get Started'),
    );
  }
}
