import 'package:flutter/material.dart';
import 'input_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background_image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay with Opacity
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or App Title
                Image.asset(
                  'assets/app_logo.png',
                  height: 150,
                ),
                SizedBox(height: 20),
                // Tagline
                Text(
                  'Empowering You to\nReduce Your Carbon Footprint',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                // Animated Button
                TweenAnimationBuilder(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  builder: (BuildContext context, double value, Widget child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0.0, 50 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InputScreen()),
                      );
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}