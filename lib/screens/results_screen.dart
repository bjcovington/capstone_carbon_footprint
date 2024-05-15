import 'dart:math'; // Import the math library

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultsScreen extends StatefulWidget {
  final String selectedTransportation;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final double calculatedEmissions; // Define calculatedEmissions parameter

  ResultsScreen({
    @required this.selectedTransportation,
    @required this.startTime,
    @required this.endTime,
    @required this.calculatedEmissions, // Add calculatedEmissions parameter
  });

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool isKgSelected = true; // Flag to track whether kg is selected

  // Define a variable to store the unit for emissions display
  String _emissionsUnit = 'kg';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Harmful Emissions: ${_formattedEmissions()}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('lbs'),
                  Switch(
                    value: isKgSelected,
                    onChanged: (value) {
                      setState(() {
                        isKgSelected = value;
                        // Update the emissions unit based on the selected unit
                        _emissionsUnit = isKgSelected ? 'kg' : 'lbs';
                      });
                    },
                  ),
                  Text('kg'),
                ],
              ),
              SizedBox(height: 20),
              _buildComparisonChart(),
              SizedBox(height: 20),
              _buildEcoFriendlySuggestions(), // Add this line to include eco-friendly suggestions
            ],
          ),
        ),
      ),
    );
  }

  String _formattedEmissions() {
    // Convert emissions to selected unit
    double emissions = isKgSelected ? widget.calculatedEmissions : widget.calculatedEmissions * 0.453592; // Convert kg to lbs

    // Round emissions to 2 decimal places
    emissions = double.parse(emissions.toStringAsFixed(2));

    return '$emissions $_emissionsUnit'; // Display emissions with the selected unit
  }

  Widget _buildComparisonChart() {
    final Map<String, double> emissionsMap = {
      'Car': 0.592, // 592 grams per kilometer for cars
      'Bus': 0.822, // 822 grams per kilometer for buses
      'Bicycle/Walk': 0.0, // No emissions for bicycle and walking
      'Airplane': 1.101, // 101 grams per passenger-kilometer for airplanes
    };

    // Find the maximum emissions value to determine the scaling factor
    double maxEmissions = emissionsMap.values.reduce((value, element) => max(value, element));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: emissionsMap.entries.map((entry) {
        String transportation = entry.key;
        double emissions = entry.value;
        double scaledEmissions = maxEmissions != 0 ? log(emissions / maxEmissions) : 0; // Scale emissions using a logarithmic scale

        // Ensure that the scaled width is non-negative
        double barWidth = max(0, MediaQuery.of(context).size.width * scaledEmissions * 0.5); // Adjust the scaling factor as needed

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text(transportation),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 20,
                  width: barWidth,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 8),
              Text('${emissions.toStringAsFixed(2)}'),
            ],
          ),
        );
      }).toList(),
    );
  }



  double _calculateEmissions(double emissionsPerHour) {
    double timeDuration = 0.0;
    if (widget.startTime != null && widget.endTime != null) {
      final startTimeInMinutes = widget.startTime.hour * 60 + widget.startTime.minute;
      final endTimeInMinutes = widget.endTime.hour * 60 + widget.endTime.minute;
      timeDuration = (endTimeInMinutes - startTimeInMinutes) / 60.0; // Time duration in hours
    }

    // Conditionally calculate emissions based on the selected unit
    if (isKgSelected) {
      return emissionsPerHour * timeDuration;
    } else {
      return emissionsPerHour * timeDuration * 0.453592; // Convert kg to lbs
    }
  }

  Widget _buildEcoFriendlySuggestions() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Eco-Friendly Suggestions:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '1. Use public transportation or carpooling whenever possible to reduce emissions from individual vehicles.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '2. Consider walking or biking for short distances instead of driving.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '3. Choose eco-friendly modes of transportation such as electric vehicles or hybrid cars.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '4. Offset your carbon footprint by planting trees or supporting renewable energy projects.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
