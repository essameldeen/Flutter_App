import 'package:app_test/layout/news_app/cubit/cubit.dart';
import 'package:app_test/layout/news_app/cubit/states.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:app_test/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/news_app/search/search_screen.dart';


class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon:const Icon(Icons.search,size:35.0,)),
              IconButton(onPressed: (){
                AppCubit.get(context).changeThemeMode();
              }, icon:const Icon(Icons.brightness_4_outlined,size:35.0,)),
            ],
            title: const Text("News App"),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
          body: cubit.news_screen[cubit.currentIndex],
        );
      },
    );
  }
}
