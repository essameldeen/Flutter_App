abstract class SocialStates {}

class SocialInitalState extends SocialStates {}

class SocialGetUserDataLoadingState extends SocialStates {}
class SocialGetUserDataSuccessState extends SocialStates {}
class SocialSendEmailSuccessState extends SocialStates {}

class SocialGetUserDataErrorState extends SocialStates {
  final String? error;

  SocialGetUserDataErrorState(this.error);
}
