class Product {
  late final String id;
  late final String category;
  late final String name;
  late final double price;
  late final String image;
  late final String description;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category,
        'name': name,
        'price': price,
        'image': image,
        'description': description,
      };

  static Product fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] ?? '',
        category: json['category'] ?? '',
        name: json['name'] ?? '',
        price: json['price'] != null
            ? double.parse(json['price'].toString())
            : 0.0, // Jika nilainya null, berikan 0.0 sebagai nilai default ,
        image: json['image'] ?? '',
        description: json['description'] ?? '',
      );
}
