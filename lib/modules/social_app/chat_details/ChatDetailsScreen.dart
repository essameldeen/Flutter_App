import 'package:app_test/layout/social_app/cubit/cubit.dart';
import 'package:app_test/model/social/SocialUserModel.dart';
import 'package:app_test/model/social/message_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/cubit/states.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;
  var messageController = TextEditingController();
  var colorGrey = Colors.grey[300];

  ChatDetailsScreen({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getAllMessages(receiverId: userModel.uId ?? "");
      return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(userModel.image ?? ""),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(userModel.name ?? ""),
                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition: SocialCubit.get(context).messages.length > 0,
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (SocialCubit.get(context)
                                        .messages[index]
                                        .receiverId !=
                                    userModel.uId) {
                                  return buildMessageItem(
                                      SocialCubit.get(context).messages[index]);
                                } else {
                                  return buildMyMessageItem(
                                      SocialCubit.get(context).messages[index]);
                                }
                              },
                              separatorBuilder: (context, index) => const SizedBox(height: 15,),
                              itemCount:
                                  SocialCubit.get(context).messages.length),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: colorGrey!, width: 1),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter your message"),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        text: messageController.text,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: userModel.uId ?? "");
                                    messageController.text="";
                                  },
                                  icon: const Icon(
                                    IconBroken.Send,
                                    color: defaultColor,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
    });
  }

  Widget buildMessageItem(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                )),
            child: Text(message.text ?? "")),
      );

  Widget buildMyMessageItem(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            decoration: BoxDecoration(
                color: defaultColor.withOpacity(.2),
                borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                )),
            child: Text(message.text ?? "")),
      );
}
