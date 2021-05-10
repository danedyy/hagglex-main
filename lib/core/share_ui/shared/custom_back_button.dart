import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hagglex/core/share_ui/shared/touachable_opacity.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 45,
        height: 36,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.2),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: ShadowIcon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ShadowIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  ShadowIcon(
    this.icon, {
    Key key,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0.5,
          top: 0.5,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 1.0,
              sigmaY: 1.0,
            ),
            child: Icon(
              icon,
              color: color.withOpacity(0.7),
              size: 14,
            ),
          ),
        ),
        Icon(
          icon,
          color: color,
          size: 14,
        ),
      ],
    );
  }
}
