import 'package:flutter/material.dart';

class LightCircle extends StatelessWidget {
  final Color color;
  final bool isActive;

  const LightCircle({
    required this.color,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? color : Colors.grey[800],
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: color.withOpacity(0.6),
                  blurRadius: 20,
                  spreadRadius: 10,
                )
              ]
            : [],
      ),
    );
  }
}
