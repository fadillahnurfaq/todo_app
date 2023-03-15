import 'package:flutter/material.dart';

class QTextField extends StatefulWidget {
  final String? id;
  final String? value;
  final String hint;
  final String? Function(String?)? validator;
  final bool obscure;
  final int? maxLength;
  final int? maxLines;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;

  const QTextField({
    Key? key,
    this.id,
    this.textInputAction,
    this.value,
    this.validator,
    required this.hint,
    this.maxLines,
    this.maxLength,
    this.obscure = false,
    this.prefixIcon,
    this.textInputType = TextInputType.text,
    this.suffixIcon,
    required this.controller,
  }) : super(key: key);

  @override
  State<QTextField> createState() => _QTextFieldState();
}

class _QTextFieldState extends State<QTextField> {
  @override
  void initState() {
    widget.controller.text = widget.value ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines ?? 1,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      autofocus: false,
      style: const TextStyle(
        fontSize: 16.0,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          fontSize: 16.0,
          color: Colors.white,
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: 16.0,
          color: Colors.white.withOpacity(.9),
        ),
        labelStyle: const TextStyle(
          color: Colors.blueGrey,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            width: 2.0,
            color: Colors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            width: 2.0,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            width: 2.0,
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            width: 2.0,
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
