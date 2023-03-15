import 'package:flutter/material.dart';

import '../colors.dart';

class QPickerTime extends StatelessWidget {
  final VoidCallback onTap;
  final String hint;
  final IconData icon;

  const QPickerTime(
      {Key? key, required this.hint, required this.onTap, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      readOnly: true,
      autofocus: false,
      decoration: InputDecoration(
        suffixIcon: Icon(icon),
        suffixIconColor: Colors.white,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16.0,
          color: Colors.white.withOpacity(.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            width: 2.0,
            color: boldOrangeColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            width: 2.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
