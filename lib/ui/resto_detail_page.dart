import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:makan_apa_app/common/styles.dart';
import 'package:makan_apa_app/data/model/drink.dart';
import 'package:makan_apa_app/data/model/food.dart';
import 'package:makan_apa_app/provider/restaurant_detail_provider.dart';
import 'package:makan_apa_app/provider/restaurant_explore_provider.dart';
import 'package:provider/provider.dart';

import '../data/api/api_service.dart';

class RestoDetailPage extends StatelessWidget {
  static const routeName = '/resto_detail';
  final String restaurantId;

  const RestoDetailPage({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(
            apiService: ApiService(), restaurantId: restaurantId),
        child: Scaffold(body:
            Consumer<RestaurantDetailProvider>(builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return Center(
              child: Lottie.asset(
                'assets/animation/detail_loading.json',
                repeat: true,
                reverse: false,
                animate: true,
              ),
            );
          } else if (state.state == ResultState.hasData) {
            var restaurant = state.result.restaurant;
            return NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 200,
                    iconTheme: const IconThemeData(color: Colors.white),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
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
                              Platform.isIOS
                                  ? CupertinoIcons.placemark
                                  : Icons.place,
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
                          Text(
                            restaurant.rating.toString(),
                            style: headText2,
                          )
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
                      _buildListFoodMenu(context, restaurant.menus.foods),
                      const Text(
                        "Minuman",
                        style: headText2,
                      ),
                      const SizedBox(height: 18),
                      _buildListDrinkMenu(context, restaurant.menus.drinks)
                    ],
                  ),
                ),
              ),
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
        })));
  }

  Widget _buildListFoodMenu(BuildContext context, List<Food> listFood) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: listFood.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildFoodMenu(context, listFood[index]);
      },
    );
  }

  Widget _buildFoodMenu(BuildContext context, Food food) {
    return Column(
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

  Widget _buildListDrinkMenu(BuildContext context, List<Drink> listDrink) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: listDrink.length,
      itemBuilder: (context, index) {
        return _buildDrinkMenu(context, listDrink[index]);
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
