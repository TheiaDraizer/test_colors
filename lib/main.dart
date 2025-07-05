import 'package:flutter/material.dart';
import 'package:solid_software_test/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

/// The root widget
class MyApp extends StatelessWidget {
  /// The root widget constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solid Software Test',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
