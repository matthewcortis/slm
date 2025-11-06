class ProductHotModel {
  final int id;
  final String name;
  final String price;
  final String type;
  final String saving;
  final String image;

  ProductHotModel({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.saving,
    required this.image,
  });

  factory ProductHotModel.fromJson(Map<String, dynamic> json) {
    return ProductHotModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      type: json['type'] ?? '',
      saving: json['saving'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'type': type,
        'saving': saving,
        'image': image,
      };
}
