import 'package:starcell/theme.dart';
import 'package:flutter/material.dart';

import '../../../../util/dimensions.dart';

// ignore: must_be_immutable
class TextSnk extends StatelessWidget {
  TextSnk({
    required this.textSya,
    this.colorText,
    this.onTap,
    super.key,
  });
  String textSya;
  Color? colorText;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        textSya,
        style: priceTextStyle.copyWith(
            color: colorText ?? Theme.of(context).secondaryHeaderColor,
            fontSize: Dimensions.FONT_SIZE_DEFAULT),
      ),
    );
  }
}
