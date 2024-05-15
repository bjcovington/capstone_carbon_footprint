import 'package:flutter/material.dart';
import 'package:capstone/components/time_range_picker.dart';
import 'package:capstone/screens/results_screen.dart';

class TransportationInput extends StatefulWidget {
  @override
  _TransportationInputState createState() => _TransportationInputState();
}

class _TransportationInputState extends State<TransportationInput> {
  String _selectedTransportation;
  TimeOfDay _selectedStartTime = TimeOfDay(hour: 12, minute: 0); // Initialize with default start time
  TimeOfDay _selectedEndTime = TimeOfDay(hour: 14, minute: 0); // Initialize with default end time
  final List<String> _transportationOptions = [
    'Car',
    'Bus',
    'Airplane',
    'Bicycle',
    'Walk',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transportation:',
          style: TextStyle(fontSize: 16),
        ),
        DropdownButtonFormField(
          value: _selectedTransportation,
          onChanged: (value) {
            setState(() {
              _selectedTransportation = value;
            });
          },
          items: _transportationOptions.map((transportation) {
            return DropdownMenuItem(
              value: transportation,
              child: Text(transportation),
            );
          }).toList(),
          decoration: InputDecoration(
            hintText: 'Select transportation',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Time Range:',
          style: TextStyle(fontSize: 16),
        ),
        TimeRangePicker(
          onChanged: (startTime, endTime) {
            setState(() {
              _selectedStartTime = startTime;
              _selectedEndTime = endTime;
            });
          },
        ),
        SizedBox(height: 16),
        RaisedButton(
          onPressed: () {
            _calculateEmissions(); // Call the function to calculate emissions
          },
          child: Text('Calculate Emissions'),
        ),
      ],
    );
  }

  void _calculateEmissions() {
    double emissions = 0.0;

    // Calculate emissions based on selected transportation
    if (_selectedTransportation == 'Car') {
      emissions = 0.592; // 4 pounds per hour for an idling car
    } else if (_selectedTransportation == 'Bus') {
      emissions = 0.822; // Convert grams to kilograms (1 gram = 0.001 kilograms)
    } else if (_selectedTransportation == 'Bicycle' || _selectedTransportation == 'Walk') {
      emissions = 0.0; // No emissions for bicycle and walking
    } else if (_selectedTransportation == 'Airplane') {
      emissions = 1.101; // Emissions per passenger-mile for domestic flights in the US
    } else {
      // Handle other transportation types if needed
    }

    // Calculate time duration
    double timeDuration = 0.0;
    if (_selectedStartTime != null && _selectedEndTime != null) {
      final startTimeInMinutes = _selectedStartTime.hour * 60 + _selectedStartTime.minute;
      final endTimeInMinutes = _selectedEndTime.hour * 60 + _selectedEndTime.minute;
      timeDuration = (endTimeInMinutes - startTimeInMinutes) / 60.0; // Time duration in hours
    }

    // Multiply emissions per hour by time duration to get total emissions
    double calculatedEmissions = emissions * timeDuration;

    // Navigate to ResultsScreen and pass calculated emissions
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          selectedTransportation: _selectedTransportation,
          startTime: _selectedStartTime,
          endTime: _selectedEndTime,
          calculatedEmissions: calculatedEmissions,
        ),
      ),
    );
  }
}
