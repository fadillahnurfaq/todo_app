import 'package:flutter/material.dart';

import '../../controllers/crud/add_controller.dart';
import '../../utils/colors.dart';
import '../../utils/form/q_picker_time.dart';
import '../../utils/form/q_text_field.dart';
import '../../utils/state_util.dart';
import '../../utils/validator/validator.dart';

class AddTodoView extends StatefulWidget {
  const AddTodoView({super.key});

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  @override
  void initState() {
    AddController.init();
    super.initState();
  }

  @override
  void dispose() {
    AddController.disposes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formState = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24.0,
            color: Colors.black,
          ),
        ),
        title: Text(
          "TO DO LIST",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: orangeColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              size: 24.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Form(
        key: formState,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                height: Get.height - 30,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                  color: orangeColor,
                ),
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
                      hint: "Title",
                      controller: AddController.titleController,
                      validator: Validator.required,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    QTextField(
                      hint: "Description",
                      controller: AddController.descriptionController,
                      textInputAction: TextInputAction.newline,
                      maxLines: 12,
                      textInputType: TextInputType.multiline,
                      validator: Validator.required,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ValueListenableBuilder<String?>(
                        valueListenable: AddController.selectedDate,
                        builder: (_, selectedDate, __) {
                          return QPickerTime(
                            hint: selectedDate!.isEmpty
                                ? "Deadline (Optional)"
                                : selectedDate,
                            onTap: () {
                              AddController.pickerDate();
                            },
                            icon: Icons.calendar_month,
                          );
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ValueListenableBuilder<String>(
                        valueListenable: AddController.base64,
                        builder: (_, base64, __) {
                          return QPickerTime(
                            hint: base64.isEmpty ? "Add Image (Optional)" : "1",
                            onTap: () {
                              AddController.takePhoto();
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
                          if (!formState.currentState!.validate()) {
                            return;
                          } else {
                            await AddController.addTodo();
                          }
                        },
                        child: Text(
                          "ADD TODO",
                          style: TextStyle(fontSize: 14.0, color: orangeColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
