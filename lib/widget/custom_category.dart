// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

import '../theme.dart';

class IconTextCard extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const IconTextCard({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Center(
          child: Card(
            color: bg1Color,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Text(
                    text,
                    style: primaryTextStyle.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
