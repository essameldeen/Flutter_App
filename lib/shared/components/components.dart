import 'package:app_test/shared/cubit/cubit.dart';
import 'package:app_test/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/news_app/web_view/webView_screen.dart';

Widget defaultButton(
        {double width = double.infinity,
        Color background = Colors.blue,
        required String title,
        required Function() function}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(8.0)),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontSize: 24.0),
        ),
      ),
    );

Widget defaultFormField(
        {bool showLock = false,
        bool isPassword = false,
        required TextEditingController controller,
        required String hint,
        required String label,
        required String? Function(String?)? validator,
        required IconData prefixIcon,
        required TextInputType textInputType,
        Function()? onEyeClick,
        Function(String)? onChange,
        Function()? onTap,
        Function(String)? onSubmit,
        IconData? suffixIcon,
        bool isEnable = true}) =>
    TextFormField(
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      enabled: isEnable,
      validator: validator,
      controller: controller,
      keyboardType: textInputType,
      obscureText: isPassword,
      onChanged: onChange,
      decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: showLock
              ? IconButton(onPressed: onEyeClick, icon: Icon(suffixIcon))
              : null,
          border: const OutlineInputBorder()),
    );

Widget emptyScreen() => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.menu,
            size: 70,
            color: Colors.grey,
          ),
          Text(
            "No Task  Yet , Pleas Add Some Tasks",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );

ConditionalBuilder taskBuilder({required List<Map> tasks}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      fallback: (context) {
        return emptyScreen();
      },
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => taskCard(
                  context,
                  tasks[index]['id'],
                  tasks[index]["title"],
                  tasks[index]["time"],
                  tasks[index]["date"], () {
                AppCubit.get(context).updateDataInDB(
                    id: tasks[index]['id'], newStatus: 'archived');
              }, () {
                AppCubit.get(context)
                    .updateDataInDB(id: tasks[index]['id'], newStatus: 'done');
              }),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 1.0,
                  color: Colors.grey,
                ),
              ),
          itemCount: tasks.length),
    );

Widget taskCard(
  BuildContext context,
  int id,
  String taskTitle,
  String taskDate,
  String taskTime,
  Function() onArchivedClicked,
  Function() onCheckedClicked,
) =>
    Dismissible(
      key: Key(taskTime),
      onDismissed: (direction) {
        AppCubit.get(context).deleteDataInDB(id: id);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(taskTime),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    taskTitle,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    taskDate,
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            IconButton(
                onPressed: onCheckedClicked,
                icon: const Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: onArchivedClicked,
                icon: const Icon(
                  Icons.archive,
                  color: Colors.black45,
                )),
          ],
        ),
      ),
    );

Widget buildArticleItem(context, article) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${article['urlToImage']}"),
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(article['title'],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                    Text(
                      article['publishedAt'],
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget articleBuilder(list, {bool isSearch = false}) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) {
      return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(context, list[index]),
          separatorBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                color: Colors.grey,
                height: 1,
              ),
            );
          },
          itemCount: list.length);
    },
    fallback: (context) => isSearch
        ? Container()
        : const Center(
            child: CircularProgressIndicator(),
          ));

void navigateTo(context, screen) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );

void navigateToAndFinish(context, screen) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => screen), (route) {
      return false;
    });

Widget defaultTextButton(
        {required String title, required Function()? onPressed}) =>
    TextButton(onPressed: onPressed, child: Text(title.toUpperCase()));

void showToast( message, ToastStates state) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates{SUCCESS,ERROR,WARINING}

Color chooseToastColor(ToastStates state){
  Color  color;
  switch(state){
    case ToastStates.SUCCESS:
       color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARINING:
      color =  Colors.amber;
      break;
  }
  return color;
}
