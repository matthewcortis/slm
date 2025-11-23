class ProductDeviceModel {
  final int id;               // ID vật tư (để xem chi tiết)
  final String image;  
  final String groupCode;       // URL hoặc asset hình ảnh thiết bị
  final String title;         // Tên thiết bị
  final String quantityTag;   // Ví dụ: "x 18 cái"
  final String warranty;      // Ví dụ: "Bảo hành 12 năm"
  final String price;         // Ví dụ: "1.200.000 đ"
  final String power;         // Ví dụ: "600Wp"
  final String technology;    // Ví dụ: "Mono PERC"

  ProductDeviceModel({
    required this.id,
    required this.groupCode,
    required this.image,
    required this.title,
    required this.quantityTag,
    required this.warranty,
    required this.price,
    required this.power,
    required this.technology,
  });
}
