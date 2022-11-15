import 'package:flutter/material.dart';
import 'package:makan_apa_app/common/styles.dart';
import 'package:makan_apa_app/provider/restaurant_database_provider.dart';
import 'package:makan_apa_app/utils/result_state.dart';
import 'package:provider/provider.dart';

import '../data/model/restaurant.dart';
import '../widgets/card_restaurant.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDatabaseProvider>(
        builder: (context, provider, child) {
      if (provider.state == ResultState.noData) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 48, left: 16, right: 16, bottom: 16),
              child: Column(
                children: [
                  const Text(
                    "Favorite",
                    style: headText1,
                  ),
                  const SizedBox(height: 64),
                  Center(
                    child: Column(
                      children: [
                        Image.asset('assets/images/ic_riwayat.png'),
                        Text(
                          provider.message,
                          style: headText2,
                        ),
                        const SizedBox(height: 8)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else if (provider.state == ResultState.hasData) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 48, left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Favorite",
                    style: headText1,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 24),
                      itemCount: provider.favorites.length,
                      itemBuilder: (context, index) {
                        return _buildRestoItem(
                            context, provider.favorites[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (provider.state == ResultState.error) {
        return Center(
          child: Material(
            child: Text(provider.message, style: headText1),
          ),
        );
      } else {
        return const Center(
          child: Material(
            child: Text(
              'Test',
              style: TextStyle(color: Colors.black),
            ),
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
