import 'package:starcell/theme.dart';
import 'package:starcell/views/screen/dashboard/cari.dart';
import 'package:starcell/views/screen/splash/splash_screen.dart';
import 'package:starcell/widget/button_cus.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/product_provider.dart';
import '../../cart/cart_screen.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  final String category;
  final String description;

  const DetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count = 1;
  late ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg6color,
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 25.0,
            color: Colors.black87,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(context, '/navigator');
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 24.0,
            color: bg2Color,
          ),
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const CariScreenn(
                        namescreen: '',
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.search,
                  size: 24.0,
                  color: bg2Color,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const CartScreen(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.shopping_bag,
                  size: 24.0,
                  color: bg2Color,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 350,
              child: Stack(
                children: [
                  Image.network(
                    widget.image,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.category,
                                style: primaryTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                widget.name,
                                style: primaryTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 25.0,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Rp ",
                                    style: primaryTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    widget.price.toInt().toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                            color: bg2Color,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (count > 1) {
                                      count--;
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: bg1Color,
                                ),
                              ),
                              Text(
                                count.toString(),
                                style: primaryTextStyle.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: bg1Color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.description,
                      style: primaryTextStyle.copyWith(
                          fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 30),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ButtonCus(
          textButton: "Buat pesanan",
          onPressed: () {
            // Check if the user is logged in
            bool isLoggedIn = productProvider.isLoggedIn();
            if (isLoggedIn) {
              productProvider.getCardData(
                name: widget.name,
                image: widget.image,
                quenty: count,
                price: widget.price,
                category: widget.category,
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            } else {
              // Show AlertDialog with message if not logged in
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Login Required"),
                    content: const Text(
                        "Kamu Harus login untuk menggunakan fitur ini."),
                    actions: [
                      // TextButton(
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      //   child: const Text("OK"),
                      // ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const SplashScrren(),
                            ),
                          );
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  );
                },
              );
            }
          },
          textcolor: bg1Color,
          buttomcolor: bg2Color,
        ),
      ),
    );
  }
}
