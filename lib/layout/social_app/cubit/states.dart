abstract class SocialStates {}

class SocialInitalState extends SocialStates {}

class SocialGetUserDataLoadingState extends SocialStates {}

class SocialGetUserDataSuccessState extends SocialStates {}

class SocialSendEmailSuccessState extends SocialStates {}

class SocialGetUserDataErrorState extends SocialStates {
  final String? error;

  SocialGetUserDataErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialUploadState extends SocialStates {}

class SocialGetImageProfileSuccessState extends SocialStates {}

class SocialGetImageProfileErrorState extends SocialStates {}

class SocialGetImageCoverSuccessState extends SocialStates {}

class SocialGetImageCoverErrorState extends SocialStates {}

class SocialUploadImageProfileSuccessState extends SocialStates {}

class SocialUploadImageProfileErrorState extends SocialStates {}

class SocialUploadImageCoverSuccessState extends SocialStates {}

class SocialUploadImageCoverErrorState extends SocialStates {}
class SocialUserUpdateErrorState extends SocialStates {}
class SocialUserUpdateLoadingState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}
class SocialCreatePostSuccessState  extends SocialStates {}
class SocialCreatePostErrorState  extends SocialStates {}

class SocialGetImagePostSuccessState extends SocialStates {}

class SocialGetImagePostErrorState extends SocialStates {}
class SocialRemoveImagePostState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}
class SocialGetPostsSuccessState extends SocialStates {}
class SocialGetPostsErrorState extends SocialStates {}
