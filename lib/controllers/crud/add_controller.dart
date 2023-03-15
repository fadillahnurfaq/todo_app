import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/utils/show_loading.dart';
import 'package:todo_app/views/home/home_view.dart';
import 'package:uuid/uuid.dart';

import '../../db/todo_db.dart';
import '../../models/todo_model.dart';
import '../../utils/state_util.dart';
import '../home/home_controller.dart';

class AddController extends ChangeNotifier {
  static TextEditingController titleController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();
  static ValueNotifier<String> base64 = ValueNotifier("");
  static ValueNotifier<String?> selectedDate = ValueNotifier("");

  static void disposes() {
    titleController.dispose();
    descriptionController.dispose();
    base64.dispose();
    selectedDate.dispose();
  }

  static void init() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    base64 = ValueNotifier("");
    selectedDate = ValueNotifier("");
  }

  static void pickerDate() async {
    DateTime? pickerDate = await showDatePicker(
      context: Get.currentContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (pickerDate != null) {
      selectedDate.value =
          DateFormat('d MMMM y', 'id_ID').format(pickerDate).toString();
      selectedDate.notifyListeners();
    }
  }

  static void takePhoto() async {
    final ImagePicker picker = ImagePicker();
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      final bytes = File(image.path).readAsBytesSync();
      base64.value = base64Encode(bytes);
      base64.notifyListeners();
    }
  }

  static Future<void> addTodo() async {
    try {
      Loading.show();
      String id = const Uuid().v4();
      await TodoDb.insert(TodoModel(
        id: id,
        title: titleController.text,
        description: descriptionController.text,
        deadline: selectedDate.value,
        image: base64.value,
        createdAt: DateFormat('d MMMM y', 'id_ID').format(DateTime.now()),
      ));

      await HomeController.getTodo();

      Get.off(page: const HomeView());
    } catch (e) {}
  }
}
