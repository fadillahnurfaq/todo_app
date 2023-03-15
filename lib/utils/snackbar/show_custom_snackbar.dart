import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/utils/state_util.dart';

void showCustomSnackbar(String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 3),
  ).show(Get.currentContext);
}
