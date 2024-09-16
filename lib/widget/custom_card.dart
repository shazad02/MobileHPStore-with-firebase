// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

import '../theme.dart';
import '../util/dimensions.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.onTap,
    required this.aset,
    required this.buttonText,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTap;
  final String aset;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: bg4color, width: 1),
        ),
        child: AspectRatio(
          aspectRatio: 6.5, // set ratio sesuai dengan kebutuhan
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(aset),
                  radius: 15,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      buttonText,
                      style: primaryTextStyle.copyWith(
                        fontSize: Dimensions.FONT_SIZE_NORMAL,
                        color: bg2Color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
