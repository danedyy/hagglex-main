import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hagglex/core/constants/app_assets.dart';
import 'package:hagglex/core/share_ui/shared/ui_helpers.dart';
import 'package:hagglex/features/dashboard/presentation/widget/do_more_card.dart';

class DoMoreSection extends StatelessWidget {
  const DoMoreSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Do more with HaggleX',
          style: TextStyle(fontSize: 15, fontFamily: 'BasisBold'),
        ),
        verticalSpaceMedium,
        DoMore(
          icon: Image.asset(
            AppAssets.sendIcon,
            alignment: Alignment.center,
            width: 40,
          ),
          title: 'Send money instantly',
          subTitle: 'Send crypto to another wallet',
        ),
        verticalSpaceTiny,
        DoMore(
          icon: Image.asset(
            AppAssets.recIcon,
            alignment: Alignment.center,
            width: 40,
          ),
          title: 'Receive money from anyone',
          subTitle: 'Receive crypto from another wallet',
        ),
        verticalSpaceTiny,
        DoMore(
          icon: Icon(Icons.credit_card_outlined,
              color: Theme.of(context).accentColor),
          title: 'Virtual Card',
          subTitle: 'Make faster payments using HaggleX cards',
        ),
        verticalSpaceTiny,
        DoMore(
          icon: Icon(Icons.language_outlined,
              color: Theme.of(context).accentColor),
          title: 'Global Remittance',
          subTitle: 'Send money to anyone, anywhere',
        ),
      ],
    );
  }
}
