import 'package:flutter/material.dart';

import '../theme.dart';

// ignore: must_be_immutable
class CustomTextFil extends StatelessWidget {
  CustomTextFil({
    this.readOnly,
    required this.hintText,
    this.labelText,
    this.obscureText,
    this.validate,
    this.keyboardType,
    super.key,
    this.onChanged,
    this.controller,
    this.decoration,
  });

  String hintText;
  InputDecoration? decoration;
  String? labelText;
  bool? readOnly;
  bool? obscureText;
  TextInputType? keyboardType;
  FormFieldValidator<String>? validate;
  void Function(String)? onChanged;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validate,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: primaryTextStyle2.copyWith(color: bg2Color),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: bg6color, width: 3),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }
}
