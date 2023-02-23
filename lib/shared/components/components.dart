import 'package:app_test/shared/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

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
        Function()? onTap,
        bool isEnable = true}) =>
    TextFormField(
      onTap: onTap,
      enabled: isEnable,
      validator: validator,
      controller: controller,
      keyboardType: textInputType,
      obscureText: isPassword,
      decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: showLock
              ? IconButton(
                  onPressed: onEyeClick, icon: const Icon(Icons.remove_red_eye))
              : null,
          border: const OutlineInputBorder()),
    );

Widget emptyScreen() => Center(
  child:   Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.menu,size: 70,color: Colors.grey,),
          Text("No Task  Yet , Pleas Add Some Tasks",style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,

          ),)
        ],
      ),
);


ConditionalBuilder taskBuilder({required List<Map> tasks}) =>ConditionalBuilder(
  condition:tasks.isNotEmpty,
  fallback: (context){
    return emptyScreen( );
  },
  builder: (context)=> ListView.separated(
      itemBuilder: (context, index) => taskCard(
          context,
          tasks[index]['id'],
          tasks[index]["title"],
          tasks[index]["time"], tasks[index]["date"], () {
        AppCubit.get(context).updateDataInDB(
            id: tasks[index]['id'], newStatus: 'archived');
      }, () {
        AppCubit.get(context).updateDataInDB(
            id: tasks[index]['id'], newStatus: 'done');
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


Widget buildArticleItem(article)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image:  DecorationImage(fit: BoxFit.cover,
              image: NetworkImage( "${article['urlToImage']}"),
        ),
      ),
      ),
      const SizedBox(width: 20.0,),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              Expanded(
                child: Text(article['title'] ,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600
                  ),),
              ),
              Text(article['publishedAt'],style:const TextStyle(
                  color:Colors.grey
              ),),

            ],),
        ),
      )
    ],
  ),
);


Widget articleBuilder(list)=>ConditionalBuilder(
    condition:list.length >0,
    builder: (context){


      return ListView.separated(

          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index)=>buildArticleItem(list[index]),
          separatorBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(color: Colors.grey,height: 1,),
            );
          },
          itemCount: list.length);
    },
    fallback: (context)=>const Center(child: CircularProgressIndicator(),));
