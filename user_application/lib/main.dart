import 'package:flutter/material.dart';
import 'package:user_application/widgets/button.dart';
import 'package:user_application/styles/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Components",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: primaryColor,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Button(text: "Primary Button"),
            )
          ],
        ),
      ),
    );
  }
}
