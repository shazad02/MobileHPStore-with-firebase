// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme.dart';

class CekCard extends StatelessWidget {
  final String userName;
  final double totalPrice;
  final String kodeOrder;
  final String UserUid;
  final String lengkapUser;
  final String status;
  final DateTime time;
  final String pengiriman;

  const CekCard({
    super.key,
    required this.userName,
    required this.totalPrice,
    required this.kodeOrder,
    required this.UserUid,
    required this.lengkapUser,
    required this.status,
    required this.time,
    required this.pengiriman,
  });

  @override
  Widget build(BuildContext context) {
    String shortenedOrderId = kodeOrder.substring(kodeOrder.length - 5);

    return InkWell(
      onTap: () {},
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
                    color: status == 'Selesai' ? Colors.green : Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                  Icon(
                    Icons.check_circle_outline,
                    color: status == 'Selesai' ? Colors.green : Colors.grey,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nama Pemesan: $userName",
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
                    "Total Harga: Rp.${totalPrice.toInt().toString()}",
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
                    "Alamat: $lengkapUser",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pengiriman: $pengiriman",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: bg2Color,
                    ),
                  ),
                  const Icon(
                    Icons.person,
                    color: bg2Color,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Resi: $pengiriman$shortenedOrderId",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: bg2Color,
                    ),
                  ),
                  const Icon(
                    Icons.copy,
                    color: bg2Color,
                    size: 24,
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
