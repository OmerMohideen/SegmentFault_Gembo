import 'package:flutter/material.dart';
import 'package:user_application/styles/colors.dart';
import 'package:user_application/styles/fonts.dart';

class Button extends StatelessWidget {
  final String text;
  final bool secondary;
  final void Function()? onTap;

  const Button({
    super.key,
    required this.text,
    this.secondary = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        height: 65,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: !this.secondary ? primaryColor : Colors.transparent,
          border: !this.secondary
              ? Border.all(color: Colors.transparent, width: 0)
              : Border.all(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          this.text,
          style: buttonStyle.copyWith(
              color: !this.secondary ? Colors.white : primaryColor),
        ),
      ),
    );
  }
}