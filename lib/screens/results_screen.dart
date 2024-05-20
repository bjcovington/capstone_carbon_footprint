import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultsScreen extends StatefulWidget {
  final String selectedTransportation;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final double calculatedEmissions;

  ResultsScreen({
    @required this.selectedTransportation,
    @required this.startTime,
    @required this.endTime,
    @required this.calculatedEmissions,
  });

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool isKgSelected = true;
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
              _buildEcoFriendlySuggestions(),
            ],
          ),
        ),
      ),
    );
  }

  String _formattedEmissions() {
    double emissions = isKgSelected ? widget.calculatedEmissions : widget.calculatedEmissions / 0.453592;
    emissions = double.parse(emissions.toStringAsFixed(2));
    return '$emissions $_emissionsUnit';
  }

  Widget _buildComparisonChart() {
    final Map<String, double> emissionsMapKg = {
      'Car': 0.592,
      'Bus': 0.822,
      'Bicycle/Walk': 0.0,
      'Airplane': 1.101,
    };

    final Map<String, double> emissionsMapLbs = emissionsMapKg.map((key, value) {
      return MapEntry(key, value / 0.453592);
    });

    final emissionsMap = isKgSelected ? emissionsMapKg : emissionsMapLbs;
    double maxEmissions = emissionsMap.values.reduce(max);

    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth * 0.8;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: emissionsMap.entries.map((entry) {
            String transportation = entry.key;
            double emissions = entry.value;
            double scaledEmissions = maxEmissions != 0 ? (emissions / maxEmissions) : 0;

            double barWidth = maxWidth * scaledEmissions;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 80, // Fixed width for labels
                    child: Text(transportation),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: (scaledEmissions * 100).round(),
                    child: Container(
                      height: 20,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 50, // Fixed width for emission values
                    child: Text('${emissions.toStringAsFixed(2)} $_emissionsUnit'),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
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
