import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makan_apa_app/common/styles.dart';
import 'package:makan_apa_app/data/model/category.dart';
import 'package:makan_apa_app/widgets/seperator_line.dart';

class CardReview extends StatelessWidget {
  final CustomerReview customerReview;

  const CardReview({super.key, required this.customerReview});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customerReview.name,
                    style: headText2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    customerReview.review,
                  ),
                  const SizedBox(height: 12),
                  const SeperatorLine(color: Color(0xFFD7D7D7)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                          Platform.isIOS
                              ? CupertinoIcons.calendar
                              : Icons.date_range_sharp,
                          color: primaryColor,
                          size: 18),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        customerReview.date,
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
    );
  }
}
