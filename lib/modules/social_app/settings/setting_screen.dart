import 'package:app_test/layout/social_app/cubit/cubit.dart';
import 'package:app_test/layout/social_app/cubit/states.dart';
import 'package:app_test/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:app_test/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 190.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child:  Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration:  BoxDecoration(
                            borderRadius:const  BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(userModel?.cover??""),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child:  CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                          userModel?.image ??""
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                userModel?.name ??"",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                userModel?.bio ??"",
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              "posts",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "245",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              "photos",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "12k",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              "Following",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "10K",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              "followers",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                        onPressed:(){} ,
                        child: const Text("Add Photos"),
                      )),
                  const SizedBox(width: 10,),
                  OutlinedButton(
                    onPressed:(){
                      navigateTo(context, EditProfileScreen());
                    } ,
                    child: const Icon(IconBroken.Edit,size: 16,),
                  )

                ],
              )
            ],
          ),
        );
      },
    );
  }
}
