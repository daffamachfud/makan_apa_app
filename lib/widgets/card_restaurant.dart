import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makan_apa_app/common/styles.dart';
import 'package:makan_apa_app/data/model/restaurant.dart';
import 'package:makan_apa_app/widgets/seperator_line.dart';
import '../ui/resto_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RestoDetailPage.routeName,
            arguments: restaurant.id);
      },
      child: SizedBox(
        height: 110,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Icon(
                                  Platform.isIOS
                                      ? CupertinoIcons.star
                                      : Icons.star,
                                  size: 18,
                                  color: orangeTheme),
                              Text(
                                restaurant.rating.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              )
                            ],
                          ),
                        )),
                  ))
                ],
              ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name ?? "",
                      style: headText2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(restaurant.description ?? "",
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 12),
                    const SeperatorLine(color: Color(0xFFD7D7D7)),
                    const SizedBox(height: 12),
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
                        Text(
                          restaurant.city ?? "",
                          style: headText2,
                        )
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
