import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:makan_apa_app/common/styles.dart';
import 'package:makan_apa_app/data/model/restaurant.dart';
import 'package:makan_apa_app/provider/restaurant_explore_provider.dart';
import 'package:makan_apa_app/widgets/card_restaurant.dart';
import 'package:makan_apa_app/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

import '../utils/result_state.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
        //color set to transperent or set your own color
        ));
    return Scaffold(body: _buildHomePage(context));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(child: _buildHomePage(context));
  }

  Widget _buildRestoItem(BuildContext context, Restaurant restaurant) {
    return Material(
        child: Container(
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CardRestaurant(
                  restaurant: restaurant,
                ))));
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantExploreProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Lottie.asset(
            'assets/animation/menu_loading.json',
            repeat: true,
            reverse: false,
            animate: true,
          ),
        ));
      } else if (state.state == ResultState.hasData) {
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: state.result.count,
          itemBuilder: (context, index) {
            return _buildRestoItem(context, state.result.restaurants[index]);
          },
        );
      } else if (state.state == ResultState.noData) {
        return Center(
          child: Material(
            child: Text(state.message),
          ),
        );
      } else if (state.state == ResultState.error) {
        return Center(
          child: Material(
            child: Text(state.message, style: headText1),
          ),
        );
      } else {
        return const Center(
          child: Material(
            child: Text(''),
          ),
        );
      }
    });
  }

  Widget _buildHomePage(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/images/bg_eksplor.png',
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Makan Apa ?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Jangan bilang terserah',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  )),
            ),
            Expanded(
              flex: 4,
              child: _buildList(context),
            ),
          ],
        ));
  }
}
