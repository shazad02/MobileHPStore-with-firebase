// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:starcell/theme.dart';

// ignore: must_be_immutable
class CekoutCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  int count;
  int index;
  final double totalPrice;
  final String category;

  CekoutCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.count,
    required this.index,
    required this.totalPrice,
    required this.category,
  });

  @override
  State<CekoutCard> createState() => _CekoutCardState();
}

class _CekoutCardState extends State<CekoutCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding:
                const EdgeInsets.only(left: 12, right: 2, top: 9, bottom: 9),
            width: double.infinity,
            height: 130,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, spreadRadius: 3),
                    ],
                  ),
                  child: Image.network(
                    widget.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: primaryTextStyle.copyWith(
                              fontWeight: FontWeight.w100,
                              fontSize: 19,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.category,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: primaryTextStyle.copyWith(
                              fontWeight: FontWeight.w100,
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 6.5 / 100,
            margin: const EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            color: const Color.fromARGB(255, 194, 194, 194),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      children: [
                        Text(
                          "Qty ${widget.count.toString()}",
                          style: primaryTextStyle.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Rp. ${widget.price.toInt().toString()}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Divider(
              height: 5,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
