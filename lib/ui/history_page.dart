import 'package:flutter/material.dart';
import 'package:makan_apa_app/common/styles.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            const Text(
              "Riwayat",
              style: headText1,
            ),
            const SizedBox(height: 64),
            Center(
              child: Column(
                children: [
                  Image.asset('assets/images/ic_riwayat.png'),
                  const Text(
                    "Mohon maaf yah, fitur ini belum tersedia",
                    style: headText2,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                      "Nanti yah belum di kerjain sama developernya buat fitur ini.",
                      style: descText),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
