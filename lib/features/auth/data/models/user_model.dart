class UserModel {
  String? email;
  int? id;
  String? imagePath;
  String? username;
  String? phone;

  UserModel({this.id, this.imagePath, this.username, this.email, this.phone});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['image_path'];
    username = json['name'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_path": imagePath,
    "name": username,
    "email": email,
    "phone": phone,
  };
}
