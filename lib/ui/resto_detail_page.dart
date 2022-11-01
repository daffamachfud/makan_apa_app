import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makan_apa_app/common/styles.dart';
import 'package:makan_apa_app/data/model/drink.dart';
import 'package:makan_apa_app/data/model/food.dart';
import 'package:makan_apa_app/data/model/restaurant.dart';

class RestoDetailPage extends StatelessWidget {
  static const routeName = '/resto_detail';

  final RestaurantElement restaurant;

  const RestoDetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              iconTheme: const IconThemeData(color: Colors.white),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  restaurant.pictureId,
                  fit: BoxFit.fitWidth,
                ),
                title: Text(restaurant.name,
                    style: const TextStyle(color: Colors.white)),
                titlePadding: const EdgeInsets.only(left: 48, bottom: 16),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                        Platform.isIOS ? CupertinoIcons.placemark : Icons.place,
                        color: primaryColor,
                        size: 24),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(restaurant.city),
                    const SizedBox(width: 24),
                    Icon(
                        Platform.isIOS ? CupertinoIcons.star : Icons.star,
                        color: orangeTheme,
                        size: 18),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(restaurant.rating.toString(),style: headText2,)
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  restaurant.description,
                  style: descText,
                ),
                const SizedBox(height: 32),
                const Text(
                  "Makanan",
                  style: headText2,
                ),
                const SizedBox(height: 18),
                _buildListFoodMenu(context),
                const Text(
                  "Minuman",
                  style: headText2,
                ),
                const SizedBox(height: 18),
                _buildListDrinkMenu(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListFoodMenu(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: restaurant.menus.foods.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildFoodMenu(context, restaurant.menus.foods[index]);
      },
    );
  }

  Widget _buildFoodMenu(BuildContext context, Food food) {
    return
      Column(
      children: [
        Card(
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Image.asset('assets/images/bg_food.png'),
        ),
        const SizedBox(height: 8),
        Text(
          food.name,
          style: headText1,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  Widget _buildListDrinkMenu(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: restaurant.menus.foods.length,
      itemBuilder: (context, index) {
        return _buildDrinkMenu(context, restaurant.menus.drinks[index]);
      },
    );
  }

  Widget _buildDrinkMenu(BuildContext context, Drink drink) {
    return ListTile(
        contentPadding: const EdgeInsets.only(bottom: 24),
        leading: Image.asset('assets/images/bg_drink.png'),
        title: Text(drink.name,
            style: headText1, maxLines: 1, overflow: TextOverflow.ellipsis));
  }
}
