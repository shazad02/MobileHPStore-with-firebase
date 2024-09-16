// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starcell/views/screen/profile/alamat.dart';

import '../../../providers/product_provider.dart';
import '../../../theme.dart';
import '../dashboard/components/appbar_dashboard.dart';
import '../produk/licek.dart';
import '../produk/listcek.dart';
import '../splash/splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _logout() async {
    await _auth.signOut();

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScrren(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    Widget profile() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<void>(
            future: productProvider.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while fetching data
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Handle error case
                return Text('Error: ${snapshot.error}');
              } else {
                // Access the name property from userModelList
                final userModel = productProvider.userModelList.first;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, ${userModel.name}",
                          style: primaryTextStyle2.copyWith(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 100,
                        ),
                        Text(
                          "Welcome back",
                          style: primaryTextStyle2.copyWith(
                              color: Colors.grey, fontSize: 18),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 100,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/edit');
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 28.0,
                        child: Icon(
                          Icons.edit,
                          color: bg2Color,
                          size: 28.0,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      );
    }

    Widget profilEdit() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          profile(),
        ],
      );
    }

    Widget btnLogout() {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg1Color,
          side: const BorderSide(
            color: bg2Color,
          ),
          elevation: 10,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          _logout;
        },
        child: const Text(
          'Log Out',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      );
    }

    Widget allItem() {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: bg1Color,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  profilEdit(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => const Alamataja(),
                              ),
                            );
                          },
                          title: Text(
                            "Tambah Alamat",
                            style: primaryTextStyle.copyWith(
                                fontSize: 20, color: Colors.black87),
                          ),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 25),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => const Licek(
                                  isEqualTo: 'belum bayar',
                                  namescreen: 'Belum Upload Bukti',
                                ),
                              ),
                            );
                          },
                          title: Text(
                            "Belum Bayar",
                            style: primaryTextStyle.copyWith(
                                fontSize: 20, color: Colors.black87),
                          ),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 25),
                        ),
                      ),
                      _buildItem("Tunggu Konfirmasi", Icons.upload, 'Tunggu',
                          'Tunggu Konfirmasi'),
                      _buildItem("Dalam Perjalanan", Icons.check_outlined,
                          'Dalam Perjalanan', 'Dalam Perjalanan'),
                      _buildItem("Selesai", Icons.check, 'Selesai', 'Selesai'),
                      _buildItem("Ditolak", Icons.close, 'Ditolak', 'Ditolak'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const AppbarDash(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _logout,
                  child: const Icon(
                    Icons.logout,
                    size: 24.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              allItem(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
      String title, IconData icon, String isEqualTo, String namescreen) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListCek(
                isEqualTo: isEqualTo,
                namescreen: namescreen,
              ),
            ),
          );
        },
        title: Text(
          title,
          style: primaryTextStyle.copyWith(fontSize: 20, color: Colors.black87),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 25),
      ),
    );
  }
}
