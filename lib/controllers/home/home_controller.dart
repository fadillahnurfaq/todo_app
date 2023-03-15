import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:todo_app/utils/snackbar/show_custom_snackbar.dart';

import '../../db/todo_db.dart';
import '../../models/todo_model.dart';

class HomeController extends ChangeNotifier {
  static ValueNotifier<List<TodoModel>?> listTodo = ValueNotifier(null);

  static ValueNotifier<String> currentLocation = ValueNotifier("");

  static Future<void> getTodo() async {
    listTodo.value = [];
    listTodo.notifyListeners();

    try {
      listTodo.value = null;
      listTodo.notifyListeners();
      await Future.delayed(const Duration(seconds: 2));
      List<Map<String, dynamic>> todoData = await TodoDb.query();
      List<TodoModel> data =
          todoData.map((e) => TodoModel.fromJson(e)).toList();
      listTodo.value = data;
      listTodo.notifyListeners();
    } catch (e) {}
  }

  static void init() async {
    listTodo = ValueNotifier(null);
  }

  static Future<void> disposes() async {
    listTodo.dispose();
  }

  static void getLocation() async {
    Map<String, dynamic> getLocation = await location();
    if (getLocation["error"] != true) {
      Position position = getLocation["position"];
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      String address =
          "${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}";
      currentLocation.value = address;
      currentLocation.notifyListeners();
      // currentLocation.value = "${position.latitude},${position.longitude}";
      // currentLocation.notifyListeners();
    } else {
      showCustomSnackbar(getLocation["message"]);
    }
  }

  static Future<Map<String, dynamic>> location() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return {
        "message":
            "Tidak dapat mengambil lokasi anda, Silahkan nyalakan GPS anda.",
        "error": true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {
          "message": "Izin menggunakan GPS ditolak.",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return {
        "message":
            "Settingan hp anda tidak memperbolehkan untuk mengakses GPS, Silahkan ubah pada settingan Hp anda,",
        "error": true,
      };
    }

    Position? position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 7),
    );
    return {
      "position": position,
      "message": "Berhasil mendapatkan lokasi anda.",
      "error": false,
    };
  }
}
