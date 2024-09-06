import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_application/pages/visa/additional_details_page.dart';

import 'package:user_application/styles/fonts.dart';
import 'package:user_application/utils/form_handler.dart';
import 'package:user_application/widgets/Button.dart';
import 'package:user_application/widgets/back_button.dart';
import 'package:user_application/widgets/progress.dart';
import "package:user_application/widgets/input_field.dart";
import "package:user_application/widgets/country_picker.dart";

class ContactDetailsPage extends StatefulWidget {
  const ContactDetailsPage({super.key});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
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
                if (_formKey.currentState!.validate())
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new AdditionalDetailsPage()),
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
          "Contact Details.",
          style: heading2Style,
        ),
        const SizedBox(height: 15),
        const ProgressBar(
          sizeCount: 5,
          progressCount: 4,
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
            label: "Email *",
            keyboardType: TextInputType.text,
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("email", newValue);
              });
            },
            initialValue: formHandler.getFieldValue("email"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CountryPicker(
                  onSelect: (Country country) => {
                    setState(() {
                      formHandler.setFieldValue("personal_country_code",
                          "+ " + country.phoneCode.toString());
                    })
                  },
                  title: formHandler.getFieldValue("personal_country_code") ??
                      "+ 00",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 5,
                child: InputField(
                  label: "Call number",
                  keyboardType: TextInputType.number,
                  onChanged: (newValue) {
                    setState(() {
                      formHandler.setFieldValue("phone_number", newValue);
                    });
                  },
                  initialValue: formHandler.getFieldValue("phone_number"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Phone number should contain digits only';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CountryPicker(
                  onSelect: (Country country) => {
                    setState(() {
                      formHandler.setFieldValue("whatsapp_country_code",
                          "+ " + country.phoneCode.toString());
                    })
                  },
                  title: formHandler.getFieldValue("whatsapp_country_code") ??
                      "+ 00",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 5,
                child: InputField(
                  label: "Whatsapp number",
                  keyboardType: TextInputType.number,
                  onChanged: (newValue) {
                    setState(() {
                      formHandler.setFieldValue("whatsapp_number", newValue);
                    });
                  },
                  initialValue: formHandler.getFieldValue("whatsapp_number"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your WhatsApp number';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'WhatsApp number should contain digits only';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
