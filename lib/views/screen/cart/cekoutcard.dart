// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:starcell/providers/product_provider.dart';

import 'package:starcell/theme.dart';
import 'package:provider/provider.dart';

class CekOutCardd extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  int index;
  int count;
  final String category;
  final double totalPrice;

  CekOutCardd({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.count,
    required this.index,
    required this.category,
    required this.totalPrice,
  });

  @override
  State<CekOutCardd> createState() => _CekOutCarddState();
}

class _CekOutCarddState extends State<CekOutCardd> {
  late ProductProvider productProvider;
  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 27 / 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: bg3Color,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: primaryTextStyle.copyWith(
                                        fontSize: 19,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Kategori: ${widget.category}",
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // IconButton(
                                  //   onPressed: () {
                                  //     productProvider
                                  //         .deleteCartProduk(widget.index);
                                  //   },
                                  //   icon: const Icon(
                                  //     Icons.delete,
                                  //     size: 26,
                                  //     color: Colors.red,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Barang ",
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.count.toString(),
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Rp ${widget.price.toInt().toString()}",
                                style: primaryTextStyle.copyWith(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
