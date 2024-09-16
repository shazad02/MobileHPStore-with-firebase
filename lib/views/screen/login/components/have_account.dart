import 'package:starcell/theme.dart';
import 'package:flutter/material.dart';

import '../../../../util/dimensions.dart';

class RegisAcc extends StatelessWidget {
  final Function onPressed;
  final String textName;
  final String whichAcc;

  const RegisAcc({
    super.key,
    required this.textName,
    required this.onPressed,
    required this.whichAcc,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          whichAcc,
          style: priceTextStyle.copyWith(
            fontSize: Dimensions.FONT_SIZE_DEFAULT,
            color: Theme.of(context).secondaryHeaderColor,
            fontWeight: FontWeight.normal,
          ),
        ),
        GestureDetector(
          onTap: onPressed as void Function(),
          child: Text(
            textName,
            style: priceTextStyle.copyWith(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              color: Theme.of(context).splashColor,
            ),
          ),
        ),
      ],
    );
  }
}
