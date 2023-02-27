class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel>? banners = [];
  List<ProductModel>? products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners?.add(BannerModel.fromJson(element['banners']));
    });

    json['products'].forEach((element) {
      products?.add(ProductModel.fromJson(element['products']));
    });
  }
}

class BannerModel {
  int? id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic discount;
  dynamic price;
  dynamic oldPrice;
  String? name;
  String? image;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discount = json['discount'];
    price = json['price'];
    oldPrice  = json['old_price'];
    name = json['name'];
    image = json['image'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
