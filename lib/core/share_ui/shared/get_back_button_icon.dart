import 'dart:io';

import 'package:flutter/material.dart';

class BackButtonIcon extends StatelessWidget {
  const BackButtonIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Icon(Icons.arrow_back)
        : Icon(Icons.arrow_back_ios);
  }
}
