import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_application/pages/visa/contact_details.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/utils/form_handler.dart';
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
  final _formKey = GlobalKey<FormState>();

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
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new ContactDetails()),
                  )
                }
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
          sizeCount: 5,
          progressCount: 3,
          size: 72,
        ),
      ],
    );
  }

  Form _fields(FormHandler formHandler) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputField(
            label: "Passport name *",
            keyboardType: TextInputType.text,
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("passport_name", newValue);
              });
            },
            initialValue: formHandler.getFieldValue("passport_name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your passport name';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          InputField(
            label: "Passport number *",
            keyboardType: TextInputType.number,
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("passport_number", newValue);
              });
            },
            initialValue: formHandler.getFieldValue("passport_number"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your passport number';
              }
              if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                return 'Passport number should be alphanumeric';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          InputField(
            label: "Date of birth *",
            keyboardType: TextInputType.datetime,
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("dob", newValue);
              });
            },
            initialValue: formHandler.getFieldValue("dob"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your date of birth';
              }
              if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
                return 'Please enter a valid date (DD/MM/YYYY)';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          InputField(
            label: "Valid date *",
            keyboardType: TextInputType.datetime,
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("valid_date", newValue);
              });
            },
            initialValue: formHandler.getFieldValue("valid_date"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the passport\'s valid date';
              }
              if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
                return 'Please enter a valid date (DD/MM/YYYY)';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          InputField(
            label: "Issued date *",
            keyboardType: TextInputType.datetime,
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("issue_date", newValue);
              });
            },
            initialValue: formHandler.getFieldValue("issue_date"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the passport\'s issued date';
              }
              if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
                return 'Please enter a valid date (DD/MM/YYYY)';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          SelectField(
            label: "Gender *",
            options: ["Male", "Female"],
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("gender", newValue);
              });
            },
            value: formHandler.getFieldValue("gender"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your gender';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
