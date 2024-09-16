// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:starcell/providers/product_provider.dart';
import 'package:starcell/util/images.dart';
import 'package:starcell/views/screen/cart/cekoutcard.dart';
import 'package:starcell/views/screen/cart/deleveribox.dart';

import 'package:starcell/views/screen/cart/pilih.dart';
import 'package:starcell/widget/button_cus.dart';

import '../../../../../theme.dart';

class HasilCekout extends StatefulWidget {
  final Map<String, dynamic> addressData;

  const HasilCekout({required this.addressData, super.key});

  @override
  State<HasilCekout> createState() => _HasilCekoutState();
}

class _HasilCekoutState extends State<HasilCekout> {
  late ProductProvider productProvider;
  String userAddress = '';
  String userName = '';
  String lengkapUser = '';
  String address = '';
  String status = 'belum bayar';
  double ongkirPrice = 0.0;
  int estimasi = 0;
  int index = 0;
  double totalPrice = 0.0;
  String selectedDeliveryMethod = 'jne';

  @override
  void initState() {
    super.initState();
    getUserAddress();
  }

  void getUserAddress() async {
    userAddress = widget.addressData['ongkir'];
    address = widget.addressData['address'];
    setState(() {
      userName = widget.addressData['name'];
    });
    getOngkirPrice();
  }

  void getOngkirPrice() async {
    QuerySnapshot ongkirSnapshot = await FirebaseFirestore.instance
        .collection('ongkir')
        .where('name', isEqualTo: userAddress)
        .get();

    if (ongkirSnapshot.size > 0) {
      setState(() {
        ongkirPrice = double.parse(ongkirSnapshot.docs[0]['price']);
        estimasi = int.parse(ongkirSnapshot.docs[0]
            ['estimasi']); // Ensure estimasi is parsed as int
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
          style: primaryTextStyle2.copyWith(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        Text(
          endName,
          style: primaryTextStyle2.copyWith(
            fontSize: 18,
            color: Colors.black,
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
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          endName,
          style: primaryTextStyle.copyWith(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Buat Pesanan",
          style: primaryTextStyle.copyWith(fontSize: 22, color: Colors.black),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(child: Image.asset(Images.cekout2)),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
              child: Text(
                "Jumlah Barang Pesanan",
                style: primaryTextStyle.copyWith(
                    fontSize: 20, color: Colors.black),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                itemCount: productProvider.getCardModelListLength,
                itemBuilder: (context, myIndex) {
                  index = myIndex;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CekOutCardd(
                      imageUrl: productProvider.getCardModelList[myIndex].image,
                      title: productProvider.getCardModelList[myIndex].name,
                      price: productProvider.getCardModelList[myIndex].price,
                      count: productProvider.getCardModelList[myIndex].quenty,
                      totalPrice: totalPrice,
                      index: myIndex,
                      category:
                          productProvider.getCardModelList[index].category,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Text(
                    "Pengiriman",
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDeliveryMethod = 'JNT';
                            });
                          },
                          child: DeleviryBox(
                            text: "${estimasi + 0} - ${estimasi + 1} Days",
                            selected: selectedDeliveryMethod == 'JNT',
                            jenis: 'Reguler',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 100,
                            ),
                            _buildBottomSingleDetail(
                              startName: "Barang:",
                              endName:
                                  "${totalProductQuent.toStringAsFixed(0)} Barang",
                            ),
                            _buildBottomSingleDetail(
                              startName: "Biaya Pengiriman:",
                              endName:
                                  productProvider.getCardModelListLength > 0
                                      ? "Rp ${ongkirPrice.toInt()}"
                                      : "Rp 0",
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 4 / 100,
                            ),
                            _buildBottomSingle(
                              startName: "Total Pembayaran:",
                              endName: productProvider.getCardModelListLength >
                                      0
                                  ? "Rp ${totalPrice.toInt() + ongkirPrice.toInt()}"
                                  : "Rp 0",
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ButtonCus(
                                  textButton: "Pesan Sekarang",
                                  onPressed: () async {
                                    if (productProvider
                                        .cartModelList.isNotEmpty) {
                                      print("Button clicked");
                                      User? user =
                                          FirebaseAuth.instance.currentUser;
                                      String? userId = user?.uid;
                                      String? userEmail = user?.email;
                                      double totalProductPrice = 0.0;
                                      for (var cardModel
                                          in productProvider.getCardModelList) {
                                        totalProductPrice +=
                                            cardModel.price * cardModel.quenty;
                                      }
                                      String kodeOrder = FirebaseFirestore
                                          .instance
                                          .collection("order")
                                          .doc()
                                          .id;

                                      FirebaseFirestore.instance
                                          .collection("order")
                                          .add({
                                        "produk": productProvider.cartModelList
                                            .map((c) => {
                                                  "produkName": c.name,
                                                  "produkPrice": c.price,
                                                  "produkQuantity": c.quenty,
                                                })
                                            .toList(),
                                        "kodeOrder": kodeOrder,
                                        "totalPrice": totalProductPrice +
                                            ongkirPrice.toInt(),
                                        "userName": userName,
                                        "userEmail": userEmail,
                                        "userAlamat": userAddress,
                                        "lengkapUser": widget.addressData,
                                        "UserUid": userId,
                                        "status": status,
                                        "ongkir": ongkirPrice.toInt(),
                                        'time': FieldValue.serverTimestamp(),
                                        "address": address,
                                        "pengiriman": selectedDeliveryMethod,
                                      });

                                      productProvider.clearCartProduk();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (c) => PayScreen(
                                            kodeOrder: kodeOrder,
                                            userId: userId!,
                                            username: userName,
                                            address: address,
                                            lengkapUser: lengkapUser,
                                            total: (totalProductPrice +
                                                    ongkirPrice.toInt())
                                                .toStringAsFixed(0),
                                          ),
                                        ),
                                      );
                                    } else {
                                      // Handle case when cart is empty
                                    }
                                  },
                                  buttomcolor: Colors.green,
                                  textcolor: bg1Color),
                            ),
                          ],
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
