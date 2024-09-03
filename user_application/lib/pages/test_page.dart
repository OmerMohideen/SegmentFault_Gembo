import 'dart:io';

import 'package:flutter/material.dart';
import 'package:user_application/styles/colors.dart';
import 'package:user_application/widgets/Button.dart';
import 'package:user_application/widgets/back_button.dart';
import 'package:user_application/widgets/file_picker.dart';
import 'package:user_application/widgets/input_field.dart';
import 'package:user_application/widgets/progress.dart';
import 'package:user_application/widgets/radio_button.dart';
import 'package:user_application/widgets/select_field.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String? selectedValue;
  bool isSelected1 = true;
  bool isSelected2 = false;
  final List<String> dropdownOptions = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Components",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DripBackButton(
              onTap: () => {
                if (Navigator.canPop(context)) {Navigator.pop(context)}
              },
            ),
            const SizedBox(height: 25),
            const Button(text: "Primary Button"),
            const SizedBox(height: 25),
            const Button(text: "Secondary Button", secondary: true),
            const SizedBox(height: 25),
            const InputField(
              label: "Input Label",
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 25),
            SelectField(
                label: "Select Option",
                options: dropdownOptions,
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                }),
            const SizedBox(height: 25),
            RadioButton(
              label: "Radio option here...",
              selected: isSelected1,
              onChanged: (value) {
                setState(() {
                  isSelected1 = true;
                  isSelected2 = false;
                });
              },
            ),
            const SizedBox(height: 16),
            RadioButton(
              label: "Radio option here...",
              selected: isSelected2,
              onChanged: (value) {
                setState(() {
                  isSelected2 = true;
                  isSelected1 = false;
                });
              },
            ),
            const SizedBox(height: 25),
            const ProgressBar(
              progressCount: 1,
              sizeCount: 4,
              size: 92,
            ),
            const SizedBox(height: 25),
            FileSelect(
              title: 'Passport Bio page',
              maxFileSize: 'Max file size: 2 MB',
              onFilePicked: (File? file) {
                if (file != null) {
                  print('File picked: ${file.path}');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
