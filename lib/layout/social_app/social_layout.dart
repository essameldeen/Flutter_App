import 'package:app_test/layout/social_app/cubit/cubit.dart';
import 'package:app_test/layout/social_app/cubit/states.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text("Social Feeds"),
        ),
        body: ConditionalBuilder(
          condition: SocialCubit.get(context).userModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) {
            var model = SocialCubit.get(context).userModel;
            return Column(
              children: [
                if (FirebaseAuth.instance.currentUser?.emailVerified == false)
                  Container(
                    color: Colors.amber.withOpacity(.7),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline),
                          const SizedBox(
                            width: 5.0,
                          ),
                          const Expanded(
                              child: Text(
                            "Send Email Verfication",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )),
                          const SizedBox(
                            width: 20,
                          ),
                          defaultTextButton(
                              onPressed: () {
                                print (model?.email);
                                sendVerificationEmail();
                              },
                              title: 'send')
                        ],
                      ),
                    ),
                  )
              ],
            );
          },
        ),
      ),
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
