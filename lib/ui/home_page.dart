import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makan_apa_app/common/styles.dart';
import 'package:makan_apa_app/provider/scheduling_provider.dart';
import 'package:makan_apa_app/ui/explore_page.dart';
import 'package:makan_apa_app/ui/favorite_page.dart';
import 'package:makan_apa_app/ui/search_page.dart';
import 'package:makan_apa_app/ui/settings_page.dart';
import 'package:makan_apa_app/widgets/platform_widget.dart';
import 'package:provider/provider.dart';
import '../data/api/api_service.dart';
import '../provider/restaurant_explore_provider.dart';
import '../provider/restaurant_search_provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/explore_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _exploreText = 'Eksplor';
  static const String _favoriteText = 'Favorite';
  static const String _searchText = 'Pencarian';
  static const String _settingText = 'Settings';

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantExploreProvider>(
      create: (_) => RestaurantExploreProvider(apiService: ApiService()),
      child: const ExplorePage(),
    ),
    ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(apiService: ApiService()),
      child: const SearchPage(),
    ),
    FavoritePage(),
    ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: const SettingsPage(),
    )
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.explore),
      label: _exploreText,
    ),
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search),
        label: _searchText),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: _favoriteText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: _settingText,
    )
  ];

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
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
