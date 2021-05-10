import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

class FlushBarNotification {
  static dynamic showErrorMessage({
    @required BuildContext context,
    String title = '',
    @required String message,
  }) {
    var fh = FlushbarHelper.createError(
      message: message,
      title: title,
      duration: Duration(
        seconds: 3,
      ),
      // flushbarPosition : FlushbarPosition.TOP
    );
    fh.show(context);
  }

  static dynamic showSuccessMessage({
    @required BuildContext context,
    String title = '',
    @required String message,
  }) {
    var fh = FlushbarHelper.createSuccess(
      message: message,
      title: title,
      duration: Duration(
        seconds: 3,
      ),
    );
    fh.show(context);
  }

  static dynamic showInfoMessage({
    @required BuildContext context,
    String title = '',
    @required String message,
  }) {
    var fh = FlushbarHelper.createInformation(
      message: message,
      title: title,
      duration: Duration(
        seconds: 3,
      ),
    );
    fh.show(context);
  }
}
