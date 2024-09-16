import 'package:flutter/material.dart';
import '../theme.dart';
import '../util/dimensions.dart';

class ButtonCus extends StatelessWidget {
  final Function onPressed;
  final String textButton;

  const ButtonCus(
      {super.key,
      required this.textButton,
      required this.onPressed,
      required buttomcolor,
      required Color textcolor});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: bg2Color,
        ),
        onPressed: onPressed as void Function(),
        child: Text(
          textButton,
          style: primaryTextStyle.copyWith(
              fontSize: Dimensions.FONT_SIZE_NORMAL,
              color: bg6color,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
