import 'package:flutter/material.dart';

import 'package:starcell/theme.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final List<String> items;
  final String? value;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownButtonFormField({
    super.key,
    this.hintText,
    this.labelText,
    required this.items,
    this.value,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 6 / 100,
      margin: const EdgeInsets.only(),
      decoration: BoxDecoration(
        color: bg1Color,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: primaryTextStyle2.copyWith(color: Colors.black),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        value: value,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
