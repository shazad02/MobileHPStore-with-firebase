import 'package:starcell/providers/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/ongkir_model.dart';
import '../../../theme.dart';
import '../../../widget/custom_textfiled.dart';
import '../cekout/cekout_screen.dart';

class TujuanScreen extends StatefulWidget {
  const TujuanScreen({super.key});

  @override
  State<TujuanScreen> createState() => _TujuanScreenState();
}

class _TujuanScreenState extends State<TujuanScreen> {
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
        title: Text(
          "Alamat Tujuan",
          style: primaryTextStyle.copyWith(fontSize: 25, color: bg2Color),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _updateUserData();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const CekoutScreen(),
                  ),
                );
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
            Icons.clear,
            size: 30.0,
            color: bg2Color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                            "Nama Lengkap",
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
                            hintText: 'Nama Lengkap',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nomer Handphone",
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
                            hintText: 'Nomer Handphone',
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
                            "Daerah ",
                            style: primaryTextStyle.copyWith(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFil(
                            hintText: "Daerah ",
                            controller: alamatController,
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
                            "Alamat Lengkap ",
                            style: primaryTextStyle.copyWith(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFil(
                            hintText: "Alamat Lengkap ",
                            controller: lengkapController,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "List Daerah Tersedia",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: DropdownButton<OngkirModel>(
                                value: dropdownItems.isNotEmpty
                                    ? dropdownItems.firstWhere(
                                        (item) =>
                                            item.name == selectedDropdownValue,
                                        orElse: () => dropdownItems.first,
                                      )
                                    : null,
                                onChanged: (OngkirModel? newValue) {
                                  setState(() {
                                    selectedDropdownValue = newValue!.name;
                                  });
                                },
                                items: dropdownItems
                                    .map<DropdownMenuItem<OngkirModel>>(
                                  (OngkirModel value) {
                                    return DropdownMenuItem<OngkirModel>(
                                      value: value,
                                      child: Text(value.name),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
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
