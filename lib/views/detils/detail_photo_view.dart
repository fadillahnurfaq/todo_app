import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../utils/state_util.dart';

class DetailPhotoView extends StatelessWidget {
  final String data;
  const DetailPhotoView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: PhotoView(
          imageProvider: MemoryImage(
        base64Decode(data),
      )),
    );
  }
}
