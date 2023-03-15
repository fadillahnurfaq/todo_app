import 'package:flutter/material.dart';
import 'package:todo_app/utils/show_loading.dart';

import '../../db/todo_db.dart';
import '../../utils/button/q_button.dart';
import '../../utils/colors.dart';
import '../../utils/state_util.dart';
import '../../views/home/home_view.dart';

class DeleteController {
  static Future<void> deleteTodo(String id) async {
    try {
      Loading.show();
      await TodoDb.deletTodo(id);
      Get.off(page: const HomeView());
    } catch (e) {}
  }

  static delete(String id) {
    return showModalBottomSheet(
      context: Get.currentContext,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          height: 180.0,
          child: Column(
            children: [
              QButton(
                backgroundColor: Colors.white,
                text: "Delete TODO",
                textColor: orangeColor,
                onTap: () async {
                  await deleteTodo(id);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              QButton(
                backgroundColor: Colors.white,
                text: "Cancel",
                textColor: Colors.green,
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
