import 'package:flutter/material.dart';

import '../theme.dart';

class FavoritCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;

  const FavoritCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 14,
        left: 12,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: navColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              width: 60,
              height: 60,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: primaryTextStyle.copyWith(
                    fontWeight: semibold,
                  ),
                ),
                Text(
                  price.toString(),
                  style: priceTextStyle,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
