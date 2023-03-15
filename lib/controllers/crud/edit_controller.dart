import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/utils/show_loading.dart';

import '../../db/todo_db.dart';
import '../../models/todo_model.dart';
import '../../utils/colors.dart';
import '../../utils/form/q_picker_time.dart';
import '../../utils/form/q_text_field.dart';
import '../../utils/state_util.dart';
import '../../views/home/home_view.dart';

class EditController extends ChangeNotifier {
  static TextEditingController titleController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();
  static ValueNotifier<String?> base64 = ValueNotifier(null);
  static ValueNotifier<String?> selectedDate = ValueNotifier(null);

  static void init(TodoModel data) {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    base64 = ValueNotifier(null);
    selectedDate = ValueNotifier(null);
    selectedDate.value = data.deadline;
    selectedDate.notifyListeners();
    base64.value = data.image;
    base64.notifyListeners();
  }

  static void disposes() {
    titleController.dispose();
    descriptionController.dispose();
    base64.dispose();
    selectedDate.dispose();
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

  static Future<void> edit(TodoModel data) async {
    Loading.show();
    await TodoDb.updateTodo(
        TodoModel(
          id: data.id,
          title: titleController.text,
          description: descriptionController.text,
          createdAt: data.createdAt,
          image: base64.value,
          deadline: selectedDate.value,
        ),
        data.id!);
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

  static showModal(TodoModel data, GlobalKey<FormState> formState) {
    return showModalBottomSheet(
      context: Get.currentContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: Get.height - 80,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
            color: orangeColor,
          ),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Form(
              key: formState,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 80.0,
                        height: 6.0,
                        margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    QTextField(
                      hint: "Design Logo",
                      controller: titleController,
                      value: data.title,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    QTextField(
                      hint: "Description",
                      controller: descriptionController,
                      value: data.description,
                      textInputType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLines: 12,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ValueListenableBuilder<String?>(
                        valueListenable: selectedDate,
                        builder: (_, selectedDate, __) {
                          return QPickerTime(
                            hint: selectedDate!.isEmpty
                                ? "Deadline (Optional)"
                                : selectedDate,
                            onTap: () {
                              pickerDate();
                            },
                            icon: Icons.calendar_month,
                          );
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ValueListenableBuilder<String?>(
                        valueListenable: base64,
                        builder: (_, base64, __) {
                          return QPickerTime(
                            hint:
                                base64!.isEmpty ? "Add Image (Optional)" : "1",
                            onTap: () {
                              takePhoto();
                            },
                            icon: Icons.photo_camera,
                          );
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 48.0,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: orangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () async {
                          await edit(data);
                          Get.off(page: const HomeView());
                        },
                        child: Text(
                          "Edit Todo",
                          style: TextStyle(fontSize: 14.0, color: orangeColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
