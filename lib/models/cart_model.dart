class CartModel {
  late final String image;
  late final String name;
  late final double price;
  late final int quenty;
  late final String category;

  CartModel({
    required this.image,
    required this.name,
    required this.price,
    required this.quenty,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'image': image,
        'name': name,
        'price': price,
        'quenty': quenty,
        'category': category,
      };

  static CartModel fromJson(Map<String, dynamic> json) => CartModel(
        image: json['image'] ?? '',
        name: json['name'] ?? '',
        price: json['price'] != null
            ? double.parse(json['price'].toString())
            : 0.0, // Jika nilainya null, berikan 0.0 sebagai nilai default ,
        quenty: json['quenty'] ?? '',
        category: json['category'] ?? '',
      );
}
