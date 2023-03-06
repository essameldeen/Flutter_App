import 'package:app_test/layout/social_app/cubit/states.dart';
import 'package:app_test/model/social/SocialUserModel.dart';
import 'package:app_test/modules/social_app/chats/chats_screen.dart';
import 'package:app_test/modules/social_app/feeds/feeds_screen.dart';
import 'package:app_test/modules/social_app/new_post/new_post_screen.dart';
import 'package:app_test/modules/social_app/users/user_screen.dart';
import 'package:app_test/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/social_app/settings/setting_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitalState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  int currentIndex = 0;

  List<Widget> screen = [FeedsScreen(), ChatsScreen(),
    NewPostScreen(),
    UsersScreen(), SettingScreen()];
  List<String> titles = ["Home", "Chats","Posts","Users", "Settings"];

  void getUserData() {
    emit(SocialGetUserDataLoadingState());

    FirebaseFirestore.instance
        .collection("users")
        .doc(token)
        .get()
        .then((value) {
      emit(SocialGetUserDataSuccessState());
      userModel = SocialUserModel.fromJson(value.data());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserDataErrorState(error.toString()));
    });
  }

  void changeBottomNav(int newIndex) {

    if(newIndex==2){
      emit(SocialUploadState());
    }
    else{
      currentIndex = newIndex;
      emit(SocialChangeBottomNavState());
    }

  }
}
