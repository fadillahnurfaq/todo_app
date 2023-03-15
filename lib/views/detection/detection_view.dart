import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/utils/button/q_button.dart';
import 'package:todo_app/utils/colors.dart';

class DetectionView extends StatelessWidget {
  const DetectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/secure.png",
                height: 200.0,
              ),
            ),
            Text(
              "Opps ada yang salah.",
              style: redTextstyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            RichText(
              text: TextSpan(
                text: "Kami mendeteksi bahwa perangkat anda mengaktifkan ",
                style: greyTextstyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: "Opsi pengembang",
                    style: redTextstyle,
                  ),
                  const TextSpan(
                    text: " Silahkan matikan ",
                  ),
                  TextSpan(
                    text: "Opsi pengembang",
                    style: redTextstyle,
                  ),
                  const TextSpan(
                    text:
                        " pada perangkat anda untuk menggunakan aplikasi kami.",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            QButton(
              backgroundColor: Colors.red,
              text: "Keluar",
              width: 100.0,
              textColor: Colors.white,
              onTap: () {
                if (Platform.isIOS) {
                  try {
                    exit(0);
                  } catch (e) {
                    SystemNavigator.pop();
                  }
                } else {
                  try {
                    SystemNavigator.pop();
                  } catch (e) {
                    exit(0);
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
