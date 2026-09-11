import 'package:flutter/material.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dodi Live"),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text(
          'مرحباً بك في تطبيق Dodi Live البث المباشر',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
