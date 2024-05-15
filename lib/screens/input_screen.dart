import 'package:flutter/material.dart';
import 'package:capstone/components/transportation_input.dart';
import 'package:capstone/components/activity_card.dart';
import 'package:capstone/components/result_card.dart'; // Import other activity input components as needed

class InputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Screen'),
      ),
      body: Center( // Center vertically
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ActivityCard(
                title: 'Transportation',
                content: TransportationInput(), // Use TransportationInput widget from the component
              ),
              // Add more ActivityCard instances for other activities
            ],
          ),
        ),
      ),
    );
  }
}
