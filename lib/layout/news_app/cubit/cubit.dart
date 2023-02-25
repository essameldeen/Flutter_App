import 'package:app_test/layout/news_app/cubit/states.dart';
import 'package:app_test/modules/business/business_screen.dart';
import 'package:app_test/modules/science/science_screen.dart';
import 'package:app_test/modules/sports/sports_screen.dart';
import 'package:app_test/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: "Business"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_soccer), label: "Sports"),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
  ];
  List<Widget> news_screen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int newIndex) {
    currentIndex = newIndex;
    if (currentIndex == 1) {
      getSportsData();
    }
    if (currentIndex == 2) {
      getScienceData();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusinessData() {
    emit(NewShowLoadingState());
    if (business.length == 0) {
      DioHelper.getData(url: GET_DATA, query: {
        'country': COUNTRY,
        'category': BUSINESS_CATEGORY,
        'apiKey': API_KEY
      }).then((value) {
        business = value?.data['articles'];
        print(business);
        emit(NewGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewGetBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];

  void getSportsData() {
    emit(NewShowLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: GET_DATA, query: {
        'country': COUNTRY,
        'category': SPORTS_CATEGORY,
        'apiKey': API_KEY
      }).then((value) {
        sports = value?.data['articles'];
        emit(NewGetSportsSuccessState());
        print(sports);
      }).catchError((error) {
        print(error.toString());
        emit(NewGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScienceData() {
    emit(NewShowLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: GET_DATA, query: {
        'country': COUNTRY,
        'category': 'science',
        'apiKey': API_KEY
      }).then((value) {
        science = value?.data['articles'];
        print(science);
        emit(NewGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearchResult(String searchValue) {
    emit(NewShowLoadingState());
      DioHelper.getData(
          url: SEARCH
          , query: {
        'q': searchValue,
        'apiKey': API_KEY
      }).then((value) {
        search = value?.data['articles'];
        print(searchValue);
        emit(NewGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewGetSportsErrorState(error.toString()));
      });
  }


}
