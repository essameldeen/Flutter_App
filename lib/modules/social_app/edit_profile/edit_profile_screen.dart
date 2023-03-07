import 'package:app_test/layout/social_app/cubit/cubit.dart';
import 'package:app_test/layout/social_app/cubit/states.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:app_test/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel?.name ?? "";
        bioController.text = userModel?.bio ?? "";
        phoneController.text = userModel?.phone ?? "";
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: "Edit Profile", actions: [
            defaultTextButton(
                title: "Update",
                onPressed: () {
                  SocialCubit.get(context).updateUserData(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                }),
            const SizedBox(
              width: 15,
            )
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  SizedBox(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: coverImage != null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(coverImage),
                                          )
                                        : DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                userModel?.cover ?? ""),
                                          )),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                      child: Icon(
                                    IconBroken.Camera,
                                    size: 16,
                                  )))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: profileImage != null
                                  ? CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage: FileImage(profileImage!))
                                  : CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage:
                                          NetworkImage(userModel?.image ?? "")),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const CircleAvatar(
                                    child: Icon(
                                  IconBroken.Camera,
                                  size: 16,
                                )))
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                    title: "upload Profile",
                                    function: () {
                                      SocialCubit.get(context)
                                          .uploadProfileImage(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              bio: bioController.text);
                                    }),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 8,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                    title: "upload Cover",
                                    function: () {
                                      SocialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    }),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    const SizedBox(
                      height: 20,
                    ),
                  defaultFormField(
                      controller: nameController,
                      hint: "Enter your Name",
                      label: "Name",
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "Please Enter your name";
                        }
                        return null;
                      },
                      prefixIcon: IconBroken.User,
                      textInputType: TextInputType.name),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      hint: "Enter your phone]",
                      label: "Phone",
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "Please Enter your Phone";
                        }
                        return null;
                      },
                      prefixIcon: IconBroken.Call,
                      textInputType: TextInputType.phone),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: bioController,
                      hint: "Enter your Bio",
                      label: "Bio",
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "Please Enter your Bio";
                        }
                        return null;
                      },
                      prefixIcon: IconBroken.Info_Circle,
                      textInputType: TextInputType.text)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
