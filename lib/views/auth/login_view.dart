import 'package:flutter/material.dart';
import 'package:todo_app/controllers/auth/login_controller.dart';
import 'package:todo_app/utils/button/q_button.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/state_util.dart';
import 'package:todo_app/utils/validator/validator.dart';
import 'package:todo_app/views/auth/widgets/textfield_password.dart';
import 'package:todo_app/views/auth/widgets/textfield_username.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formState = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: formState,
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/union.png",
                    height: 250.0,
                  ),
                ),
                TextFieldUsername(
                  controller: LoginController.usernameController,
                  validator: Validator.required,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFieldPassword(
                  controller: LoginController.passwordController,
                  validator: Validator.required,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                QButton(
                  backgroundColor: orangeColor,
                  splashColor: Colors.white,
                  width: 100.0,
                  text: "Login",
                  textColor: Colors.white,
                  onTap: () async {
                    if (!formState.currentState!.validate()) {
                      return;
                    } else {
                      await LoginController.login();
                    }
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
