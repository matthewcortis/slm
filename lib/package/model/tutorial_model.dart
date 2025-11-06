import '../news/model/card_item_model.dart';
class TutorialModel implements CardItemModel{
  final int id;
  final String title;
  final String tag;
  final String image;
  final String time;
  

  TutorialModel({
    required this.id,
    required this.tag,
    required this.title,
    required this.time,
    required this.image,
  });

  factory TutorialModel.fromJson(Map<String, dynamic> json) {
    return TutorialModel(
      id: json['id'] ?? 0,
      tag: json['tag'] ?? '',
      title: json['title'] ?? '',
      time: json['time'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tag': tag,
      'title': title,
      'time': time,
      'image': image,
    };
  }
}
