import 'package:app_test/model/shop/login_model.dart';
import 'package:app_test/model/social/SocialUserModel.dart';
import 'package:app_test/modules/social_app/social_register/cubit/shope_register_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void register(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(email: email, uuid: value.user?.uid, name: name, phone: phone);
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String email,
    required String? uuid,
    required String name,
    required String phone,
  }) {
    SocialUserModel user = SocialUserModel(
        name: name,
        uId: uuid,
        email: email,
        phone: phone,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uuid)
        .set(user.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_rounded
        : Icons.visibility_off_outlined;
    emit(SocialRegisterPasswordIconState());
  }
}
