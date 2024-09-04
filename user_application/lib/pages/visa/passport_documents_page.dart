import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_application/pages/visa/passport_details_page.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/utils/form_handler.dart';
import 'package:user_application/widgets/Button.dart';
import 'package:user_application/widgets/back_button.dart';
import 'package:user_application/widgets/file_picker.dart';
import 'package:user_application/widgets/progress.dart';

class PassportDocumentsPage extends StatefulWidget {
  const PassportDocumentsPage({super.key});

  @override
  State<PassportDocumentsPage> createState() => _PassportDocumentsPageState();
}

class _PassportDocumentsPageState extends State<PassportDocumentsPage> {

  @override
  Widget build(BuildContext context) {
    final formHandler = Provider.of<FormHandler>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _head(),
            const SizedBox(height: 50),
            _progress(),
            const SizedBox(height: 50),
            _fields(formHandler),
            const SizedBox(height: 50),
            Button(
              text: "Next",
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new PassportDetailsPage()),
                )
              },
            )
          ],
        ),
      ),
    );
  }

  Row _head() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DripBackButton(
          onTap: () => {
            if (Navigator.canPop(context)) {Navigator.pop(context)}
          },
        ),
        const SizedBox(width: 20),
        Text(
          "Apply For Visa.",
          style: heading1Style,
        ),
      ],
    );
  }

  Column _progress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Documents.",
          style: heading2Style,
        ),
        const SizedBox(height: 15),
        const ProgressBar(
          sizeCount: 5,
          progressCount: 2,
          size: 72,
        ),
      ],
    );
  }

  Column _fields(FormHandler formHandler) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FileSelect(
          title: "Passport Bio page *",
          maxFileSize: 'Max file size: 2 MB',
          onFilePicked: (File? file) {
            if (file != null) {
              print('File picked: ${file.path}');
              formHandler.setFile("passport_bio", file);
            }
          }
        ),
        SizedBox(height: 30),
        FileSelect(
            title: "Invitational Letter *",
            maxFileSize: 'Max file size: 2 MB',
            onFilePicked: (File? file) {
              if (file != null) {
                print('File picked: ${file.path}');
                formHandler.setFile("invite_letter", file);
              }
            }
        ),
        SizedBox(height: 30),
        FileSelect(
            title: "Additional Documents",
            maxFileSize: 'Max file size: 2 MB',
            onFilePicked: (File? file) {
              if (file != null) {
                print('File picked: ${file.path}');
                formHandler.setFile("add_docs", file);
              }
            }
        ),
      ],
    );
  }
}
