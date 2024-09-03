import 'package:flutter/material.dart';

import 'package:user_application/pages/test_page.dart';
import 'package:user_application/pages/visa/additional_details.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/widgets/Button.dart';
import 'package:user_application/widgets/back_button.dart';
import 'package:user_application/widgets/progress.dart';
import 'package:user_application/widgets/select_field.dart';
import "package:user_application/widgets/input_field.dart";
import "package:user_application/widgets/country_picker.dart";

class ContactDetails extends StatefulWidget {
  const ContactDetails({super.key});

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  String? _email;
  String? _country;
  // String? _personal_country_code;
  // String? _personal_phone;
  // String? _whatsapp_country_code;
  // String? _whatsapp_phone;

  @override
  Widget build(BuildContext context) {
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
            _fields(),
            const SizedBox(height: 50),
            Button(
              text: "Next",
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new AdditionalDetails()),
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
          "Contact Details.",
          style: heading2Style,
        ),
        const SizedBox(height: 15),
        const ProgressBar(
          sizeCount: 6,
          progressCount: 4,
          size: 60,
        ),
      ],
    );
  }

  Column _fields() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InputField(
        label: "Email *",
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 30),
      CountryPicker(),
      const SizedBox(height: 30),
      InputField(
        label: "Call number",
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 30),
      InputField(
        label: "Whatsapp number",
        keyboardType: TextInputType.number,
      ),
    ]);
  }
}
