import 'package:flutter/material.dart';
import 'light_circle.dart';

class TrafficLightWidget extends StatelessWidget {
  final String currentLight;
  final Color backgroundColor;
  final int remainingTime; // Add remaining time for the counter

  const TrafficLightWidget({
    required this.currentLight,
    required this.backgroundColor,
    required this.remainingTime, // Pass the remaining time to the widget
  });

  @override
  Widget build(BuildContext context) {
    // Determine text color based on the current light
    Color textColor = _getTextColorForLight(currentLight);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: backgroundColor, // Set background color dynamically
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Traffic Light Container
            Container(
              width: 120, // Set width for the traffic light container
              decoration: BoxDecoration(
                color: Colors.black, // Black background
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LightCircle(
                    color: Colors.red,
                    isActive: currentLight == 'red',
                  ),
                  SizedBox(height: 10),
                  LightCircle(
                    color: Colors.yellow,
                    isActive: currentLight == 'yellow',
                  ),
                  SizedBox(height: 10),
                  LightCircle(
                    color: Colors.green,
                    isActive: currentLight == 'green',
                  ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 40,
              color: Colors.grey[800], // Pole color
            ),

            // Time Remaining Counter with dynamic text color
            Container(
              width: 100,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black, // Black background for the counter
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: Center(
                child: Text(
                  '$remainingTime s', // Show remaining time
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color:
                        textColor, // Set text color based on the current light
                  ),
                ),
              ),
            ),

            // Traffic Light Pole
            Container(
              width: 20,
              height: 300,
              color: Colors.grey[800], // Pole color
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to determine the text color based on the current light
  Color _getTextColorForLight(String light) {
    switch (light) {
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      default:
        return Colors.white; // Default to white if no valid light
    }
  }
}
