import 'package:app_test/model/shop/login_model.dart';

abstract class  SocialLoginStates {}


class SocialLoginInitialState extends SocialLoginStates{}
class SocialLoginLoadingState extends SocialLoginStates{}
class SocialLoginSuccessState extends SocialLoginStates{
  String? uId;
  SocialLoginSuccessState(this.uId);
}
class SocialLoginErrorState extends SocialLoginStates{
  final String error;
  SocialLoginErrorState(this.error);
}

class SocialLoginPasswordIconState extends SocialLoginStates{}
