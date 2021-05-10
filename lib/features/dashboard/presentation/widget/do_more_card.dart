import 'package:flutter/material.dart';
import 'package:hagglex/core/share_ui/shared/ui_helpers.dart';

class DoMore extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget icon;
  const DoMore({
    Key key,
    this.title,
    this.subTitle,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.grey.shade50.withOpacity(.6),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Theme.of(context).accentColor.withOpacity(.1),
                child: icon,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  verticalSpaceTiny,
                  Text(
                    subTitle,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )
              // verticalSpaceLarge
            ],
          ),
        ));
  }
}
