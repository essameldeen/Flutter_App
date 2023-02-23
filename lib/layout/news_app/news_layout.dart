import 'package:app_test/layout/news_app/cubit/cubit.dart';
import 'package:app_test/layout/news_app/cubit/states.dart';
import 'package:app_test/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewsCubit()..getBusinessData(),
        child: BlocConsumer<NewsCubit, NewsState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(onPressed: (){}, icon:const Icon(Icons.search))
                ],
                title: const Text("News"),
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
        ));
  }
}
