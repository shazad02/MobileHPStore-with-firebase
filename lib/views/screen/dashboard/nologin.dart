// ignore_for_file: avoid_print, unused_local_variable, use_build_context_synchronously, duplicate_ignore, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starcell/theme.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/produck_model.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/product_provider.dart';
import '../../../widget/custom_category.dart';
import '../../../widget/produk_card.dart';

import '../produk/listproduc.dart';
import '../splash/splash_screen.dart';

import 'components/appbar_dashboard.dart';

class NoLogin extends StatefulWidget {
  const NoLogin({super.key});

  @override
  State<NoLogin> createState() => _NoLoginState();
}

class _NoLoginState extends State<NoLogin> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchPopulerProducts();
    Provider.of<ProductProvider>(context, listen: false).fetchMinumanProducts();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _logout() async {
    await _auth.signOut();
    // ignore: deprecated_member_use, use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScrren(),
      ),
      (route) => false,
    );
  }

  Widget _allProduk() {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        final List<Product> products = productProvider.populerProducts;

        if (products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: double.infinity,
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];
              return ProductCard(
                image: product.image,
                name: product.name,
                price: product.price,
                onAdd: () {
                  print('Tombol tambah diklik');
                },
                category: product.category,
                description: product.description,
              );
            },
          ),
        );
      },
    );
  }

  Widget _dashMakanan() {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        final List<Product> products = productProvider.priaProduk;

        if (products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: double.infinity,
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];
              return ProductCard(
                image: product.image,
                name: product.name,
                price: product.price,
                description: product.description,
                onAdd: () {
                  print('Tombol tambah diklik');
                },
                category: product.category,
              );
            },
          ),
        );
      },
    );
  }

  Widget ProduckCate() {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection("products")
          .where("category", whereIn: ["coffe", "noncoffe"]).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          QuerySnapshot<Map<String, dynamic>> querySnapshot = snapshot.data!;
          List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
              querySnapshot.docs;

          List<Product> products = documents
              .map((document) => Product.fromJson(document.data()))
              .toList();

          return SizedBox(
            width: double.infinity,
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return ProductCard(
                  image: product.image,
                  name: product.name,
                  price: product.price,
                  description: product.description,
                  onAdd: () {
                    print('Tombol tambah diklik');
                  },
                  category: product.category,
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget wanitaCate() {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection("products")
          .where("category", whereIn: ["wanita"]).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          QuerySnapshot<Map<String, dynamic>> querySnapshot = snapshot.data!;
          List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
              querySnapshot.docs;

          List<Product> products = documents
              .map((document) => Product.fromJson(document.data()))
              .toList();

          return SizedBox(
            width: double.infinity,
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return ProductCard(
                  image: product.image,
                  name: product.name,
                  price: product.price,
                  description: product.description,
                  onAdd: () {
                    print('Tombol tambah diklik');
                  },
                  category: product.category,
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _categoryButton() {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: ScrollController(),
          child: Row(
            children: [
              IconTextCard(
                text: 'coffe',
                onTap: () {
                  categoryProvider.setCategory('coffe');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListProduct(
                        isEqualTo: 'coffe',
                        namescreen: 'coffe Product',
                      ),
                    ),
                  );
                },
              ),
              IconTextCard(
                text: 'noncoffe',
                onTap: () {
                  categoryProvider.setCategory('noncoffe');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListProduct(
                        isEqualTo: 'noncoffe',
                        namescreen: 'noncoffe Product',
                      ),
                    ),
                  );
                },
              ),
              IconTextCard(
                text: 'food',
                onTap: () {
                  categoryProvider.setCategory('food');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListProduct(
                        isEqualTo: 'makanan',
                        namescreen: 'Food Product',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    late ProductProvider productProvider;
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bg1Color,
        elevation: 0,
        title: const AppbarDash(),
        actions: [
          GestureDetector(
            onTap: _logout,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.logout,
                  color: bg2Color,
                ),
              ),
            ),
          ),
          const Icon(
            Icons.search,
            size: 30.0,
            color: Colors.black87,
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.shopping_bag,
            size: 30.0,
            color: Colors.black87,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: bg2Color,
              ),
              child: Text("text"),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(
                    Icons.home,
                    size: 24.0,
                    color: Colors.black87,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Home',
                    style: priceTextStyle.copyWith(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoLogin(),
                  ),
                );
              },
            ),

            ListTile(
              title: GestureDetector(
                onTap: _logout,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.logout,
                      color: bg2Color,
                    ),
                  ),
                ),
              ),
            ),

            // Add more ListTiles for additional items in the drawer
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _categoryButton(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "All Product",
                      style: primaryTextStyle.copyWith(
                          fontSize: 20, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              _allProduk(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "All Drink",
                      style: primaryTextStyle.copyWith(
                          fontSize: 20, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              ProduckCate(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Food",
                      style: primaryTextStyle.copyWith(
                          fontSize: 20, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              _dashMakanan(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
