import 'package:flutter/material.dart';
import 'package:user_application/pages/test_page.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/widgets/Button.dart';
import 'package:user_application/widgets/back_button.dart';
import 'package:user_application/widgets/progress.dart';
import 'package:user_application/widgets/select_field.dart';

class EligibilityCriteriaPage extends StatefulWidget {
  const EligibilityCriteriaPage({super.key});

  @override
  State<EligibilityCriteriaPage> createState() =>
      _EligibilityCriteriaPageState();
}

class _EligibilityCriteriaPageState extends State<EligibilityCriteriaPage> {
  String? _nationality;
  String? _residence;
  String? _visa_type;
  String? _visa_category;
  String? _purpose;
  String? _sub_visa_type;
  String? _travel_document;

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
                print(_nationality),
                print(_residence),
                print(_visa_type),
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
          "Eligibility criteria.",
          style: heading2Style,
        ),
        const SizedBox(height: 15),
        const ProgressBar(
          sizeCount: 6,
          progressCount: 1,
          size: 60,
        ),
      ],
    );
  }

  Column _fields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectField(
          label: "Nationality *",
          options: const ["Resr"],
          onChanged: (newValue) {
            setState(() {
              _nationality = newValue!;
            });
          },
          value: _nationality,
        ),
        const SizedBox(height: 30),
        SelectField(
          label: "Country of residence *",
          options: const ["Resr"],
          onChanged: (newValue) {
            setState(() {
              _residence = newValue!;
            });
          },
          value: _residence,
        ),
        const SizedBox(height: 30),
        SelectField(
          label: "Visa-type *",
          options: const ["Resr"],
          onChanged: (newValue) {
            setState(() {
              _visa_type = newValue!;
            });
          },
          value: _visa_type,
        ),
        const SizedBox(height: 30),
        SelectField(
          label: "Visa-Category *",
          options: const ["Resr"],
          onChanged: (newValue) {
            setState(() {
              _visa_category = newValue!;
            });
          },
          value: _visa_category,
        ),
        const SizedBox(height: 30),
        SelectField(
          label: "Purpose of travel *",
          options: const ["Resr"],
          onChanged: (newValue) {
            setState(() {
              _purpose = newValue!;
            });
          },
          value: _purpose,
        ),
        const SizedBox(height: 30),
        SelectField(
          label: "Sub-Visa type *",
          options: const ["Resr"],
          onChanged: (newValue) {
            setState(() {
              _sub_visa_type = newValue!;
            });
          },
          value: _sub_visa_type,
        ),
        const SizedBox(height: 30),
        SelectField(
          label: "Type of travel Document *",
          options: const ["Resr"],
          onChanged: (newValue) {
            setState(() {
              _travel_document = newValue!;
            });
          },
          value: _travel_document,
        ),
      ],
    );
  }
}
