import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DripBackButton extends StatelessWidget {
  final void Function()? onTap;

  const DripBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/icons/drip_button_base.svg',
            width: 40.0,
            height: 40.0,
          ),
          Positioned(
            top: 12,
            child: SvgPicture.asset(
              'assets/icons/arrow_back.svg',
              width: 8.5,
              height: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

class DripCloseButton extends StatelessWidget {
  final void Function()? onTap;

  const DripCloseButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/icons/drip_white_button_base.svg',
            width: 40.0,
            height: 40.0,
          ),
          Positioned(
            top: 12,
            child: SvgPicture.asset(
              'assets/icons/close.svg',
              width: 8.5,
              height: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}
