// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class SliderModel {
  String? description;
  int? id;
  String? imagePath;
  String? title;

  SliderModel({this.description, this.id, this.imagePath, this.title});

  SliderModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    imagePath = json['image_path'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['image_path'] = this.imagePath;
    data['title'] = this.title;
    return data;
  }
}
