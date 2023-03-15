import 'package:flutter/material.dart';

import '../../../controllers/auth/login_controller.dart';
import '../../../utils/colors.dart';

class TextFieldPassword extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const TextFieldPassword(
      {super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: LoginController.passwordVisible,
      builder: (_, visible, __) {
        return TextFormField(
          controller: controller,
          autocorrect: false,
          obscureText: visible,
          validator: validator,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: orangeColor),
              borderRadius: BorderRadius.circular(50),
            ),
            prefixIcon: Container(
              height: 60,
              width: 70,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                  color: orangeColor),
              child: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
            ),
            // fillColor: Colors.red,
            hintText: "Password",
            suffixIcon: IconButton(
              onPressed: () {
                LoginController.changeVisible();
              },
              icon: visible
                  ? Icon(
                      Icons.visibility,
                      color: orangeColor,
                    )
                  : Icon(
                      Icons.visibility_off,
                      color: orangeColor,
                    ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        );
      },
    );
  }
}
