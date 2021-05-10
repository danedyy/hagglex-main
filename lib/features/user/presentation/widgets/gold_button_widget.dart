import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hagglex/core/share_ui/shared/touachable_opacity.dart';

class GoldButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const GoldButton({
    Key key,
    @required this.onTap,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xffFFC175),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            '$title',
            style: TextStyle(
              color: Color(0xff3E0606),
              fontSize: 12,
              fontFamily: 'BasisBold',
              // fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
