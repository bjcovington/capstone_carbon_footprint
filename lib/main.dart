import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(EnvironmentalFootprintApp());
}

class EnvironmentalFootprintApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Environmental Footprint Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green, // Set your primary color
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
