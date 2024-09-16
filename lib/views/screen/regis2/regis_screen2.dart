// ignore_for_file: avoid_print, use_build_context_synchronously, duplicate_ignore

import 'package:starcell/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:starcell/util/images.dart';

import 'package:starcell/views/screen/intro/intro_screen.dart';

import '../../../models/ongkir_model.dart';

import '../../../util/dimensions.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfiled.dart';
import '../../../widget/password_textfiled.dart';

class RegisFullScreen extends StatefulWidget {
  const RegisFullScreen({super.key});

  @override
  State<RegisFullScreen> createState() => _RegisFullScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class _RegisFullScreenState extends State<RegisFullScreen> {
  late String email;
  late String name;
  late String phone;
  late String password;

  late String lengkap;
  bool? isChecked = false;
  bool? isLoading = false;
  late OngkirModel selectedOption;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('ongkir').get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          selectedOption = OngkirModel.fromJson(snapshot.docs.first.data());
        });
      }
    });
  }

  void validation() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        // ignore: unused_local_variable
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        await firestore.collection('user').add({
          "name": name,
          "email": email,
          "phone": phone,
          "userid": userCredential.user!.uid,
          "lengkap": lengkap,
        });
        print(userCredential.user!.uid);
        // Login berhasil, lanjutkan ke halaman berikutnya
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const IntroScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e.code == 'email-already-in-use') {
          // Email address is already in use
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'The email address is already in use by another account.'),
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
              "Masukan Data Anda untuk Daftar",
              style: primaryTextStyle.copyWith(
                  fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                  color: Colors.black87),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAllTextFromFiled() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFil(
                hintText: "Nama",
                labelText: "Nama",
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama is required';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFil(
                keyboardType: TextInputType.emailAddress,
                hintText: "Email",
                labelText: "Gmail",
                validate: (value) {
                  // Check if this field is empty
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }

                  // using regular expression
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "Please enter a valid email address";
                  }

                  // the email is valid
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFil(
                keyboardType: TextInputType.number,
                hintText: "Nomor Handphone",
                labelText: "Nomor Handphone",
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomer is required';
                  } else if (value.length < 11) {
                    return 'Nomer Terlalu Pendek';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFil(
                hintText: "Masukan Alamat Lengkap",
                labelText: "Alamat",
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat is required';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    lengkap = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          // FutureBuilder<QuerySnapshot>(
          //   future: FirebaseFirestore.instance.collection('ongkir').get(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasError) {
          //       return const Text('Something went wrong');
          //     }

          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const CircularProgressIndicator();
          //     }

          //     List<OngkirModel> ongkirList = snapshot.data!.docs
          //         .map((doc) => OngkirModel.fromJson(doc.data()))
          //         .toList();

          //     return _buildDropdownButton(
          //         ongkirList); // Update the _buildDropdownButton call
          //   },
          // ),
          const SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PasswordTextField(
                hintText: "Password",
                labelText: "Password",
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buttonCustom() {
    return CustomButton(
      onPressed: validation,
      textButton: 'Buat Akun',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1Color,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: bg2Color,
            size: 24.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textHeader(),
              const SizedBox(
                height: 20,
              ),
              _buildAllTextFromFiled(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buttonCustom(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
