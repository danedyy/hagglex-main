import 'package:flutter/material.dart';
import 'package:hagglex/core/share_ui/shared/app_colors.dart';

import 'email_validator.dart';

class CustomFormValidation {
  static Color getColor(String text, FocusNode focus) {
    if (focus.hasFocus && text == null) {
      return AppColors.accent;
    }
    if (focus.hasFocus && text.isEmpty) {
      return Colors.redAccent;
    } else if (focus.hasFocus && text.isNotEmpty) {
      return Color(0xffE6FFEA);
    } else {
      return AppColors.accent;
    }
  }

  static Color getColorBvn(String text, FocusNode focus) {
    if (focus.hasFocus && text == null) {
      return AppColors.accent;
    }
    if (focus.hasFocus && text.isEmpty) {
      return Colors.redAccent;
    } else if (text != null && text.length != 11) {
      return Colors.redAccent;
    } else if (focus.hasFocus && text.isNotEmpty) {
      return AppColors.accent;
    } else {
      return AppColors.accent;
    }
  }

  static String errorEmailMessage(String text, String message, [String type]) {
    // var text = text ? null : message;
    // return text;
    if (text == null) {
      return null;
    } else if (text.isEmpty) {
      return message;
    } else if (EmailValidator.validEmail(text) == false) {
      return 'Email must be a valid email address';
    } else {
      return null;
    }
  }

  static String errorMessage(String text, String message, [String type]) {
    // var text = text ? null : message;
    // return text;
    if (text == null) {
      return null;
    } else if (text.isEmpty) {
      return message;
    } else {
      return null;
    }
  }

  static String errorMessagePassword(String text, String message,
      [String type]) {
    // var text = text ? null : message;
    // return text;
    if (text == null) {
      return null;
    } else if (text.isEmpty) {
      return message;
    } else if (text.length <= 7) {
      return 'Password must have 8 or more characters';
    } else {
      return null;
    }
  }

  static String errorMessageAccount(String text, String message,
      [String type]) {
    if (text == null) {
      return null;
    } else if (text.isEmpty) {
      return message;
    } else if (text.length <= 9) {
      return 'Account number must have 10 characters';
    } else {
      return null;
    }
  }

  static String errorPhoneNumber(String text, String message, [String type]) {
    if (text == null) {
      return null;
    } else if (text.isEmpty) {
      return message;
    } else if (text.length < 10 || text.length > 10) {
      return 'Phone number must have 10 characters';
    } else {
      return null;
    }
  }

  static String errorPhoneNumber2(String text, String message, [String type]) {
    if (text == null) {
      return null;
    } else if (text.isEmpty) {
      return message;
    } else if (text.length < 11 || text.length > 11) {
      return 'Phone number must have 11 characters';
    } else {
      return null;
    }
  }

  static String errorPhoneNumberLogin(String text, String message,
      [String type]) {
    if (text == null) {
      return null;
    } else if (text.isEmpty) {
      return message;
    } else if (!text.startsWith('0')) {
      if (text.contains('+')) {
        return 'Phone number must not contain special characters';
      }
      if (text.length < 9) {
        return 'Phone numner too short.';
      } else {
        return null;
      }
    } else if (text.startsWith('0') && (text.length < 11 || text.length > 11)) {
      return 'Phone number must have 11 characters';
    } else {
      return null;
    }
  }

  static String errorMessageConfirmPassword(
      String text, String message, String password,
      [String type]) {
    // var text = text ? null : message;
    // return text;
    if (text == null) {
      return null;
    } else if (text.isEmpty) {
      return message;
    } else if (text.length <= 7) {
      return 'Password must have 8 or more characters';
    } else if (text != password) {
      return 'Confirmation password must match password';
    } else {
      return null;
    }
  }

  static String errorMessagePin(String text, String message, [String type]) {
    // var text = text ? null : message;
    // return text;
    if (text == null) {
      return null;
    } else if (text.isEmpty) {
      return message;
    } else if (text.length != 6) {
      return 'Pin must have 6 characters';
    } else {
      return null;
    }
  }

  static String errorMessagePin2(String text, String message, [String type]) {
    // var text = text ? null : message;
    // return text;
    if (text == null) {
      return null;
    } else if (text.isEmpty) {
      return message;
    } else if (text.length != 6) {
      return 'OTP must have 6 characters';
    } else {
      return null;
    }
  }

  static String errorMessageConfirmPin(
      String text, String message, String password,
      [String type]) {
    // var text = text ? null : message;
    // return text;
    if (text == null) {
      return null;
    } else if (text.isEmpty) {
      return message;
    } else if (text.length <= 3) {
      return 'Pin must have 4 characters';
    } else if (text != password) {
      return 'Confirmation pin must match pin';
    } else {
      return null;
    }
  }

  static String errorMessageBvn(String text, String message, [String type]) {
    // var text = text ? null : message;
    // return text;
    if (text == null) {
      return null;
    } else if (text.isEmpty) {
      return message;
    } else if (text.length != 11) {
      return 'Please enter a valid BVN';
    } else {
      return null;
    }
  }
}
