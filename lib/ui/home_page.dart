import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makan_apa_app/common/styles.dart';
import 'package:makan_apa_app/ui/explore_page.dart';
import 'package:makan_apa_app/ui/history_page.dart';
import 'package:makan_apa_app/widgets/platform_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/explore_page';

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _exploreText = 'Eksplor';
  static const String _historyText = 'Riwayat';

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  final List<Widget> _listWidget = const [ExplorePage(), HistoryPage()];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.explore),
      label: _exploreText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.assignment),
      label: _historyText,
    ),
  ];

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
        activeColor: primaryColor,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }
}
