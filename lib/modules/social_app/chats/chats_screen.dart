import 'package:app_test/layout/social_app/cubit/cubit.dart';
import 'package:app_test/layout/social_app/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/social/SocialUserModel.dart';
import '../../../shared/styles/colors.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var users = SocialCubit.get(context).users;
          return ConditionalBuilder(
            condition: SocialCubit.get(context).users.isNotEmpty ,
            fallback:(context)=>const Center(child: CircularProgressIndicator(),) ,
            builder:(context)=> ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => builtUserItem(users[index]),
                separatorBuilder: (context, index) => Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                itemCount: users.length),
          );
        });
  }

  Widget builtUserItem(SocialUserModel user) => InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(user.image ?? ""),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          user.name ?? "",
                          style: const TextStyle(
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  size: 16.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
}
