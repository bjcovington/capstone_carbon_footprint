import 'package:flutter/material.dart';

class TimeRangePicker extends StatefulWidget {
  final Function(TimeOfDay, TimeOfDay) onChanged; // Callback function to notify parent about time changes

  TimeRangePicker({@required this.onChanged});

  @override
  _TimeRangePickerState createState() => _TimeRangePickerState();
}

class _TimeRangePickerState extends State<TimeRangePicker> {
  TimeOfDay _startTime = TimeOfDay(hour: 12, minute: 0); // Initialize with default start time
  TimeOfDay _endTime = TimeOfDay(hour: 14, minute: 0); // Initialize with default end time

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTimePicker('Start Time', _startTime, (time) {
          setState(() {
            _startTime = time;
            widget.onChanged(_startTime, _endTime); // Notify parent about time change
          });
        }),
        _buildTimePicker('End Time', _endTime, (time) {
          setState(() {
            _endTime = time;
            widget.onChanged(_startTime, _endTime); // Notify parent about time change
          });
        }),
      ],
    );
  }

  Widget _buildTimePicker(String label, TimeOfDay time, Function(TimeOfDay) onChanged) {
    return Column(
      children: [
        Text(label),
        SizedBox(height: 8),
        RaisedButton(
          onPressed: () {
            _selectTime(context, time, onChanged);
          },
          child: Text('${time.format(context)}'),
        ),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context, TimeOfDay initialTime, Function(TimeOfDay) onChanged) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      onChanged(pickedTime); // Notify parent about time change
    }
  }
}
