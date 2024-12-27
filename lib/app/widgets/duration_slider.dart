import 'package:flutter/material.dart';

class DurationSlider extends StatelessWidget {
  final String label;
  final int duration;
  final ValueChanged<int> onChanged;

  const DurationSlider({
    required this.label,
    required this.duration,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label Light Duration: ${duration ~/ 1000} sec',
          style: TextStyle(fontSize: 18),
        ),
        Slider(
          value: duration.toDouble(),
          min: 1000,
          max: 10000,
          divisions: 9,
          label: '${duration ~/ 1000} sec',
          onChanged: (value) {
            onChanged(value.toInt());
          },
        ),
      ],
    );
  }
}
