class SocialUserModel {
  String? name;
  String? phone;
  String? uId;
  String? email;
  String? image;
  String? bio;
  bool? isEmailVerified;

  SocialUserModel(
      {required this.name,
      required this.uId,
      required this.email,
      required this.phone,
      required this.image,
      required this.bio,
      isEmailVerified = false});

  SocialUserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
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
      'bio': bio,
      'isEmailVerified': isEmailVerified
    };
  }
}
