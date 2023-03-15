import 'package:flutter/material.dart';
import 'package:todo_app/utils/state_util.dart';

class Loading {
  static show() async {
    return await showDialog(
      barrierDismissible: false,
      context: Get.currentContext,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(
                color: Colors.orange,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Mohon tunggu...",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              )
            ],
          ),
        );
      },
    );
  }
}
