// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:starcell/providers/product_provider.dart';
import 'package:starcell/theme.dart';
import 'package:starcell/util/images.dart';
import 'package:starcell/views/screen/cart/data.dart';
import 'package:starcell/views/screen/cart/pilih.dart';

class DetailPay extends StatefulWidget {
  final String image;
  final String name;
  final String penerima;
  final String orderId;
  final String nomor;
  final String kodeOrder;
  final String userId;
  final String lengkapUser;
  final String total;
  final String username;
  final String address;

  const DetailPay({
    super.key,
    required this.image,
    required this.name,
    required this.penerima,
    required this.orderId,
    required this.kodeOrder,
    required this.userId,
    required this.nomor,
    required this.lengkapUser,
    required this.total,
    required this.username,
    required this.address,
  });

  @override
  State<DetailPay> createState() => _DetailPayState();
}

class _DetailPayState extends State<DetailPay> {
  int count = 1;
  String userName = '';
  late ProductProvider productProvider;
  Uint8List? _image;
  bool _uploading = false;

  Future<Uint8List?> pickImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      Uint8List? bytes = await file.readAsBytes();
      return bytes;
    }
    return null;
  }

  Future<Uint8List?> pickImageFromCamera() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file != null) {
      Uint8List? bytes = await file.readAsBytes();
      return bytes;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> saveData() async {
    setState(() {
      _uploading = true;
    });

    if (_image != null) {
      try {
        String resp = await StoreData().saveData(
          kodeOrder: widget.kodeOrder,
          file: _image!,
          name: widget.name,
          orderId: widget.orderId,
          userId: widget.userId,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resp)),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload image')),
        );
      } finally {
        setState(() {
          _uploading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak Ada Gambar Yang Dipilih')),
      );
    }
  }

  Future<void> selectImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Gambar"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List? img = await pickImageFromGallery();
                    setState(() {
                      _image = img;
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Kamera"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List? img = await pickImageFromCamera();
                    setState(() {
                      _image = img;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Upload Pembayaran',
          style: primaryTextStyle2.copyWith(color: Colors.black),
        ),
        backgroundColor: bg1Color,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => PayScreen(
                    address: widget.address,
                    kodeOrder: widget.kodeOrder,
                    userId: widget.userId,
                    lengkapUser: widget.lengkapUser,
                    total: widget.total,
                    username: widget.username,
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 24.0,
              color: bg2Color,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(child: Image.asset(Images.cekout2)),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: selectImage,
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      image: _image != null
                          ? DecorationImage(
                              image: MemoryImage(_image!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _image == null
                        ? Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Banking', widget.name),
              const SizedBox(height: 20),
              _buildDetailRow('Account Number', widget.nomor),
              const SizedBox(height: 20),
              _buildDetailRow('Recipient', widget.penerima),
              const SizedBox(height: 20),
              _buildDetailRow('Order ID', widget.orderId),
              const SizedBox(height: 20),
              _buildDetailRow('Total Payment', 'Rp ${widget.total}'),
              const SizedBox(height: 20),
              _buildDetailRow('User', widget.username),
              const SizedBox(height: 20),
              _buildDetailRow('Address', widget.address),
              ElevatedButton.icon(
                onPressed: (_uploading || _image == null)
                    ? null
                    : () async {
                        await saveData();
                        if (!_uploading) {
                          Navigator.pushNamed(context, '/selesai');
                        }
                      },
                icon: _uploading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Icon(Icons.upload),
                label: const Text("Upload"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: primaryTextStyle.copyWith(
              fontSize: 15,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: primaryTextStyle.copyWith(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
