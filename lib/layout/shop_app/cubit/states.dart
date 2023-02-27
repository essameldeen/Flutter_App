abstract class ShopHomeStates {}

class ShopHomeInitialState extends ShopHomeStates{}
class ShopHomeBottomNavChangeState extends ShopHomeStates{}

class ShopHomeLoadingState extends ShopHomeStates{}
class ShopHomeSuccessState extends ShopHomeStates{}
class ShopHomeErrorState extends ShopHomeStates{
  final String error;
  ShopHomeErrorState(this.error);
}