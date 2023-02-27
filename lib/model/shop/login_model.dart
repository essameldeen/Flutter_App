class ShopLoginModel {
  bool? status;
  String? message;
  Data? data;

  ShopLoginModel(this.status, this.message, this.data);

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  int? points;
  int? credit;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  // Named Constructor

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
