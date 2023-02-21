import 'package:app_test/model/user/user_model.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(id: 1, name: "Essam Mohamed", phone: "01119955849"),
    UserModel(id: 2, name: "Ali Mohamed", phone: "01119955849"),
    UserModel(id: 3, name: "Esra Mohamed", phone: "01119955849"),
    UserModel(id: 4, name: "Bassem Mohamed", phone: "01119955849"),
    UserModel(id: 5, name: "Osama Mohamed", phone: "01119955849"),
    UserModel(id: 6, name: "Sayed Mohamed", phone: "01119955849"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildUserItem(users[index]),
          separatorBuilder: (context, index) => buildSeparator(),
          itemCount: users.length),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
             CircleAvatar(
              radius: 25.0,
              child: Text(
              user.id.toString(),
                style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children:  [
                Text(
                  user.name,
                  style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  user.phone,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      );

  Widget buildSeparator() => Padding(
        padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0),
        child: Container(
          width: double.infinity,
          color: Colors.grey[300],
          height: 1.0,
        ),
      );
}

