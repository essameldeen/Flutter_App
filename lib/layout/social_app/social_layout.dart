import 'package:app_test/layout/social_app/cubit/cubit.dart';
import 'package:app_test/layout/social_app/cubit/states.dart';
import 'package:app_test/modules/social_app/new_post/new_post_screen.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:app_test/shared/styles/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialUploadState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(IconBroken.Notification)),
              IconButton(onPressed: () {}, icon: const Icon(IconBroken.Search)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: ""),
              BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: ""),
              BottomNavigationBarItem(icon: Icon(IconBroken.Upload), label: ""),
              BottomNavigationBarItem(icon: Icon(IconBroken.Location), label: ""),
              BottomNavigationBarItem(icon: Icon(IconBroken.Setting), label: ""),

            ],
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).userModel != null,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) {
              return cubit.screen[cubit.currentIndex];
            },
          ),
        );
      },
    );
  }

  void sendVerificationEmail() {
    FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value) {
      showToast("Please Check your Email", ToastStates.SUCCESS);
    }).catchError((error) {
      showToast(error.toString(), ToastStates.ERROR);
    });
  }
}
