import 'package:flutter/material.dart';
import 'package:starcell/theme.dart';

class DeleviryBox extends StatelessWidget {
  final String text;
  final String jenis;
  final bool selected;

  const DeleviryBox({
    super.key,
    required this.text,
    required this.selected,
    required this.jenis,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Container(
        height: MediaQuery.of(context).size.height * 8 / 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(
            color: selected ? bg2Color : Colors.grey,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  jenis,
                  textAlign: TextAlign.center,
                  style: primaryTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: selected ? bg2Color : Colors.grey,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: selected ? bg2Color : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
