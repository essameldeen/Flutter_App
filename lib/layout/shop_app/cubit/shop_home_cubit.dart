import 'package:app_test/layout/shop_app/cubit/states.dart';
import 'package:app_test/model/shop/categories_model.dart';
import 'package:app_test/model/shop/home_model.dart';
import 'package:app_test/modules/shop_app/cateogries/category_screen.dart';
import 'package:app_test/modules/shop_app/favourites/favourites_screen.dart';
import 'package:app_test/modules/shop_app/products/products_screen.dart';
import 'package:app_test/modules/shop_app/settings/SettingScreen.dart';
import 'package:app_test/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/shop/change_favorities_model.dart';
import '../../../model/shop/favorites_model.dart';
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
  bool fav = true;

  void changeBottomIndex(index) {
    currentIndex = index;
    emit(ShopHomeBottomNavChangeState());
  }

  HomeModel? homeModel;
  Map<int, bool> favourites = {};

  void getHomeData() {
    emit(ShopHomeLoadingState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      emit(ShopHomeSuccessState());
      homeModel = HomeModel.fromJson(value?.data);
      homeModel?.data?.products.forEach((element) {
        favourites.addAll({element.id ?? 0: element.inFavorites ?? false});
      });
    }).catchError((error) {
      emit(ShopHomeErrorState(error.toString()));
    });
  }

  CategoriesModel? categoriesHomeModel;

  void getHomeCategoriesData() {
    emit(ShopHomeCategorySuccessState());

    DioHelper.getData(url: HOME_CATEGORIES, token: token).then((value) {
      emit(ShopHomeSuccessState());
      categoriesHomeModel = CategoriesModel.fromJson(value?.data);
    }).catchError((error) {
      emit(ShopHomeCategoryErrorState(error.toString()));
    });
  }

  bool isFavourite(int? id) {
    return favourites[id] ?? false;
  }

  ChangeFavoritiesModel? changeFavoritiesModel;

  void changeFavorites(int id) {
    favourites[id] = !favourites[id]!;
    emit(ShopHomeFavouriteChangeState());
    DioHelper.postData(url: FAVORITES, data: {'product_id': id}, token: token)
        .then((value) {
      changeFavoritiesModel = ChangeFavoritiesModel.fromJson(value?.data);
      if (changeFavoritiesModel?.status == false) {
        favourites[id] = !favourites[id]!;
      }else{
        getHomeFavoritiesData();
      }
      emit(ShopHomeFavouriteChangeSuccessState(changeFavoritiesModel?.status));
    }).catchError((error) {
      favourites[id] = !favourites[id]!;
      emit(ShopHomeFavouriteChangeErrorState(error.toString()));
    });
  }


  FavoritesModel? favoritesModel;

  void getHomeFavoritiesData() {
    emit(ShopHomeGetFavouriteLoadingState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      emit(ShopHomeGetFavouriteSuccessState());
      favoritesModel = FavoritesModel.fromJson(value?.data);
    }).catchError((error) {
      emit(ShopHomeGetFavouriteErrorState(error.toString()));
    });
  }
}
