import 'dart:async';

class TimerService {
  Timer? _timer;
  final int redDuration;
  final int yellowDuration;
  final int greenDuration;
  final void Function(String) onLightChange;

  TimerService({
    required this.redDuration,
    required this.yellowDuration,
    required this.greenDuration,
    required this.onLightChange, required void Function(int remaining) onRemainingTimeChange,
  });

  void startTrafficLightCycle() {
    _timer?.cancel();
    _startRedLight();
  }

  void _startRedLight() {
    onLightChange('red');
    _timer = Timer(Duration(milliseconds: redDuration), _startYellowLight);
  }

  void _startYellowLight() {
    onLightChange('yellow');
    _timer = Timer(Duration(milliseconds: yellowDuration), _startGreenLight);
  }

  void _startGreenLight() {
    onLightChange('green');
    _timer = Timer(Duration(milliseconds: greenDuration), _startRedLight);
  }

  void stopTimer() {
    _timer?.cancel();
  }
}
