import 'package:app_test/layout/social_app/cubit/states.dart';
import 'package:app_test/model/social/SocialUserModel.dart';
import 'package:app_test/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitalState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserDataLoadingState());

    FirebaseFirestore.instance
        .collection("users")
        .doc(token)
        .get()
        .then((value) {
        emit(SocialGetUserDataSuccessState());
      userModel = SocialUserModel.fromJson(value.data());
        print(userModel.toString());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserDataErrorState(error.toString()));
    });
  }
}
