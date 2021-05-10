import 'package:flutter/material.dart';

import 'app_colors.dart';

// Box Decorations

BoxDecoration fieldDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    color: Colors.transparent,
    border: Border.all(color: AppColors.accent, width: 1));

BoxDecoration disabledFieldDecortaion = BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    color: Colors.transparent,
    border: Border.all(color: AppColors.accent, width: 1));

BoxDecoration buttonDecoration = BoxDecoration(
    border: Border.all(
      color: AppColors.secondaryColor,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(26));
// Field Variables

const double fieldHeight = 55;
const double smallFieldHeight = 40;
const double inputFieldBottomMargin = 30;
const double inputFieldSmallBottomMargin = 0;
const EdgeInsets fieldPadding =  EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets largeFieldPadding =
     EdgeInsets.symmetric(horizontal: 15, vertical: 15);

// Text Variables
final TextStyle heading1 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);
final TextStyle bodyRegular = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
);
final TextStyle bodyBold = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
final TextStyle smallTextBold = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
);
final TextStyle smallTextRegular = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.normal,
);
final TextStyle heading2 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
