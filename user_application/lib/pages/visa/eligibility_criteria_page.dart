import 'package:flutter/material.dart';
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
          SelectField(
            label: "Nationality *",
            options: const ["Resr"],
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("nationality", newValue);
              });
            },
            value: formHandler.getFieldValue("nationality"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your nationality';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          SelectField(
            label: "Country of residence *",
            options: const ["Resr"],
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("residence", newValue);
              });
            },
            value: formHandler.getFieldValue("residence"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your residence';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          SelectField(
            label: "Visa-type *",
            options: const ["Resr"],
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
            options: const ["Resr"],
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
            options: const ["Resr"],
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
            options: const ["Resr"],
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
            options: const ["Resr"],
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
