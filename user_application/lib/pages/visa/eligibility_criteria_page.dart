import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import "package:user_application/widgets/country_picker.dart";

import 'package:provider/provider.dart';
import 'package:user_application/pages/visa/passport_documents_page.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/utils/form_handler.dart';
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
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new PassportDocumentsPage()),
                  );
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
          "Eligibility criteria.",
          style: heading2Style,
        ),
        const SizedBox(height: 15),
        const ProgressBar(
          sizeCount: 5,
          progressCount: 1,
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
          CountryPicker(
            showPhoneCode: false,
            onSelect: (Country country) => {
              setState(() {
                formHandler.setFieldValue("nationality", "" + country.name);
              })
            },
            title: formHandler.getFieldValue("nationality") ?? "Nationality",
          ),
          const SizedBox(height: 30),
          CountryPicker(
            showPhoneCode: false,
            onSelect: (Country country) => {
              setState(() {
                formHandler.setFieldValue(
                    "country_of_residence", "" + country.name);
              })
            },
            title: formHandler.getFieldValue("country_of_residence") ??
                "Country of residence",
          ),
          const SizedBox(height: 30),
          SelectField(
            label: "Visa-type *",
            options: const [
              "Diplomatic visa",
              "Tourist visa",
              "Medical visa",
              "Student visa",
              "Work visa",
            ],
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("visa_type", newValue);
              });
            },
            value: formHandler.getFieldValue("visa_type"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your visa type';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          SelectField(
            label: "Visa-Category *",
            options: const [
              "Business visa",
              "Student visa",
              "Transit visa",
              "Diplomat visa",
              "Journalist visa",
              "Conference visa",
              "E visa",
              "Medical visa",
            ],
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("visa_category", newValue);
              });
            },
            value: formHandler.getFieldValue("visa_category"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your visa category';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          SelectField(
            label: "Purpose of travel *",
            options: const [
              "For leisure",
              "For Work",
              "For Studies",
              "For Diplomacy",
              "Other Reasons",
            ],
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("purpose", newValue);
              });
            },
            value: formHandler.getFieldValue("purpose"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your purpose of travel';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          SelectField(
            label: "Sub-Visa type *",
            options: const [
              "30 days one time",
              "30 day multiple",
              "6 months one time",
              "6 months multiple",
              "1 year multiple",
            ],
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("sub_visa_type", newValue);
              });
            },
            value: formHandler.getFieldValue("sub_visa_type"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your sub visa type';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          SelectField(
            label: "Type of travel Document *",
            options: const ["Passport"],
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("travel_document", newValue);
              });
            },
            value: formHandler.getFieldValue("travel_document"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your type of travel document';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
