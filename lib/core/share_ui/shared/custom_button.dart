import 'package:flutter/material.dart';
import 'package:hagglex/core/share_ui/shared/touachable_opacity.dart';
import 'package:hagglex/core/share_ui/shared/ui_helpers.dart';

import 'app_colors.dart';

class CustomButton extends StatefulWidget {
  final bool hasBorder;
  final Color color;
  final Color textColor;
  final String buttonText;
  final Function onTap;
  final bool isActive;
  CustomButton({
    Key key,
    this.hasBorder = false,
    this.isActive = false,
    this.color = AppColors.primaryColor,
    this.textColor = Colors.white,
    @required this.buttonText,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          height: 60,
          width: screenWidth(context),
          decoration: BoxDecoration(
            color:
                widget.isActive ? widget.color : widget.color.withOpacity(0.5),
            border: widget.hasBorder
                ? Border.all(
                    color: widget.isActive
                        ? Color(0xff18293D)
                        : Color(0xff18293D).withOpacity(0.6),
                    width: 1)
                : Border.symmetric(),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              '${widget.buttonText}',
              style: TextStyle(
                color: widget.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
