import 'package:flutter/material.dart';

class HaggleXAppBackgroundWidget extends StatelessWidget {
  const HaggleXAppBackgroundWidget({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF2E1963),
              const Color(0xFF402B75),
              const Color(0xFF271160),
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: const FractionalOffset(1.0, 0.0),
          ),
        ),
        child: child,
      ),
    );
  }
}
