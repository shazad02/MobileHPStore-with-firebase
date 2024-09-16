// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starcell/models/pay_model.dart';
import 'package:starcell/providers/product_provider.dart';
import 'package:starcell/theme.dart';
import 'package:starcell/util/images.dart';
import 'package:starcell/views/screen/cart/pay_cart.dart';

class PayScreen extends StatefulWidget {
  final String kodeOrder;
  final String userId;
  final String lengkapUser;
  final String total;
  final String username;
  final String address;

  const PayScreen({
    super.key,
    required this.kodeOrder,
    required this.userId,
    required this.lengkapUser,
    required this.total,
    required this.username,
    required this.address,
  });

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchPayProducts();
    setState(() {
      _isLoading = false;
    });
  }

  Widget _payProduct() {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        final List<PayModel> paymodels = productProvider.payProducts;

        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (paymodels.isEmpty) {
          return Center(
            child: Text(
              'Tidak ada data pembayaran.',
              style: primaryTextStyle2.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: paymodels.length,
            itemBuilder: (context, index) {
              PayModel payModel = paymodels[index];
              return PayCard(
                image: payModel.image,
                nama: payModel.nama,
                nomor: payModel.nomor,
                penerima: payModel.penerima,
                orderId: payModel.id,
                kodeOrder: widget.kodeOrder,
                userId: widget.userId,
                lengkapUser: widget.lengkapUser,
                total: widget.total,
                username: widget.username,
                address: widget.address,
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Buat Pesanan",
          style: primaryTextStyle.copyWith(color: Colors.black),
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
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(child: Image.asset(Images.cekout2)),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Pilih Metode Pembayaran",
                style: primaryTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              _payProduct(),
            ],
          ),
        ),
      ),
    );
  }
}
