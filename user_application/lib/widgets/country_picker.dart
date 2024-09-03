import "package:flutter/material.dart";
import 'package:country_picker/country_picker.dart';

class CountryPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          showPhoneCode: true,
          context: context,
          onSelect: (value) {
            print(value);
          },
        );
      },
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Color(0xffBDBDBD), width: 1))),
        child: Text("Select country code"),
      ),
    );
  }
}
