import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hagglex/core/constants/app_assets.dart';
import 'package:hagglex/core/share_ui/shared/ui_helpers.dart';
import 'package:hagglex/features/dashboard/presentation/widget/market_card.dart';

class MarketSection extends StatelessWidget {
  MarketSection({
    Key key,
  }) : super(key: key);

  final Random rng = Random();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Market',
          style: TextStyle(fontSize: 15, fontFamily: 'BasisBold'),
        ),
        verticalSpaceMedium,
        MarketCard(
          icon: Image.asset(
            AppAssets.haggleIcon,
            alignment: Alignment.center,
            width: 40,
          ),
          title: 'Haggle (HAG)',
          subTitle: 'NGN 380',
          color: 0xff6545B5,
          data:
              List.generate(20, (index) => LinearSales(index, rng.nextInt(10)))
                  .toList(),
        ),
        MarketCard(
          icon: Image.asset(
            AppAssets.btcIcon,
            alignment: Alignment.center,
            width: 40,
          ),
          title: 'Bitcoin (BTC)',
          subTitle: 'NGN 4,272,147.00',
          color: 0xffF7931A,
          data:
              List.generate(20, (index) => LinearSales(index, rng.nextInt(10)))
                  .toList(),
        ),
        MarketCard(
          icon: Image.asset(
            AppAssets.usdtIcon,
            alignment: Alignment.center,
            width: 40,
          ),
          title: 'Tether (USDT)',
          subTitle: 'NGN 4,272,147.00',
          color: 0xff05A478,
          data:
              List.generate(20, (index) => LinearSales(index, rng.nextInt(10)))
                  .toList(),
        ),
      ],
    );
  }
}
