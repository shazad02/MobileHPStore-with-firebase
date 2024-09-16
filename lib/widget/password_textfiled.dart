// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../theme.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    // Remove super.key since it's not a valid parameter
    required this.hintText,
    required this.labelText,
    this.onChanged,
    this.controller,
  });

  final String hintText;
  final String labelText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            15,
          ),
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: primaryTextStyle2.copyWith(color: bg2Color),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: bg2Color,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: bg6color, width: 3),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          } else if (value.length < 8) {
            return 'Password Terlalu Pendek';
          }
          return null;
        },
        onChanged: widget.onChanged, // Update to widget.onChanged
      ),
    );
  }
}
