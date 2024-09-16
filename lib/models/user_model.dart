class UserModel {
  late final String email;
  late final String name;
  late final String phone;
  late String? userid;
  late String? ongkir;
  late final String alamat;
  late final String lengkap;

  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    this.ongkir,
    this.userid,
    required this.alamat,
    required this.lengkap,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'phone': phone,
        'userid': userid,
        'alamat': alamat,
        'lengkap': lengkap,
        'ongkir': ongkir,
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'] ?? '',
        name: json['name'] ?? '',
        phone: json['phone'] ?? '',
        userid: json['userid'] ?? '',
        alamat: json['alamat'] ?? '',
        lengkap: json['lengkap'] ?? '',
        ongkir: json['ongkir'] ?? '',
      );
}
