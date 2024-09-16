// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:starcell/theme.dart';
import 'package:flutter/material.dart';

class CariScreen extends StatefulWidget {
  const CariScreen({super.key});

  @override
  State<CariScreen> createState() => _CariScreenState();
}

class _CariScreenState extends State<CariScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bg2Color,
        title: Text(
          "Dalam Pengembangan",
          style: primaryTextStyle,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Mohon Maaf, Masih Dalam Pengembangan >_<",
                    style: primaryTextStyle.copyWith(
                        color: Colors.black87, fontSize: 25),
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
