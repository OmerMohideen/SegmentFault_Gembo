import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:user_application/styles/fonts.dart';

class CountryPicker extends StatelessWidget {
  final Function(Country) onSelect;
  final String title;
  final bool showPhoneCode;

  const CountryPicker(
      {Key? key,
      required this.onSelect,
      required this.title,
      this.showPhoneCode = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          showPhoneCode: showPhoneCode,
          context: context,
          onSelect: onSelect,
        );
      },
      child: Container(
        alignment: Alignment.topLeft,
        height: 38,
        margin: EdgeInsets.only(top: 18),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
        ),
        child: Text(
          title,
          style: paragraph1Style.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
