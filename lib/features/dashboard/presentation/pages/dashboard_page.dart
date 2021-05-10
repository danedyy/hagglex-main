import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hagglex/core/constants/app_assets.dart';
import 'package:hagglex/core/local_data/user_data/delete_user_session.dart';
import 'package:hagglex/core/navigations/route_paths.dart';
import 'package:hagglex/core/share_ui/shared/ui_helpers.dart';
import 'package:hagglex/features/dashboard/presentation/pages/market_section.dart';
import 'package:hagglex/injection_container.dart';

import 'do_more_section.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool live = true;
  int _currentIndex = 0;
  final List<Widget> _pages = [
    Home(),
    Container(
      child: Center(
        child: Text('Wallet'),
      ),
    ),
    Container(
      child: Center(
        child: Text('Swap'),
      ),
    ),
    Container(
      child: Center(
        child: Text('Cryptosave'),
      ),
    ),
    Container(
      child: Center(
        child: Text('More'),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              )),
          child: CircleAvatar(
            backgroundColor: Color(0xffE9BBFF),
            radius: 2,
            child: Text(
              'DE',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 18,
                  fontFamily: 'BasisBold'),
            ),
          ),
        ),
        title: Text(
          'Hagglex',
          textScaleFactor: 1.2,
          style: TextStyle(
              color: Colors.white, fontFamily: 'BasisBold', fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Card(
              shape: CircleBorder(),
              color: Colors.deepPurple[800].withOpacity(.66),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: -8,
                    child: Container(
                      height: 18,
                      width: 18,
                      // padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      alignment: Alignment.center,
                      child: Text(
                        '5',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: 35,
                      width: 35,
                      child: Center(
                        child: Icon(
                          Icons.notifications,
                          size: 20,
                          // color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size(0, 100),
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Total portfolio balance',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                  verticalSpaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$****',
                        style: TextStyle(
                            fontFamily: 'BasisBold',
                            color: Colors.white,
                            fontSize: 25),
                      ),
                      Switch.adaptive(
                        value: live,
                        onChanged: (value) {
                          live = value;
                          setState(() {});
                          sl<DeleteUserSession>()();
                          Navigator.pushNamed(
                            context,
                            Routes.loginPage,
                          );
                        },
                        activeColor: Color(0xffFFC175),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: _currentIndex,
        onTap: (value) {
          _currentIndex = value;
          setState(() {});
        },
        elevation: 20,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              size: 32,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance_wallet_rounded,
                size: 32,
              ),
              label: 'Wallet'),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                child: Icon(
                  Icons.swap_horiz,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: Image.asset(
                  AppAssets.savingsIcon,
                  width: 35,
                  color: _currentIndex == 3
                      ? Theme.of(context).accentColor
                      : Colors.grey[600],
                ),
              ),
              label: 'Cryptosave'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box,
                size: 32,
              ),
              label: 'Wallet'),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 146,
          color: Color(0xffF3F3F3),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(8),
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(AppAssets.newsBanner),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(AppAssets.newsBanner1),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(AppAssets.newsBanner2),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(AppAssets.newsBanner3),
              ),
            ],
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 17, vertical: 22),
          child: Column(
            children: [
              MarketSection(),
              verticalSpaceMedium,
              DoMoreSection(),
            ],
          ),
        ))
      ],
    );
  }
}
