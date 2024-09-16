// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:starcell/providers/product_provider.dart';
import 'package:starcell/theme.dart';
import 'package:starcell/util/images.dart';
import 'package:starcell/views/screen/cart/dropdownwidget.dart';
import 'package:starcell/views/screen/cart/hasil_cekout.dart';
import 'package:starcell/widget/button_cus.dart';
import 'package:starcell/widget/custom_textfiled.dart';

class SelectAlamat extends StatefulWidget {
  const SelectAlamat({super.key});

  @override
  _SelectAlamatState createState() => _SelectAlamatState();
}

class _SelectAlamatState extends State<SelectAlamat> {
  late ProductProvider productProvider;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _selectedAddress;
  Map<String, dynamic>? _selectedAddressData;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  void _showAddressForm(
      {Map<String, dynamic>? existingAddress,
      DocumentReference? docRef}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AddressFormBottomSheet(existingAddress: existingAddress),
        );
      },
    );

    if (result != null) {
      if (docRef != null) {
        // Update the existing address in Firebase
        await docRef.update(result);
      } else {
        // Save the new address to Firebase with a timestamp
        await _firestore.collection('addresses').add({
          ...result,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    if (_selectedAddressData != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HasilCekout(addressData: _selectedAddressData!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Pesanan'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _showAddressForm(), icon: const Icon(Icons.add))
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
      body: _user == null
          ? const Center(child: Text('User not logged in'))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset(Images.cekout1),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: AddressList(
                    selectedAddress: _selectedAddress,
                    onSelect: (address, addressData) {
                      setState(() {
                        _selectedAddress = address;
                        _selectedAddressData = addressData;
                      });
                    },
                    onEdit: (existingAddress, docRef) => _showAddressForm(
                        existingAddress: existingAddress, docRef: docRef),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ButtonCus(
            textButton: "Pesan",
            onPressed: () => _navigateToNextScreen(context),
            buttomcolor: bg4color,
            textcolor: Colors.white),
      ),
    );
  }
}

class AddressFormBottomSheet extends StatefulWidget {
  final Map<String, dynamic>? existingAddress;

  const AddressFormBottomSheet({super.key, this.existingAddress});

  @override
  _AddressFormBottomSheetState createState() => _AddressFormBottomSheetState();
}

class _AddressFormBottomSheetState extends State<AddressFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedOngkir;
  List<String> _ongkirList = [];

  @override
  void initState() {
    super.initState();
    _loadOngkirData();

    if (widget.existingAddress != null) {
      _addressController.text = widget.existingAddress!['address'];
      _nameController.text = widget.existingAddress!['name'];
      _phoneController.text = widget.existingAddress!['phone'];
      _selectedOngkir = widget.existingAddress!['ongkir'];
    }
  }

  Future<void> _loadOngkirData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('ongkir').get();
    setState(() {
      _ongkirList = snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Alamat",
                style: primaryTextStyle.copyWith(
                    fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 20),
              CustomTextFil(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                hintText: 'Nama Lengkap',
              ),
              const SizedBox(height: 10),
              CustomTextFil(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Nomor Handphone'),
                keyboardType: TextInputType.phone,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Nomor Handphone';
                  }
                  return null;
                },
                hintText: 'Nomor Handphone',
              ),
              const SizedBox(height: 10),
              CustomDropdownButtonFormField(
                hintText: 'Provinsi',
                items: _ongkirList,
                value: _selectedOngkir,
                onChanged: (value) {
                  setState(() {
                    _selectedOngkir = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a Provinsi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextFil(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Alamat'),
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Alamat';
                  }
                  return null;
                },
                hintText: 'Alamat',
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop({
                          'address': _addressController.text,
                          'name': _nameController.text,
                          'phone': _phoneController.text,
                          'ongkir': _selectedOngkir,
                          'userId': user?.uid,
                        });
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressList extends StatelessWidget {
  final String? selectedAddress;
  final Function(String, Map<String, dynamic>) onSelect;
  final Function(Map<String, dynamic>, DocumentReference) onEdit;

  const AddressList({
    super.key,
    required this.selectedAddress,
    required this.onSelect,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Please log in to view addresses.'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('addresses')
          .where('userId', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No addresses found.'));
        }

        final addresses = snapshot.data!.docs;

        return ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            final addressData = addresses[index];
            final data = addressData.data() as Map<String, dynamic>;
            final address = data['address'];
            final name = data['name'];
            final phone = data['phone'];
            final ongkir = data['ongkir'];
            final docRef = addressData.reference;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: address,
                          groupValue: selectedAddress,
                          onChanged: (value) {
                            if (value != null) {
                              onSelect(value, data);
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Nama Lengkap: ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Nomer Hp: $phone',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Provinsi: $ongkir',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Alamat: $address',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: bg2Color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.edit, color: Colors.white),
                          label: const Text('Ubah',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () => onEdit(data, docRef),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.delete, color: Colors.white),
                          label: const Text('Hapus',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            await docRef.delete();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
