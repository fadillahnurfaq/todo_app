import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:todo_app/controllers/splash/splash_cotnroller.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/views/detection/detection_view.dart';

import '../db/todo_db.dart';
import '../utils/state_util.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool isJailBroken = false;
  bool developermode = false;

  @override
  void initState() {
    initializeDateFormatting();
    TodoDb.initDB();
    checkFakeGps();
    super.initState();
  }

  Future<void> checkFakeGps() async {
    if (!mounted) return;
    try {
      isJailBroken = await FlutterJailbreakDetection.jailbroken;
      developermode = await FlutterJailbreakDetection.developerMode;
      setState(() {});

      if (isJailBroken == true || developermode == true) {
        Get.offAll(page: const DetectionView());
      } else {
        SplashController.checkToken();
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Image.asset("assets/union.png"),
            ),
          ),
          CircularProgressIndicator(
            color: orangeColor,
          ),
          const SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }
}
