import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:user_application/styles/fonts.dart';

class SelectField extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? value;
  final void Function(String?) onChanged;
  final FormFieldValidator<String>? validator;

  const SelectField({
    super.key,
    required this.label,
    required this.options,
    this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: paragraph1Style.copyWith(color: Colors.black),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      icon: SvgPicture.asset('assets/icons/arrow_down.svg'),
      value: value,
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(
            option,
            style: paragraph2Style,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      dropdownColor: Colors.white,
      validator: validator,
    );
  }
}
