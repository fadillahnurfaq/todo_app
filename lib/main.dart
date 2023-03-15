import 'package:flutter/material.dart';
import 'package:todo_app/views/splash_view.dart';
import 'utils/state_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: NoSplashColor(),
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.navigatorKey,
      home: const SplashView(),
    );
  }
}

class NoSplashColor extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
