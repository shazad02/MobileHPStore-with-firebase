// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starcell/views/screen/cart/pilih.dart';

import '../theme.dart';

class CekoCar extends StatelessWidget {
  final String userName;
  final double totalPrice;
  final String kodeOrder;
  final String UserUid;
  final String lengkapUser;
  final String status;
  final DateTime time;

  const CekoCar({
    super.key,
    required this.userName,
    required this.totalPrice,
    required this.kodeOrder,
    required this.UserUid,
    required this.lengkapUser,
    required this.status,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => PayScreen(
              kodeOrder: kodeOrder,
              userId: UserUid,
              lengkapUser: lengkapUser,
              total: totalPrice.toStringAsFixed(0),
              username: userName,
              address: lengkapUser,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy HH:mm').format(time),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: status == 'Completed'
                          ? Colors.green.withOpacity(0.1)
                          : bg2Color,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      status,
                      style: primaryTextStyle2.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            status == 'Completed' ? Colors.green : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nama Pemesan: $userName',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: bg2Color,
                    ),
                  ),
                  const Icon(
                    Icons.person_outline,
                    color: bg2Color,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Harga: Rp.${totalPrice.toInt().toString()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: bg2Color,
                    ),
                  ),
                  const Icon(
                    Icons.attach_money_outlined,
                    color: bg2Color,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Alamat: $lengkapUser',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: bg2Color,
                    ),
                  ),
                  const Icon(
                    Icons.location_on_outlined,
                    color: bg2Color,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
