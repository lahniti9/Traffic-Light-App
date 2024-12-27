import 'package:flutter/material.dart';
import 'package:traffic_light_simulation/app/screens/SplashScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Traffic Light App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(), // Start with the splash screen
    );
  }
}
