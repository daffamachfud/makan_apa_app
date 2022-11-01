import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makan_apa_app/data/model/restaurant.dart';
import 'package:makan_apa_app/ui/resto_detail_page.dart';
import 'package:makan_apa_app/widgets/custom_list_item.dart';
import 'package:makan_apa_app/widgets/platform_widget.dart';

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

  Widget _buildRestoItem(BuildContext context, RestaurantElement restaurant) {
    return Material(
        child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomListItem(
                imageUrl: restaurant.pictureId,
                title: restaurant.name,
                description: restaurant.description,
                rating: restaurant.rating.toString(),
                place: restaurant.city,
                onTap: () {
                  Navigator.pushNamed(context, RestoDetailPage.routeName,
                      arguments: restaurant);
                },
              ),
            )));
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<RestaurantElement> restaurant =
            parseRestaurant(snapshot.data);
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: restaurant.length,
          itemBuilder: (context, index) {
            return _buildRestoItem(context, restaurant[index]);
          },
        );
      },
    );
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
