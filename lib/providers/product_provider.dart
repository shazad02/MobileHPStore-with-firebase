// ignore_for_file: non_constant_identifier_names

import 'package:starcell/models/pay_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/cart_model.dart';
import '../models/produck_model.dart';
import '../models/user_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _populerProducts = [];
  List<Product> _priaProduk = [];
  List<PayModel> _PayProducts = [];

  List<Product> get populerProducts {
    return [..._populerProducts];
  }

  List<Product> get priaProduk {
    return [..._priaProduk];
  }

  List<PayModel> get payProducts {
    return [..._PayProducts];
  }

  Future<void> fetchPopulerProducts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection("products").get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          snapshot.docs;

      _populerProducts = documents
          .map((document) => Product.fromJson(document.data()))
          .toList();
    } catch (error) {
      throw 'Failed to fetch popular products: $error';
    }
  }

  Future<void> fetchMinumanProducts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection("products")
              .where("category", whereIn: ["makanan"]).get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          snapshot.docs;

      _priaProduk = documents
          .map((document) => Product.fromJson(document.data()))
          .toList();
    } catch (error) {
      throw 'Failed to fetch minuman products: $error';
    }
  }

  Future<void> fetchPayProducts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection("pembayaran").get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          snapshot.docs;

      _PayProducts = documents
          .map((document) => PayModel.fromJson(document.data()))
          .toList();
    } catch (error) {
      throw 'Failed to fetch Pay products: $error';
    }
  }

  void addOrder() {}

  List<CartModel> cartModelList = [];
  late CartModel cartModel;

  void getCardData({
    required String name,
    required String image,
    required int quenty,
    required double price,
    required String category,
  }) {
    cartModel = CartModel(
      image: image,
      price: price,
      quenty: quenty,
      name: name,
      category: category,
    );
    cartModelList.add(cartModel);
  }

  List<CartModel> get getCardModelList {
    return List.from(cartModelList);
  }

  int get getCardModelListLength {
    return cartModelList.length;
  }

  List<CartModel> makeModelList = [];
  late CartModel makeModel;

  void getMakeData({
    required String name,
    required String image,
    required int quenty,
    required double price,
    required String category,
  }) {
    cartModel = CartModel(
      image: image,
      price: price,
      quenty: quenty,
      name: name,
      category: category,
    );
    makeModelList.add(cartModel);
  }

  List<CartModel> get getMakeModelList {
    return List.from(makeModelList);
  }

  int get getMakeModelListLength {
    return makeModelList.length;
  }

  List<String> notificationList = [];
  void addNotif(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  // List<CartModel> checkOutModelList = [];
  // late CartModel checkOutModel;

  // void getCheckOutData({
  //   required String name,
  //   required String image,
  //   required int quenty,
  //   required double price,
  // }) {
  //   checkOutModel = CartModel(
  //     image: image,
  //     price: price,
  //     quenty: quenty,
  //     name: name,
  //   );
  //   checkOutModelList.add(checkOutModel);
  // }

  // List<CartModel> get getCheckOutModelList {
  //   return List.from(checkOutModelList);
  // }

  // int get getCheckOutModelListLength {
  //   return checkOutModelList.length;
  // }

  List<UserModel> userModelList = [];
  late UserModel userModel;

  Future<void> getUserData() async {
    List<UserModel> newList = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot = await FirebaseFirestore.instance
        .collection("user")
        .where("userid", isEqualTo: currentUser?.uid)
        .get();

    for (var element in userSnapShot.docs) {
      if (currentUser?.uid ==
          (element.data() as Map<String, dynamic>)["userid"]) {
        userModel = UserModel(
          alamat: (element.data() as Map<String, dynamic>)["alamat"] ?? '',
          email: (element.data() as Map<String, dynamic>)["email"] ?? '',
          name: (element.data() as Map<String, dynamic>)["name"] ?? '',
          phone: (element.data() as Map<String, dynamic>)["phone"] ?? '',
          lengkap: (element.data() as Map<String, dynamic>)["lengkap"] ?? '',
        );
        newList.add(userModel);
      }
    }

    userModelList = newList;
  }

  Future<void> updateUserData({
    required String newName,
    required String newEmail,
    required String newPhone,
    required String newAlamat,
    required String newLengkap,
  }) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection("user")
            .doc(currentUser.uid)
            .update({
          "name": newName,
          "email": newEmail,
          "phone": newPhone,
          "alamat": newAlamat,
          "lengkap": newLengkap,
        });

        // Update the user model in the list
        int index =
            userModelList.indexWhere((user) => user.userid == currentUser.uid);
        if (index != -1) {
          userModelList[index] = UserModel(
            name: newName,
            email: newEmail,
            phone: newPhone,
            alamat: newEmail,
            lengkap: newLengkap,
          );
        }

        notifyListeners();
      }
    } catch (error) {
      throw 'Failed to update user data: $error';
    }
  }

  late String _userAddress = '';

  String get getUserAddress {
    return _userAddress;
  }

  Future<void> getUserAddressData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection("user")
        .doc(currentUser?.uid)
        .get();

    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    _userAddress = userData['alamat'] ?? '';
  }

  void deleteCartProduk(int index) {
    cartModelList.removeAt(index);
    notifyListeners();
  }

  void clearCartProduk() {
    cartModelList.clear();
    notifyListeners();
  }

  void deleteMakeProduk(int index) {
    makeModelList.removeAt(index);
    notifyListeners();
  }

  void clearMakeProduk() {
    makeModelList.clear();
    notifyListeners();
  }

  bool isLoggedIn() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null;
  }
}
