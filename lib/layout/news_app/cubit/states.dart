abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsBottomNavState extends NewsState {}

class NewShowLoadingState extends NewsState {}

class NewGetBusinessSuccessState extends NewsState {}

class NewGetBusinessErrorState extends NewsState {
  final String error;

  NewGetBusinessErrorState(this.error);
}




class NewGetSportsSuccessState extends NewsState {}
class NewGetSportsErrorState extends NewsState {
  final String error;

  NewGetSportsErrorState(this.error);
}

class NewGetScienceSuccessState extends NewsState {}
class NewGetScienceErrorState extends NewsState {
  final String error;

  NewGetScienceErrorState(this.error);
}

class NewGetSearchSuccessState extends NewsState {}
class NewGetSearchErrorState extends NewsState {
  final String error;

  NewGetSearchErrorState(this.error);
}
