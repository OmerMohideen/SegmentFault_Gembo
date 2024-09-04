import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:user_application/services/stripe_service.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/utils/form_handler.dart';
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
              text: "Done",
              onTap: () => {
                if (_formKey.currentState!.validate()) {
                  StripeService.instance.makePayment(context)
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
          "Additional Details.",
          style: heading2Style,
        ),
        const SizedBox(height: 15),
        const ProgressBar(
          sizeCount: 5,
          progressCount: 5,
          size: 72,
        ),
      ],
    );
  }

  Form _fields(FormHandler formHandler) {
    return Form(
      key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InputField(
            label: "Date of arrival *",
            keyboardType: TextInputType.datetime,
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("date_of_arrival", newValue);
              });
            },
            initialValue: formHandler.getFieldValue("date_of_arrival"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the date of arrival';
              }
              if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
                return 'Please enter a valid date (DD/MM/YYYY)';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          SelectField(
            label: "Port entry *",
            options: ["Colombo"],
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("port_entry", newValue);
              });
            },
            value: formHandler.getFieldValue("port_entry"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a port of entry';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          InputField(
            label: "Residential address *",
            keyboardType: TextInputType.text,
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("Residential_address", newValue);
              });
            },
            initialValue: formHandler.getFieldValue("Residential_address"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your residential address';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          InputField(
            label: "Date of departure *",
            keyboardType: TextInputType.datetime,
            onChanged: (newValue) {
              setState(() {
                formHandler.setFieldValue("date_of_departure", newValue);
              });
            },
            initialValue: formHandler.getFieldValue("date_of_departure"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the date of departure';
              }
              if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
                return 'Please enter a valid date (DD/MM/YYYY)';
              }
              return null;
            },
          ),
        ],),
    );
  }
}
