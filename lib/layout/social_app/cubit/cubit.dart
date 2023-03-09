import 'dart:io';

import 'package:app_test/layout/social_app/cubit/states.dart';
import 'package:app_test/model/social/SocialUserModel.dart';
import 'package:app_test/model/social/message_model.dart';
import 'package:app_test/model/social/post_model.dart';
import 'package:app_test/modules/social_app/chats/chats_screen.dart';
import 'package:app_test/modules/social_app/feeds/feeds_screen.dart';
import 'package:app_test/modules/social_app/new_post/new_post_screen.dart';
import 'package:app_test/modules/social_app/users/user_screen.dart';
import 'package:app_test/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../modules/social_app/settings/setting_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitalState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  int currentIndex = 0;

  List<Widget> screen = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingScreen()
  ];
  List<String> titles = ["Home", "Chats", "Posts", "Users", "Settings"];

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
      print(error?.toString());
      emit(SocialGetUserDataErrorState(error.toString()));
    });
  }

  void changeBottomNav(int newIndex) {
    if (newIndex == 1) {
      getAllUsers();
    }
    if (newIndex == 2) {
      emit(SocialUploadState());
    } else {
      currentIndex = newIndex;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;

  var imagePicker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialGetImageProfileSuccessState());
    } else {
      print("No Image Selected");
      emit(SocialGetImageProfileErrorState());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialGetImageCoverSuccessState());
    } else {
      print("No Image Selected");
      emit(SocialGetImageCoverErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profileImage?.path ?? "").pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialUploadImageProfileErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadImageProfileErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage?.path ?? "").pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadImageProfileErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadImageProfileErrorState());
    });
  }

  void updateUserData(
      {required String name,
      required String phone,
      required String bio,
      String? cover,
      String? image}) {
    SocialUserModel user = SocialUserModel(
      uId: userModel?.uId,
      email: userModel?.email,
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? userModel?.image,
      cover: cover ?? userModel?.cover,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(token)
        .update(user.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future getPostImage() async {
    final pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialGetImagePostSuccessState());
    } else {
      print("No Image Selected");
      emit(SocialGetImagePostErrorState());
    }
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage?.path ?? "").pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(text: text, dateTime: dateTime, postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemoveImagePostState());
  }

  void createPost(
      {required String text, required String dateTime, String? postImage}) {
    PostModel user = PostModel(
      uId: userModel?.uId,
      name: userModel?.name,
      text: text,
      image: userModel?.image,
      dateTime: dateTime,
      postImage: postImage ?? "",
    );
    emit(SocialCreatePostLoadingState());
    FirebaseFirestore.instance
        .collection("posts")
        .add(user.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      for (var element in value.docs) {
        element.reference.collection("likes").get().then((valueLikes) {
          element.reference.collection("comments").get().then((valueComment) {
            posts.add(PostModel.fromJson(element.data()));
            postsId.add(element.id);
            likes.add(valueLikes.docs.length);
            comments.add(valueComment.docs.length);
          }).catchError((error) {
            emit(SocialGetPostsErrorState());
          });
        }).catchError((error) {
          emit(SocialGetPostsErrorState());
        });
      }
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(userModel?.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState());
    });
  }

  void commentPost(String postId, String comment) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .doc(userModel?.uId)
        .set({'comment': comment}).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState());
    });
  }

  List<SocialUserModel> users = [];

  void getAllUsers() {
    users = [];
    emit(SocialGetAllUserDataLoadingState());

    FirebaseFirestore.instance.collection("users").get().then((value) {
      for (var element in value.docs) {
        if (element.data()["uId"] != userModel?.uId) {
          users.add(SocialUserModel.fromJson(element.data()));
        }
      }

      emit(SocialGetAllUserDataSuccessState());
    }).catchError((error) {
      emit(SocialGetAllUserDataErrorState(error.toString()));
    });
  }

  void sendMessage({
    required String text,
    required String dateTime,
    required String receiverId,
  }) {
    MessageModel message = MessageModel(
        senderId: userModel?.uId,
        receiverId: receiverId,
        text: text,
        dateTime: dateTime);
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel?.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .add(message.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("chats")
        .doc(userModel?.uId)
        .collection("messages")
        .add(message.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }
}
