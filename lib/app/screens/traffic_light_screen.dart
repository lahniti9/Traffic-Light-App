import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/traffic_light_widget.dart';
import '../services/timer_service.dart';

class TrafficLightScreen extends StatefulWidget {
  @override
  _TrafficLightScreenState createState() => _TrafficLightScreenState();
}

class _TrafficLightScreenState extends State<TrafficLightScreen> {
  String _currentLight = 'red'; // Start with the red light
  late TimerService _timerService;
  Timer? _countdownTimer; // Use Timer? to avoid late initialization error
  Color _backgroundColor = Colors.red.withOpacity(0.3);
  Color _appBarColor = Colors.red; // Start with red AppBar color

  int _redDuration = 30000; // 5 seconds
  int _yellowDuration = 10000; // 2 seconds
  int _greenDuration = 30000; // 5 seconds

  int _remainingTime =
      0; // This will store the remaining time for the current light

  @override
  void initState() {
    super.initState();
    _timerService = TimerService(
      redDuration: _redDuration,
      yellowDuration: _yellowDuration,
      greenDuration: _greenDuration,
      onLightChange: _updateLight,
      onRemainingTimeChange: (int remaining) {},
    );
    _timerService.startTrafficLightCycle();

    _startCountdown(_redDuration); // Start countdown with red light duration
  }

  // Method to update the traffic light color and start a countdown
  void _updateLight(String light) {
    setState(() {
      _currentLight = light;
      if (_currentLight == 'red') {
        _backgroundColor = Colors.red.withOpacity(0.3);
        _appBarColor = Colors.red;
        _startCountdown(_redDuration); // Start countdown for red light
      } else if (_currentLight == 'yellow') {
        _backgroundColor = Colors.yellow.withOpacity(0.3);
        _appBarColor = Colors.yellow;
        _startCountdown(_yellowDuration); // Start countdown for yellow light
      } else if (_currentLight == 'green') {
        _backgroundColor = Colors.green.withOpacity(0.3);
        _appBarColor = Colors.green;
        _startCountdown(_greenDuration); // Start countdown for green light
      }
    });
  }

  // Method to start the countdown timer
  void _startCountdown(int duration) {
    // Cancel the existing countdown timer if it exists
    _countdownTimer?.cancel();

    setState(() {
      _remainingTime = duration ~/ 1000; // Convert milliseconds to seconds
    });

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _countdownTimer?.cancel(); // Stop countdown when time is up
      }
    });
  }

  void _openSettings() {
    showDialog(
      context: context,
      builder: (context) {
        int redDuration = _redDuration ~/ 1000; // Convert to seconds
        int yellowDuration = _yellowDuration ~/ 1000;
        int greenDuration = _greenDuration ~/ 1000;

        return AlertDialog(
          backgroundColor:
              Colors.blueGrey[50], // Light background for the dialog
          title: const Text(
            'Set Duration for Each Light',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Vibrant title color
            ),
            textAlign: TextAlign.center,
          ),
          content: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background for content section
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Red Light Duration (in seconds)',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.black, // Red text for red duration
                    ),
                  ),
                  _buildDurationField('Red Duration', redDuration, (value) {
                    redDuration = value;
                  }),
                  SizedBox(height: 16), // Adds more space between fields

                  Text(
                    'Yellow Light Duration (in seconds)',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.black, // Yellow text for yellow duration
                    ),
                  ),
                  _buildDurationField('Yellow Duration', yellowDuration,
                      (value) {
                    yellowDuration = value;
                  }),
                  SizedBox(height: 16), // Adds more space between fields

                  Text(
                    'Green Light Duration (in seconds)',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.black, // Green text for green duration
                    ),
                  ),
                  _buildDurationField('Green Duration', greenDuration, (value) {
                    greenDuration = value;
                  }),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _redDuration = redDuration * 1000;
                  _yellowDuration = yellowDuration * 1000;
                  _greenDuration = greenDuration * 1000;
                  // Restart the timer with the updated durations
                  _timerService = TimerService(
                    redDuration: _redDuration,
                    yellowDuration: _yellowDuration,
                    greenDuration: _greenDuration,
                    onLightChange: _updateLight,
                    onRemainingTimeChange: (int remaining) {},
                  );
                  _timerService.startTrafficLightCycle();
                  // Restart the countdown timer for the current light
                  _startCountdown(_redDuration); // Start with red duration
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDurationField(
      String label, int initialValue, Function(int) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label),
        controller: TextEditingController(text: initialValue.toString()),
        onChanged: (value) {
          int newValue = int.tryParse(value) ?? initialValue;
          onChanged(newValue);
        },
      ),
    );
  }

  @override
  void dispose() {
    _timerService.stopTimer();
    _countdownTimer?.cancel(); // Cancel countdown timer when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appBarColor,
        title: Text(
          'Traffic Light Simulation',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, size: 30),
            onPressed: _openSettings, // Open settings when clicked
          ),
        ],
      ),
      body: TrafficLightWidget(
        currentLight: _currentLight,
        backgroundColor: _backgroundColor, // Pass the background color
        remainingTime: _remainingTime, // Display remaining time
      ),
    );
  }
}
