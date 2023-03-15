import 'package:flutter/material.dart';
import 'package:todo_app/models/login_model.dart';
import 'package:todo_app/utils/secure_storage/secure_storage.dart';
import 'package:todo_app/utils/snackbar/show_custom_snackbar.dart';
import 'package:todo_app/utils/state_util.dart';
import 'package:todo_app/views/home/home_view.dart';
import 'package:uuid/uuid.dart';

import '../../utils/show_loading.dart';

class LoginController extends ChangeNotifier {
  static ValueNotifier<bool> passwordVisible = ValueNotifier(true);
  static TextEditingController usernameController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  static LoginModel dataLogin =
      LoginModel(username: "todo1", password: "todo123");

  static void changeVisible() {
    passwordVisible.value = !passwordVisible.value;
    passwordVisible.notifyListeners();
  }

  static Future<void> login() async {
    Loading.show();
    if (usernameController.text != dataLogin.username) {
      Get.back();
      showCustomSnackbar("Username Salah");
    } else if (passwordController.text != dataLogin.password) {
      Get.back();
      showCustomSnackbar("Password Salah");
    } else {
      String token = const Uuid().v4();
      await SecureStorage.setToken(token);
      Get.offAll(page: const HomeView());
    }
  }

  static void init() {
    passwordVisible = ValueNotifier(true);
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  static void disposes() {
    passwordVisible.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}
