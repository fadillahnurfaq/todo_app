import 'dart:convert';

import 'package:flutter/material.dart';

import '../../controllers/crud/delete_controller.dart';
import '../../controllers/crud/edit_controller.dart';
import '../../models/todo_model.dart';
import '../../utils/colors.dart';
import '../../utils/state_util.dart';
import 'detail_photo_view.dart';

class TodoDetailView extends StatefulWidget {
  final TodoModel data;
  const TodoDetailView({super.key, required this.data});

  @override
  State<TodoDetailView> createState() => _TodoDetailViewState();
}

class _TodoDetailViewState extends State<TodoDetailView> {
  @override
  void initState() {
    EditController.init(widget.data);
    super.initState();
  }

  @override
  void dispose() {
    EditController.disposes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formState = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 24.0,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              EditController.showModal(widget.data, formState);
            },
            icon: const Icon(
              Icons.edit,
              size: 24.0,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                DeleteController.delete(widget.data.id!);
              },
              icon: const Icon(
                Icons.delete_outline,
                size: 24.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Title",
              style: TextStyle(
                  fontSize: 26.0,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              widget.data.title ?? "",
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              "Description",
              style: TextStyle(
                  fontSize: 26.0,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              widget.data.description ?? "",
              style: const TextStyle(
                fontSize: 16.0,
                fontFamily: "Montserrat",
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "Photo",
              style: TextStyle(
                  fontSize: 26.0,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            if (widget.data.image!.isNotEmpty)
              InkWell(
                onTap: () {},
                child: Stack(
                  children: [
                    Image.memory(
                      base64Decode(widget.data.image!),
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 150,
                      left: Get.width / 2 - 40.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orangeColor,
                        ),
                        onPressed: () {
                          Get.to(
                            page: DetailPhotoView(data: widget.data.image!),
                          );
                        },
                        child: const Text("ZOOM"),
                      ),
                    )
                  ],
                ),
              ),
            if (widget.data.image!.isEmpty)
              const Center(
                child: Text(
                  "No Picture",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: widget.data.deadline!.isEmpty
          ? null
          : Container(
              height: 60.0,
              color: orangeColor,
              child: Center(
                child: Text(
                  "Deadline ${widget.data.deadline}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Montserrat",
                    color: Colors.white,
                  ),
                ),
              ),
            ),
    );
  }
}
