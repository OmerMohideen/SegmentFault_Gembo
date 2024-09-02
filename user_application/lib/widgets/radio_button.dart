import 'package:flutter/material.dart';
import 'package:user_application/styles/colors.dart';
import 'package:user_application/styles/fonts.dart';

class RadioButton extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool?> onChanged;

  const RadioButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(label,
                  style: paragraph1Style.copyWith(
                      color:
                          selected ? Colors.black : const Color(0xffBDBDBD))),
            ),
            Radio<bool>(
              value: true,
              groupValue: selected,
              onChanged: onChanged,
              activeColor: primaryColor,
            ),
          ],
        ),
        Container(
          height: 1.0,
          color: selected ? Colors.black : const Color(0xffBDBDBD),
          margin: const EdgeInsets.only(top: 4.0),
        ),
      ],
    );
  }
}
