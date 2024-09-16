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
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: primaryTextStyle2.copyWith(color: bg2Color),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
