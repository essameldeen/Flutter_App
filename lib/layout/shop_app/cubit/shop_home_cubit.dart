import 'package:app_test/layout/shop_app/cubit/states.dart';
import 'package:app_test/model/shop/home_model.dart';
import 'package:app_test/modules/shop_app/cateogries/category_screen.dart';
import 'package:app_test/modules/shop_app/favourites/favourites_screen.dart';
import 'package:app_test/modules/shop_app/products/products_screen.dart';
import 'package:app_test/modules/shop_app/settings/SettingScreen.dart';
import 'package:app_test/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';

class ShopCubit extends Cubit<ShopHomeStates> {
  ShopCubit() : super(ShopHomeInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    ProductsScreen(),
    CategoryScreen(),
    FavouritesScreen(),
    SettingScreen()
  ];
  var currentIndex = 0;

  void changeBottomIndex(index) {
    currentIndex = index;
    emit(ShopHomeBottomNavChangeState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopHomeLoadingState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      emit(ShopHomeSuccessState());
      homeModel = HomeModel.fromJson(value?.data);
      print(homeModel);
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeErrorState(error.toString()));
    });
  }
}