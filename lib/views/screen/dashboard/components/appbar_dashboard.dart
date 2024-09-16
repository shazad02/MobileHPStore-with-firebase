import 'package:flutter/material.dart';

class AppbarDash extends StatelessWidget {
  const AppbarDash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "StarCell",
          style: TextStyle(color: Colors.black87),
        ),
      ],
    );
  }
}
