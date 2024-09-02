import 'package:flutter/material.dart';
import 'package:user_application/styles/colors.dart';

class ProgressBar extends StatelessWidget {
  final int progressCount;
  final int sizeCount;
  final int size;

  const ProgressBar({
    super.key,
    required this.progressCount,
    required this.sizeCount,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: this.sizeCount * this.size.toDouble(),
      decoration: const BoxDecoration(color: primarySubtleColor),
      child: Row(
        children: List.generate(
          this.progressCount,
          (index) => Container(
            width: this.size.toDouble(),
            height: 10,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff5DB075), Color(0xff49925E)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
