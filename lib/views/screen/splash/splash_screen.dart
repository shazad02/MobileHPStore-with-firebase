import 'dart:async';
import 'package:starcell/theme.dart';
import 'package:flutter/material.dart';

import '../../../util/dimensions.dart';

import '../../../util/images.dart';
import '../login/login_screen.dart';

class SplashScrren extends StatefulWidget {
  const SplashScrren({super.key});

  @override
  State<SplashScrren> createState() => _SplashScrrenState();
}

class _SplashScrrenState extends State<SplashScrren> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel the timer if the widget is being disposed
    _cancelTimer();
  }

  Timer? _timer;

  void startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Check if the widget is still mounted before navigating
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const LoginScreen(),
          ),
        );
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1Color,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(
            Dimensions.PADDING_SIZE_EXTRA_LARGE,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Images.logoo,
                width: MediaQuery.of(context).size.height * 30 / 100,
              ),
              const SizedBox(
                height: Dimensions.PADDING_SIZE_LARGE,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
