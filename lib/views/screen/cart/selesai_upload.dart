import 'dart:async';
import 'package:starcell/navigator/navigator_screen.dart';
import 'package:starcell/theme.dart';
import 'package:flutter/material.dart';

import '../../../util/dimensions.dart';

import '../../../util/images.dart';

class SelesaiUpload extends StatefulWidget {
  const SelesaiUpload({super.key});

  @override
  State<SelesaiUpload> createState() => _SelesaiUploadState();
}

class _SelesaiUploadState extends State<SelesaiUpload> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Checkout",
          style: primaryTextStyle.copyWith(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(
            Dimensions.PADDING_SIZE_EXTRA_LARGE,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(child: Image.asset(Images.cekout3)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 15 / 100,
              ),
              Image.asset(
                Images.oke,
                width: MediaQuery.of(context).size.height * 30 / 100,
              ),
              const SizedBox(
                height: Dimensions.PADDING_SIZE_LARGE,
              ),
              Text(
                "Pesanan Sukses",
                style: primaryTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Terima kasih telah membeli. Pesanan Anda \n akan dicek Admin 1 x 24 jam",
                style:
                    primaryTextStyle.copyWith(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
