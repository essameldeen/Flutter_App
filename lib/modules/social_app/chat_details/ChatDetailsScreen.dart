import 'package:app_test/layout/social_app/cubit/cubit.dart';
import 'package:app_test/layout/social_app/cubit/states.dart';
import 'package:app_test/model/social/SocialUserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;
  var messageController = TextEditingController();
  var colorGrey = Colors.grey[300];

  ChatDetailsScreen({required this.userModel});

  @override
  Widget build(BuildContext context) {
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              buildMessageItem(),
              buildMyMessageItem(),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: colorGrey!, width: 1),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
    );
  }

  Widget buildMessageItem() => Align(
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
            child: Text("Hello Ali")),
      );

  Widget buildMyMessageItem() => Align(
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
            child: Text("Hello Ali")),
      );
}
