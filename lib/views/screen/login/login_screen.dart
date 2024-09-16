// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:starcell/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:starcell/util/images.dart';

import 'package:starcell/views/screen/intro/intro_screen.dart';

import '../../../util/dimensions.dart';

import '../../../widget/custom_button.dart';

import '../../../widget/custom_textfiled.dart';
import '../../../widget/password_textfiled.dart';
import '../regis2/regis_screen2.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void validation() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      try {
        setState(() {
          isLoading = true;
        });

        // Memeriksa apakah email tersedia dalam koleksi "user"
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('user')
            .where('email', isEqualTo: email)
            .get();

        if (userSnapshot.size > 0) {
          // Email tersedia, lanjutkan proses login
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          print(userCredential.user!.uid);
          // Login berhasil, lanjutkan ke halaman berikutnya
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const IntroScreen(),
            ),
          );
        } else {
          // Email tidak ditemukan dalam koleksi "user"
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Email Tidak Terdaftar'),
              content: const Text('Email yang Anda masukkan Sudah DI Banned.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Password Salah'),
              content: const Text('Password Salah Coba lagi'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          // Other FirebaseAuthException occurred
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Password Gagal'),
              content: Text(e.message ?? 'An error occurred.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } on PlatformException catch (e) {
        setState(() {
          isLoading = false;
        });
        // Other PlatformException occurred
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.message ?? 'An error occurred.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      print("No");
    }
  }

  Widget _textHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          Images.logoo,
          width: 120.0,
          height: 120.0,
          fit: BoxFit.fill,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Masukan email Anda untuk Masuk",
              style: primaryTextStyle.copyWith(
                  fontSize: Dimensions.FONT_SIZE_OVER2_LARGE,
                  color: Colors.black87),
            ),
          ],
        ),
      ],
    );
  }

  Widget _allCustomTextfilled() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          CustomTextFil(
            keyboardType: TextInputType.emailAddress,
            hintText: "Email",
            labelText: "Email",
            validate: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return "Please enter a valid email address";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          PasswordTextField(
            hintText: "Password",
            labelText: "password",
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _customButtonLogin() {
    return CustomButton(
      onPressed: validation,
      textButton: 'Masuk',
    );
  }

  Widget _register() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Tidak Memiliki Akun ? ",
          style: primaryTextStyle2.copyWith(
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
              fontWeight: FontWeight.normal,
              color: Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisFullScreen(),
              ),
            );
          },
          child: Text(
            "Daftar",
            style: primaryTextStyle.copyWith(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1Color,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              _textHeader(),
              const SizedBox(
                height: 20,
              ),
              _allCustomTextfilled(),
              const SizedBox(
                height: 40,
              ),
              _customButtonLogin(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _register(),
          ),
        ],
      ),
    );
  }
}
