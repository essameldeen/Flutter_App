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
