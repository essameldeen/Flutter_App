import 'package:app_test/model/shop/login_model.dart';
import 'package:app_test/modules/social_app/social_login/cubit/social_login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void login({required String email, required String password}) {
    emit(SocialLoginLoadingState());
   FirebaseAuth.instance.
   signInWithEmailAndPassword(email: email, password: password).then((value){
     emit(SocialLoginSuccessState());

     print(value.user?.email);
     print(value.user?.uid);
   }).catchError((error) {
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_rounded
        : Icons.visibility_off_outlined;
    emit(SocialLoginPasswordIconState());
  }
}
