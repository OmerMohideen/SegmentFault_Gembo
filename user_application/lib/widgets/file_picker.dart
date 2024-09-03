import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:user_application/styles/colors.dart';
import 'package:user_application/styles/fonts.dart';

class FileSelect extends StatelessWidget {
  final String title;
  final String maxFileSize;
  final Function(File?) onFilePicked;

  const FileSelect({
    super.key,
    required this.title,
    required this.maxFileSize,
    required this.onFilePicked,
  });

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      File file = File(result.files.single.path!);
      onFilePicked(file);
    } else {
      onFilePicked(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: paragraph2Style),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _pickFile(context),
          child: Container(
            width: double.infinity,
            height: 177,
            decoration: BoxDecoration(
              color: primarySubtleColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Tap to choose image file',
                    style: paragraph1Style.copyWith(color: primaryColor),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    maxFileSize,
                    style: paragraph1Style.copyWith(color: grayColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
