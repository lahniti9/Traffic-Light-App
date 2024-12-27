import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final int redDuration;
  final int yellowDuration;
  final int greenDuration;

  const SettingsScreen({
    Key? key,
    required this.redDuration,
    required this.yellowDuration,
    required this.greenDuration,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _redController;
  late TextEditingController _yellowController;
  late TextEditingController _greenController;

  @override
  void initState() {
    super.initState();
    _redController = TextEditingController(text: widget.redDuration.toString());
    _yellowController = TextEditingController(text: widget.yellowDuration.toString());
    _greenController = TextEditingController(text: widget.greenDuration.toString());
  }

  void _saveSettings() {
    try {
      final redDuration = int.parse(_redController.text);
      final yellowDuration = int.parse(_yellowController.text);
      final greenDuration = int.parse(_greenController.text);

      if (redDuration <= 0 || yellowDuration <= 0 || greenDuration <= 0) {
        _showErrorDialog('Durations must be greater than 0.');
        return;
      }

      Navigator.pop(context, {
        'red': redDuration,
        'yellow': yellowDuration,
        'green': greenDuration,
      });
    } catch (e) {
      _showErrorDialog('Please enter valid numeric values.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDurationField('Red Duration (ms)', _redController),
            _buildDurationField('Yellow Duration (ms)', _yellowController),
            _buildDurationField('Green Duration (ms)', _greenController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSettings,
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
    );
  }

  @override
  void dispose() {
    _redController.dispose();
    _yellowController.dispose();
    _greenController.dispose();
    super.dispose();
  }
}
