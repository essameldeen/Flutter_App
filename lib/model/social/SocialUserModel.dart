class SocialUserModel {
  String? name;
  String? phone;
  String? uId;
  String? email;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  SocialUserModel(
      {required this.name,
      required this.uId,
      required this.email,
      required this.phone,
      required this.image,
      required this.cover,
      required this.bio,
      isEmailVerified = false});

  SocialUserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    name = json['name'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'uId': uId,
      'email': email,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified
    };
  }
}
