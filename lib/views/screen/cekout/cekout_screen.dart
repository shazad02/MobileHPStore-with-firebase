// ignore_for_file: unused_element, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';
import '../../../theme.dart';
import '../../../util/dimensions.dart';

import 'components/cekout_card.dart';

class CekoutScreen extends StatefulWidget {
  const CekoutScreen({super.key});

  @override
  State<CekoutScreen> createState() => _CekoutScreenState();
}

class _CekoutScreenState extends State<CekoutScreen> {
  late ProductProvider productProvider;
  String userAddress = '';
  String userName = '';
  String lengkapUser = '';
  String status = 'Belum Bayar';
  String tipe = 'Standard';
  double ongkirPrice = 0.0;
  int index = 0;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    getUserAddress();
  }

  void getUserAddress() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();

      setState(() {
        userAddress = userSnapshot['alamat'];
        lengkapUser = userSnapshot['lengkap'];
        userName = userSnapshot['name'];
      });

      getOngkirPrice();
    }
  }

  void getOngkirPrice() async {
    // Get ongkir price from Firestore based on user address
    QuerySnapshot ongkirSnapshot = await FirebaseFirestore.instance
        .collection('ongkir')
        .where('name', isEqualTo: userAddress)
        .get();

    if (ongkirSnapshot.size > 0) {
      setState(() {
        ongkirPrice = double.parse(ongkirSnapshot.docs[0]['price']);
      });
    }
  }

  Widget _buildBottomSingleDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: primaryTextStyle.copyWith(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            color: Colors.grey,
          ),
        ),
        Text(
          endName,
          style: primaryTextStyle.copyWith(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSingle(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: primaryTextStyle.copyWith(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            color: Colors.black87,
          ),
        ),
        Text(
          endName,
          style: primaryTextStyle.copyWith(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buttonAdd() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Beli",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    double totalPrice = 0.0;
    double totalProductQuent = 0.0;
    for (var cardModel in productProvider.getCardModelList) {
      totalPrice += cardModel.price * cardModel.quenty;
    }
    for (var cardModel in productProvider.getCardModelList) {
      totalProductQuent += cardModel.quenty;
    }

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg1Color,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Checkout",
          style: primaryTextStyle.copyWith(color: Colors.black87),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(context, '/cart');
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 24.0,
            color: Colors.black87,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                itemCount: productProvider.getCardModelListLength,
                itemBuilder: (context, myIndex) {
                  index = myIndex;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CekoutCard(
                          imageUrl:
                              productProvider.getCardModelList[myIndex].image,
                          title: productProvider.getCardModelList[myIndex].name,
                          price:
                              productProvider.getCardModelList[myIndex].price,
                          count:
                              productProvider.getCardModelList[myIndex].quenty,
                          totalPrice: totalPrice,
                          index: myIndex,
                          category:
                              productProvider.getCardModelList[index].category,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: bg1Color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Divider(
                      height: 7,
                      color: Colors.black87,
                    ),
                    _buildBottomSingleDetail(
                      startName: "Jumlah Barang",
                      endName: "${totalProductQuent.toStringAsFixed(0)} Item",
                    ),
                    _buildBottomSingleDetail(
                      startName: "Ongkir",
                      endName: productProvider.getCardModelListLength > 0
                          ? "Rp ${ongkirPrice.toInt()}"
                          : "Rp 0",
                    ),
                    _buildBottomSingleDetail(
                      startName: "Subtotal",
                      endName: "Rp ${totalPrice.toInt()}",
                    ),
                    _buildBottomSingle(
                      startName: "Total Pembayaran",
                      endName: productProvider.getCardModelListLength > 0
                          ? "Rp ${totalPrice.toInt() + ongkirPrice.toInt()}"
                          : "Rp 0",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total ",
                  style: primaryTextStyle.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                Text(
                  productProvider.getCardModelListLength > 0
                      ? "Rp ${totalPrice.toInt() + ongkirPrice.toInt()}"
                      : "Rp 0",
                  style: primaryTextStyle.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: bg2Color,
              ),
              height: 45,
              width: MediaQuery.of(context).size.width * 40 / 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: bg2Color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  if (productProvider.cartModelList.isNotEmpty) {
                    print("Button diklik");
                    User? user = FirebaseAuth.instance.currentUser;
                    String? userId = user?.uid;

                    String? userEmail = user?.email;
                    double totalProductPrice =
                        0.0; // Initialize total product price
                    for (var cardModel in productProvider.getCardModelList) {
                      totalProductPrice += cardModel.price * cardModel.quenty;
                    }
                    String kodeOrder = FirebaseFirestore.instance
                        .collection("order")
                        .doc()
                        .id; // Generate unique ID

                    FirebaseFirestore.instance.collection("order").add({
                      "produk": productProvider.cartModelList
                          .map((c) => {
                                "produkName": c.name,
                                "produkPrice": c.price,
                                "produkQuantity": c.quenty,
                              })
                          .toList(),
                      "kodeOrder": kodeOrder, // Add unique ID as primary key
                      "totalPrice": totalProductPrice + ongkirPrice.toInt(),
                      "userName": userName,
                      "userEmail": userEmail,
                      "tipe": tipe,
                      "userAlamat": userAddress,
                      "lengkapUser": lengkapUser,
                      "UserUid": userId,
                      "status": status,
                      "ongkir": ongkirPrice.toInt(),
                      'time': FieldValue.serverTimestamp(),
                    });

                    productProvider.clearCartProduk();
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //     fullscreenDialog: true,
                    //     builder: (context) => PayScreen(
                    //       kodeOrder: kodeOrder,
                    //       userId: userId!,
                    //       lengkapUser: lengkapUser,
                    //       total: (totalProductPrice + ongkirPrice.toInt())
                    //           .toStringAsFixed(0),
                    //     ),
                    //   ),
                    // );
                  } else {
                    // Tindakan lain yang ingin Anda lakukan saat tombol diklik tetapi keranjang belanja kosong
                  }
                },
                child: Text(
                  "Chekout",
                  style: primaryTextStyle.copyWith(
                      color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
