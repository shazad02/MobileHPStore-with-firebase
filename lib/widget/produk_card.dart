import 'package:flutter/material.dart';

import '../theme.dart';
import '../views/screen/produk/detail_produk/detail_screen.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  late final String category;
  String? description;
  final VoidCallback? onAdd;

  ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    this.onAdd,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => DetailScreen(
              category: category,
              description: description ?? '',
              image: image,
              name: name,
              price: price,
            ),
          ),
        );
      },
      child: Card(
        color: bg1Color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  // ignore: unnecessary_null_comparison
                  child: image != null
                      ? Image.network(
                          image,
                          fit: BoxFit.fill,
                          height: 150,
                          width: 200,
                        )
                      : Container(
                          height: 150,
                          width: 200,
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: primaryTextStyle2.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: bg2Color,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    category,
                    style: primaryTextStyle2.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Rp ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        price.toInt().toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
