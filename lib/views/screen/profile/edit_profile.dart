import 'package:starcell/providers/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/ongkir_model.dart';
import '../../../theme.dart';
import '../../../widget/custom_textfiled.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late ProductProvider productProvider;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController alamatController;
  late TextEditingController lengkapController;
  late List<OngkirModel> dropdownItems = [];
  String selectedDropdownValue = ''; // Initial dropdown value

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    alamatController = TextEditingController();
    lengkapController = TextEditingController();
    // Set the initial values for the text fields
    nameController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.name
        : '';
    emailController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.email
        : '';
    phoneController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.phone
        : '';
    alamatController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.alamat
        : '';
    lengkapController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.lengkap
        : '';
    fetchDropdownItems();
  }

  void fetchDropdownItems() async {
    // Fetch the dropdown items from Firebase Firestore using ongkir.get()
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('ongkir').get();
    List<OngkirModel> items = [];
    for (var doc in querySnapshot.docs) {
      // Assuming the items are stored in a field called "name" in each document
      String itemName = doc['name'];
      double itemPrice =
          doc['price'] != null ? double.parse(doc['price'].toString()) : 0.0;
      String itemId = doc['id'];
      OngkirModel item =
          OngkirModel(name: itemName, price: itemPrice, id: itemId);
      items.add(item);
    }
    setState(() {
      dropdownItems = items;
      selectedDropdownValue = items.isNotEmpty ? items.first.name : '';
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    alamatController.dispose();
    lengkapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg1Color,
        elevation: 0,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _updateUserData();
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.check_rounded,
                size: 30.0,
                color: bg2Color,
              ),
            ),
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 30.0,
            color: bg2Color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Edit Profile",
                style: primaryTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: bg2Color,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nama User",
                            style: primaryTextStyle.copyWith(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFil(
                            controller: nameController,
                            hintText: 'Nama User',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email User",
                            style: primaryTextStyle.copyWith(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFil(
                            readOnly: true,
                            controller: emailController,
                            hintText: 'Email User',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nomer Hp User",
                            style: primaryTextStyle.copyWith(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFil(
                            controller: phoneController,
                            hintText: 'Nomer Hp User',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Alamat Lengkap User",
                            style: primaryTextStyle.copyWith(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFil(
                            hintText: "Alamat Lengkap User",
                            controller: lengkapController,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 10 / 100,
            ),
          ],
        ),
      ),
    );
  }

  void _updateUserData() {
    final String newName = nameController.text;
    final String newEmail = emailController.text;
    final String newPhone = phoneController.text;
    final String newAlamat = alamatController.text;
    final String newLengkap = lengkapController.text;

    // Update the user data using the ProductProvider
    productProvider.updateUserData(
      newName: newName,
      newEmail: newEmail,
      newPhone: newPhone,
      newAlamat: newAlamat,
      newLengkap: newLengkap,
    );

    // Notify listeners of the change
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    productProvider.notifyListeners();
  }
}
