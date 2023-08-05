import 'package:flutter/material.dart';

// error screen in case some error occur
class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        error,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
