class OngkirModel {
  late final String name;
  late double? price;
  late String? id;

  OngkirModel({
    required this.name,
    this.price,
    this.id,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'id': id,
      };

  static OngkirModel fromJson(Object? json) {
    final Map<String, dynamic> data = json as Map<String, dynamic>;
    return OngkirModel(
      name: data['name'] ?? '',
      price:
          data['price'] != null ? double.parse(data['price'].toString()) : 0.0,
      id: data['id'] ?? '',
    );
  }
}
