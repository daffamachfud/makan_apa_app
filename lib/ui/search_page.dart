import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:makan_apa_app/common/styles.dart';
import 'package:makan_apa_app/provider/restaurant_search_provider.dart';
import 'package:provider/provider.dart';

import '../data/model/restaurant.dart';
import '../utils/result_state.dart';
import '../widgets/card_restaurant.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchRestaurantsState =
        Provider.of<RestaurantSearchProvider>(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Pencarian",
                style: headText1,
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                      Platform.isIOS ? CupertinoIcons.search : Icons.search),

                  /// suffixIcon: Icon(
                  ///     Platform.isIOS ? CupertinoIcons.clear_circled_solid : Icons.cancel),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'Mau makan apa hari ini?',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0)),
                ),
                onChanged: (value) {
                  searchRestaurantsState.searchQuery(value);
                },
              ),
              const SizedBox(height: 24.0),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 12.0),
                child: _buildList(context),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return Center(
            child: Lottie.asset(
          'assets/animation/menu_loading.json',
          repeat: true,
          reverse: false,
          animate: true,
        ));
      } else if (state.state == ResultState.hasData) {
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: state.result.restaurants.length,
          itemBuilder: (context, index) {
            return _buildRestoItem(context, state.result.restaurants[index]);
          },
        );
      } else if (state.state == ResultState.noData) {
        return Center(
          child: Column(
            children: [
              Image.asset('assets/images/ic_empty_data.png'),
              const SizedBox(height: 24.0),
              const Text(
                'Belum ada hasil dari pencarian kamu',
                style: headText1,
              )
            ],
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
}
