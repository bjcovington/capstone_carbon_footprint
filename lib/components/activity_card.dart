import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final Widget content;

  ActivityCard({@required this.title, @required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            content,
          ],
        ),
      ),
    );
  }
}
