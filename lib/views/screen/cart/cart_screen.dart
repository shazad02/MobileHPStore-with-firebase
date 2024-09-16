import 'package:starcell/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starcell/views/screen/cart/select_alamat.dart';
import '../../../providers/product_provider.dart';
import '../dashboard/components/Rekomendasi/rekomendasi_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late ProductProvider productProvider;
  bool isEmpty = false;
  final TextEditingController _promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    if (productProvider.getCardModelListLength == 0) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg1Color,
        title: Text(
          "Keranjang",
          style: primaryTextStyle.copyWith(color: Colors.black87),
        ),
        elevation: 0,
        centerTitle: true,
        actions: const [
          SizedBox(
            width: 10,
          ),
        ],
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
      body: isEmpty
          ? Center(
              child: Text(
                "Tidak ada Barang di keranjang",
                style: primaryTextStyle.copyWith(fontSize: 18, color: bg2Color),
              ),
            )
          : ListView.builder(
              itemCount: productProvider.getCardModelListLength,
              itemBuilder: (context, index) => RekomendasiCard(
                index: index,
                imageUrl: productProvider.getCardModelList[index].image,
                title: productProvider.getCardModelList[index].name,
                price: productProvider.getCardModelList[index].price,
                count: productProvider.getCardModelList[index].quenty,
                category: productProvider.getCardModelList[index].category,
              ),
            ),
      bottomNavigationBar: isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _promoCodeController,
                            decoration: const InputDecoration(
                              hintText: "Masukkan kode promo",
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            style: primaryTextStyle.copyWith(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Implement promo code logic here
                          },
                          child: Text(
                            "Gunakan",
                            style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: bg2Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: bg2Color,
                    ),
                    height: 50,
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const SelectAlamat(),
                          ),
                        );
                      },
                      icon: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: bg6color,
                        ),
                      ),
                      label: const Text(
                        "Pesan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: bg6color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
