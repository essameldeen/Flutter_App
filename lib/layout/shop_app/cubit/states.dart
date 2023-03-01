import 'package:app_test/model/shop/login_model.dart';

abstract class ShopHomeStates {}

class ShopHomeInitialState extends ShopHomeStates {}

class ShopHomeBottomNavChangeState extends ShopHomeStates {}

class ShopHomeLoadingState extends ShopHomeStates {}

class ShopHomeSuccessState extends ShopHomeStates {}

class ShopHomeErrorState extends ShopHomeStates {
  final String error;

  ShopHomeErrorState(this.error);
}

class ShopHomeCategorySuccessState extends ShopHomeStates {}

class ShopHomeCategoryErrorState extends ShopHomeStates {
  final String error;

  ShopHomeCategoryErrorState(this.error);
}

class ShopHomeFavouriteChangeState extends ShopHomeStates {}

class ShopHomeFavouriteChangeSuccessState extends ShopHomeStates {
  bool? status;

  ShopHomeFavouriteChangeSuccessState(this.status);
}

class ShopHomeFavouriteChangeErrorState extends ShopHomeStates {
  final String name;

  ShopHomeFavouriteChangeErrorState(this.name);
}

class ShopHomeGetFavouriteLoadingState extends ShopHomeStates {}

class ShopHomeGetFavouriteSuccessState extends ShopHomeStates {}

class ShopHomeGetFavouriteErrorState extends ShopHomeStates {
  String? error;

  ShopHomeGetFavouriteErrorState(this.error);
}

class ShopHomeGetUserDataLoadingState extends ShopHomeStates {}

class ShopHomeGetUserDataSuccessState extends ShopHomeStates {
  final ShopLoginModel? loginModel;

  ShopHomeGetUserDataSuccessState(this.loginModel);
}

class ShopHomeGetUserDataErrorState extends ShopHomeStates {
  String? error;

  ShopHomeGetUserDataErrorState(this.error);
}

class ShopHomeLogOutSuccessState extends ShopHomeStates {}

class ShopHomeLogOutErrorState extends ShopHomeStates {
  final String? error;

  ShopHomeLogOutErrorState(this.error);
}
