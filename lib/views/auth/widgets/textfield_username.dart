import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class TextFieldUsername extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const TextFieldUsername(
      {super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autocorrect: false,
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
            Icons.person_outline,
            color: Colors.white,
          ),
        ),
        fillColor: Colors.red,
        hintText: "Username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
