abstract class HomeSearchStates {}

class HomeSearchInitalState extends HomeSearchStates {}

class HomeSearchLoadingState extends HomeSearchStates {}

class HomeSearchGetDataSuccessState extends HomeSearchStates {}

class HomeSearchGetDataErrorState extends HomeSearchStates {
  final String error;

  HomeSearchGetDataErrorState(this.error);
}
