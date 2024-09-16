// ignore_for_file: use_super_parameters, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/produck_model.dart';
import '../../../providers/category_provider.dart';
import '../../../theme.dart';
import '../../../widget/produk_card.dart';

class ListProduct extends StatefulWidget {
  final String namescreen;
  final String isEqualTo;

  const ListProduct({
    Key? key,
    required this.isEqualTo,
    required this.namescreen,
  }) : super(key: key);

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    Widget _dashboardPopuler() {
      return Container(
        height: MediaQuery.of(context).size.height * 9 / 10,
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("products")
              .where("category", isEqualTo: widget.isEqualTo)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              QuerySnapshot<Map<String, dynamic>> querySnapshot =
                  snapshot.data!;
              List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                  querySnapshot.docs;

              List<Product> products = documents
                  .map((document) => Product.fromJson(document.data()))
                  .toList();

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.67,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return Column(
                    children: [
                      ProductCard(
                        image: product.image,
                        name: product.name,
                        price: product.price,
                        onAdd: () {
                          print('Tombol tambah diklik');
                        },
                        category: product.category,
                        description: product.description,
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bg1Color,
        centerTitle: false,
        title: Text(
          widget.namescreen,
          style: primaryTextStyle.copyWith(color: bg2Color),
        ),
        actions: const [],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24.0,
            color: bg2Color,
          ),
        ),
      ),
      body: ChangeNotifierProvider<CategoryProvider>(
        create: (_) => CategoryProvider(),
        child: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, _) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    _dashboardPopuler(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
