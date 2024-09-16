class PayModel {
  late final String id;
  late final String payid;
  late final String image;
  late final String nama;
  late final String nomor;
  late final String penerima;

  PayModel({
    required this.id,
    required this.image,
    required this.payid,
    required this.nama,
    required this.nomor,
    required this.penerima,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'nama': nama,
        'nomor': nomor,
        'penerima': penerima,
        'payid': payid,
      };

  static PayModel fromJson(Map<String, dynamic> json) => PayModel(
        id: json['id'] ?? '',
        image: json['image'] ?? '',
        nama: json['nama'] ?? '',
        nomor: json['nomor'] ?? '',
        penerima: json['penerima'] ?? '',
        payid: json['payid'] ?? '',
      );
}
