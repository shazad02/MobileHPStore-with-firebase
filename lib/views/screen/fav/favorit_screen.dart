// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, use_super_parameters, no_leading_underscores_for_local_identifiers, unused_element

import 'package:flutter/material.dart';

import '../../../theme.dart';
import '../../../widget/favorit_card.dart';

class FavoritScreen extends StatefulWidget {
  const FavoritScreen({Key? key}) : super(key: key);

  @override
  State<FavoritScreen> createState() => _FavoritScreenState();
}

class _FavoritScreenState extends State<FavoritScreen> {
  @override
  Widget build(BuildContext context) {
    Widget _empty() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.heart_broken_outlined,
              color: bg2Color,
              size: 100, // Ubah ukuran ikon sesuai dengan kebutuhan Anda
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Yah Kamu Gak PUnya Produck Favorit",
              style: primaryTextStyle.copyWith(
                  fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    }

    Widget _addwidget() {
      return const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              FavoritCard(
                  imageUrl:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/600px-Cat03.jpg",
                  title: "title",
                  price: 50),
              FavoritCard(
                  imageUrl:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/600px-Cat03.jpg",
                  title: "title",
                  price: 50),
              FavoritCard(
                  imageUrl:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/600px-Cat03.jpg",
                  title: "title",
                  price: 50),
              FavoritCard(
                  imageUrl:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/600px-Cat03.jpg",
                  title: "title",
                  price: 50),
              FavoritCard(
                  imageUrl:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/600px-Cat03.jpg",
                  title: "title",
                  price: 50),
              FavoritCard(
                  imageUrl:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/600px-Cat03.jpg",
                  title: "title",
                  price: 50),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bg1Color,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Favorit Product",
          style: primaryTextStyle.copyWith(fontSize: 25),
        ),
        actions: const [],
      ),
      body: _empty(),
    );
  }
}
