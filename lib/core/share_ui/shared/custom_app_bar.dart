import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppbar({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(
        color: Color(0xff101924),
      ),
      backgroundColor: Colors.white,
      title: Text(
        '$title',
        style: TextStyle(
          color: Color(0xff101924),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (0.0));
}
