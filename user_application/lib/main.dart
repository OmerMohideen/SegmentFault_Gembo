import 'package:flutter/material.dart';
import 'package:user_application/styles/colors.dart';
import 'package:user_application/widgets/Button.dart';
import 'package:user_application/widgets/back_button.dart';
import 'package:user_application/widgets/input_field.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? selectedValue;
  final List<String> dropdownOptions = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Components",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DripBackButton(),
            SizedBox(height: 25),
            Button(text: "Primary Button"),
            SizedBox(height: 25),
            Button(text: "Secondary Button", secondary: true),
            SizedBox(height: 25),
            InputField(
              label: "Input Label",
              keyboardType: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }
}
