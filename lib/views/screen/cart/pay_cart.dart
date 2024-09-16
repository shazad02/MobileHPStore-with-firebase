// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:starcell/theme.dart';
import 'package:starcell/views/screen/cart/detail_pay.dart';

class PayCard extends StatelessWidget {
  final String image;
  final String nama;
  final String nomor;
  final String penerima;
  final String orderId;
  final String kodeOrder;
  final String userId;
  final String lengkapUser;
  final String total;
  final VoidCallback? onAdd;
  final String username;
  final String address;

  const PayCard({
    super.key,
    required this.image,
    required this.nama,
    this.onAdd,
    required this.nomor,
    required this.penerima,
    required this.orderId,
    required this.kodeOrder,
    required this.userId,
    required this.lengkapUser,
    required this.total,
    required this.username,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => DetailPay(
              nomor: nomor,
              image: image,
              name: nama,
              penerima: penerima,
              orderId: orderId,
              kodeOrder: kodeOrder,
              userId: userId,
              lengkapUser: lengkapUser,
              total: total,
              username: username,
              address: address,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // CircleAvatar(
            //   radius: 30,
            //   backgroundImage: NetworkImage(image),
            // ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: primaryTextStyle2.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Text(
                    nomor,
                    style: primaryTextStyle2.copyWith(
                        color: Colors.black54, fontSize: 14),
                  ),
                  Text(
                    'Penerima: $penerima',
                    style: primaryTextStyle2.copyWith(
                        color: Colors.black54, fontSize: 14),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
