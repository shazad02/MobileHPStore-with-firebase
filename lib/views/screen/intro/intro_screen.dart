import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starcell/navigator/navigator_screen.dart';
import 'package:starcell/theme.dart';
import '../../../providers/product_provider.dart';
import '../../../util/images.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
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
            builder: (c) => const NavigatorScreen(),
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
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        return Scaffold(
          backgroundColor: bg2Color,
          appBar: AppBar(
            actions: const [],
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Images.logoo,
                      width: MediaQuery.of(context).size.height * 25 / 100,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<void>(
                          future: productProvider.getUserData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final userModel =
                                  productProvider.userModelList.first;
                              return Text(
                                "HI ${userModel.name},",
                                style: const TextStyle(
                                    color: bg1Color,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Text(
                      "Selamat Datang.",
                      style: primaryTextStyle.copyWith(
                          color: bg1Color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("terima kasih telah bersama kami",
                        style: primaryTextStyle.copyWith(
                            color: bg1Color,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
