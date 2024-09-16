// ignore_for_file: avoid_print, unused_local_variable, unused_element, use_build_context_synchronously, duplicate_ignore, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starcell/providers/cekout_provider.dart';
import 'package:starcell/theme.dart';

import 'package:starcell/views/screen/produk/licek.dart';
import 'package:starcell/views/screen/produk/listcek.dart';

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

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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

  Widget allItem() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 7 / 10,
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection("products").get(),
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

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
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

  Widget _categoryButton() {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: ScrollController(),
          child: Row(
            children: [
              IconTextCard(
                text: 'Handphone',
                onTap: () {
                  categoryProvider.setCategory('Hanphone');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListProduct(
                        isEqualTo: 'hp',
                        namescreen: 'Hanphone',
                      ),
                    ),
                  );
                },
              ),
              IconTextCard(
                text: 'casing',
                onTap: () {
                  categoryProvider.setCategory('casing');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListProduct(
                        isEqualTo: 'casing',
                        namescreen: 'casing ',
                      ),
                    ),
                  );
                },
              ),
              IconTextCard(
                text: 'Headset',
                onTap: () {
                  categoryProvider.setCategory('headset');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListProduct(
                        isEqualTo: 'headset',
                        namescreen: 'Headset',
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

  Widget _cekButton() {
    return Consumer<CekProvider>(
      builder: (context, CekProvider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: ScrollController(),
          child: Row(
            children: [
              IconTextCard(
                text: 'Belum Bayar',
                onTap: () {
                  CekProvider.setCategory('Belum Bayar');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Licek(
                        isEqualTo: '',
                        namescreen: '',
                      ),
                    ),
                  );
                },
              ),
              IconTextCard(
                text: 'Tunggu',
                onTap: () {
                  CekProvider.setCategory('Tunggu');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListCek(
                        isEqualTo: 'Tunggu',
                        namescreen: 'Tunggu',
                      ),
                    ),
                  );
                },
              ),
              IconTextCard(
                text: 'Sudah Bayar',
                onTap: () {
                  CekProvider.setCategory('Sudah Bayar');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListCek(
                        isEqualTo: 'Sudah Bayar',
                        namescreen: 'Sudah Bayar',
                      ),
                    ),
                  );
                },
              ),
              IconTextCard(
                text: 'Selesai',
                onTap: () {
                  CekProvider.setCategory('Selesai');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListCek(
                        isEqualTo: 'Selesai',
                        namescreen: 'Selesai',
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
                      "Semua Produk",
                      style: primaryTextStyle.copyWith(
                          fontSize: 20, color: Colors.black87),
                    ),
                  ],
                ),
              ),

              allItem()

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Wanita",
              //         style: primaryTextStyle.copyWith(
              //             fontSize: 20, color: Colors.black87),
              //       ),
              //     ],
              //   ),
              // ),
              // ProduckCate(),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Pesanan",
              //         style: primaryTextStyle.copyWith(fontSize: 20),
              //       ),
              //     ],
              //   ),
              // ),
              // _cekButton(),
              // const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
