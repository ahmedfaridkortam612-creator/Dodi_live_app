import 'package:flutter/material.dart';
import 'auth_screen.dart';

void main() {
  runApp(const DodiLiveApp());
}

class DodiLiveApp extends StatelessWidget {
  const DodiLiveApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dodi Live',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.pink,
      ),
      home: const AuthScreen(),
    );
  }
}
