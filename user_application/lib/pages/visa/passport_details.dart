import 'package:flutter/material.dart';
import 'package:user_application/pages/visa/contact_details.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/widgets/Button.dart';
import 'package:user_application/widgets/back_button.dart';
import 'package:user_application/widgets/progress.dart';
import 'package:user_application/widgets/select_field.dart';
import "package:user_application/widgets/input_field.dart";

class PassportDetails extends StatefulWidget {
  const PassportDetails({super.key});

  @override
  State<PassportDetails> createState() => _PassportDetailsState();
}

class _PassportDetailsState extends State<PassportDetails> {
  String? _passport_name;
  String? _passport_number;
  String? _date_of_birth;
  // String? _valid_date;
  // String? _issued_date;
  String? _gender;

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
                print(_passport_name),
                print(_passport_number),
                print(_date_of_birth),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new ContactDetails()),
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
          "Passport Details.",
          style: heading2Style,
        ),
        const SizedBox(height: 15),
        const ProgressBar(
          sizeCount: 6,
          progressCount: 3,
          size: 60,
        ),
      ],
    );
  }

  Column _fields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputField(
          label: "Passport name *",
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 30),
        InputField(
          label: "Passport number *",
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 30),
        InputField(
          label: "Date of birth *",
          keyboardType: TextInputType.datetime,
        ),
        const SizedBox(height: 30),
        InputField(
          label: "Valid date *",
          keyboardType: TextInputType.datetime,
        ),
        const SizedBox(height: 30),
        InputField(
          label: "Issued date *",
          keyboardType: TextInputType.datetime,
        ),
        const SizedBox(height: 30),
        SelectField(
          label: "Gender *",
          options: ["Male", "Female"],
          onChanged: (newValue) {
            setState(() {
              _gender = newValue!;
            });
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
