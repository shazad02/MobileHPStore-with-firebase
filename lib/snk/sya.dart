// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:starcell/theme.dart';
import 'package:flutter/material.dart';

class SyaratScreen extends StatefulWidget {
  const SyaratScreen({super.key});

  @override
  State<SyaratScreen> createState() => _SyaratScreenState();
}

class _SyaratScreenState extends State<SyaratScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg2Color,
        title: const Text("Syarat Dan Ketentuan"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Syarat Dan Ketentuan",
                style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            ],
          ),
        ),
      ),
    );
  }
}
