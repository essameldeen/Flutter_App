class SocialUserModel {
  String? name;
  String? phone;
  String? uId;
  String? email;

  SocialUserModel({required this.name,
    required this.uId,
    required this.email,
    required this.phone});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    name = json['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'uId': uId,
      'email': email
    } ;
  }
}
