import 'package:app_test/model/shop/search_model.dart';
import 'package:app_test/modules/shop_app/search/cubit/search_states.dart';
import 'package:app_test/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/network/end_points.dart';

class SearchCubit extends Cubit<HomeSearchStates> {
  SearchCubit() : super(HomeSearchInitalState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? model;

  void search(String search) {
    emit(HomeSearchLoadingState());
    DioHelper.postData(url: HOME_SEARCH, token: token, data: {'text': search})
        .then((value) {
      model = SearchModel.fromJson(value?.data);
      emit(HomeSearchGetDataSuccessState());
    }).catchError((error) {
      print (error.toString());
      emit(HomeSearchGetDataErrorState(error.toString()));
    });
  }
}
