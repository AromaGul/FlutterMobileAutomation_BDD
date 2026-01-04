import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const NativeDemoApp());
}

class NativeDemoApp extends StatelessWidget {
  const NativeDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Demo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: HomeScreen(),
    );
  }
}
