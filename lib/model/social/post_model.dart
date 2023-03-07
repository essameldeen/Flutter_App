class PostModel {
  String? name;
  String? uId;
  String? image;
  String? text;
  String? postImage;
  String? dateTime;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.text,
    required this.postImage,
    required this.dateTime,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    uId = json!['uId'];
    image = json['image'];
    name = json['name'];
    text = json['text'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'text': text,
      'postImage': postImage,
      'dateTime': dateTime,
    };
  }
}
