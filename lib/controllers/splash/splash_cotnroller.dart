import 'package:todo_app/utils/secure_storage/secure_storage.dart';
import 'package:todo_app/views/auth/login_view.dart';

import '../../utils/state_util.dart';
import '../../views/home/home_view.dart';

class SplashController {
  static Future<void> checkToken() async {
    final token = await SecureStorage.getToken();
    if (token != null) {
      Future.delayed(
        const Duration(seconds: 3),
        () => Get.offAll(page: const HomeView()),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 3),
        () => Get.offAll(page: const LoginView()),
      );
    }
  }
}
