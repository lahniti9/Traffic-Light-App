class TrafficLight {
  String currentLight;
  final int redDuration;
  final int yellowDuration;
  final int greenDuration;

  TrafficLight({
    this.currentLight = 'red',
    required this.redDuration,
    required this.yellowDuration,
    required this.greenDuration,
  });

  void updateLight(String light) {
    currentLight = light;
  }

  Map<String, dynamic> toMap() {
    return {
      'currentLight': currentLight,
      'redDuration': redDuration,
      'yellowDuration': yellowDuration,
      'greenDuration': greenDuration,
    };
  }

  factory TrafficLight.fromMap(Map<String, dynamic> map) {
    return TrafficLight(
      currentLight: map['currentLight'] ?? 'red',
      redDuration: map['redDuration'],
      yellowDuration: map['yellowDuration'],
      greenDuration: map['greenDuration'],
    );
  }
}
