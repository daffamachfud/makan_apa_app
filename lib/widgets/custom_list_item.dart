import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makan_apa_app/common/styles.dart';
import 'package:makan_apa_app/widgets/seperator_line.dart';

class CustomListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String rating;
  final String place;
  final void Function() onTap;

  const CustomListItem(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.rating,
      required this.place,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 110,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
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
                      child: Image.network(imageUrl, fit: BoxFit.cover),
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
                                rating,
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
                      title,
                      style: headText2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(description,
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
                        const SizedBox(width: 4,),
                        Text(place,style: headText2,)
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
