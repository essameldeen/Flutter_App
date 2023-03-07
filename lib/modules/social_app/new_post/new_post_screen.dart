import 'package:app_test/layout/social_app/cubit/cubit.dart';
import 'package:app_test/layout/social_app/cubit/states.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:app_test/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      if (state is SocialCreatePostSuccessState) {
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      var userModel = SocialCubit.get(context).userModel;
      return Scaffold(
        appBar: defaultAppBar(context: context, title: "Create Post", actions: [
          defaultTextButton(
              title: "POST",
              onPressed: () {
                var dateNow = DateTime.now();
                if (SocialCubit.get(context).postImage == null) {
                  SocialCubit.get(context).createPost(
                      text: textController.text, dateTime: dateNow.toString());
                } else {
                  SocialCubit.get(context).uploadPostImage(
                      text: textController.text, dateTime: dateNow.toString());
                }
              })
        ]),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              if (state is SocialCreatePostLoadingState)
                const LinearProgressIndicator(),
              if (state is SocialCreatePostLoadingState)
                const SizedBox(
                  height: 10,
                ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(userModel?.image ?? ""),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Text(
                      userModel?.name ?? "",
                      style: const TextStyle(
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(
                      hintText: "What's your mind ?", border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (SocialCubit.get(context).postImage != null)
                Stack(
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
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(SocialCubit.get(context).postImage!),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: const CircleAvatar(
                            child: Icon(
                          Icons.close,
                          size: 16,
                        )))
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5,
                            ),
                            Text("add photo")
                          ],
                        )),
                  ),
                  Expanded(
                    child: TextButton(onPressed: () {}, child: Text("#tags")),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
