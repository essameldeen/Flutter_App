import 'package:app_test/layout/shop_app/cubit/shop_home_cubit.dart';
import 'package:app_test/layout/shop_app/cubit/states.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/shop_app/search/search_screen.dart';
import '../../shared/components/constants.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Shop App",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                   icon: const Icon(Icons.search,color: Colors.black,),
                    onPressed: () {
                      navigateTo(context, ShopSearchScreen());
                    })
              ],
            ),
            bottomNavigationBar: BottomNavigationBar (
              onTap: (index){
                cubit.changeBottomIndex(index);
              },
              items:const [
                  BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.apps),label: "Category"),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favourites"),
                  BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Setting"),
              ],
            ),
            body:cubit.screens[cubit.currentIndex] ,
          );
        });
  }
}
