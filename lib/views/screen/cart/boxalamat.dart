import 'package:flutter/material.dart';

class AddressTile extends StatelessWidget {
  final String name;
  final String ongkir;
  final String address;
  final String phone;
  final String selectedAddress;
  final Function(String, dynamic) onSelect;
  final Function(dynamic, dynamic) onEdit;
  final dynamic data;
  final dynamic docRef;

  const AddressTile({
    required this.name,
    required this.ongkir,
    required this.address,
    required this.phone,
    required this.selectedAddress,
    required this.onSelect,
    required this.onEdit,
    required this.data,
    required this.docRef,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Lengkap: $name',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
                  ],
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Nomer Hp: $phone',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              leading: Radio<String>(
                value: address,
                groupValue: selectedAddress,
                onChanged: (value) {
                  if (value != null) {
                    onSelect(value, data);
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => onEdit(data, docRef),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await docRef.delete();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
