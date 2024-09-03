import 'package:flutter/material.dart';

import 'package:user_application/pages/test_page.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/widgets/Button.dart';
import 'package:user_application/widgets/back_button.dart';
import 'package:user_application/widgets/progress.dart';
import 'package:user_application/widgets/select_field.dart';
import "package:user_application/widgets/input_field.dart";

class AdditionalDetails extends StatefulWidget {
  const AdditionalDetails({super.key});

  @override
  State<AdditionalDetails> createState() => _AdditionalDetailsState();
}

class _AdditionalDetailsState extends State<AdditionalDetails> {
  String? _date_of_arrival;
  String? _port_entry;
  String? _resedential_address;
  String? _date_of_departure;

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
                  MaterialPageRoute(builder: (context) => new TestPage()),
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
          "Additional Details.",
          style: heading2Style,
        ),
        const SizedBox(height: 15),
        const ProgressBar(
          sizeCount: 6,
          progressCount: 5,
          size: 60,
        ),
      ],
    );
  }

  Column _fields() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InputField(
        label: "Date of arrival *",
        keyboardType: TextInputType.datetime,
      ),
      const SizedBox(height: 30),
      SelectField(
        label: "Port entry *",
        options: ["Colombo"],
        onChanged: (newValue) {
          setState(() {
            _port_entry = newValue!;
          });
        },
      ),
      const SizedBox(height: 30),
      InputField(
        label: "Resedential address *",
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 30),
      InputField(
        label: "Date of departure *",
        keyboardType: TextInputType.datetime,
      ),
    ]);
  }
}
