import 'package:app_test/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterStateInitial());


  static CounterCubit get(context) => BlocProvider.of(context);

  // data that will be change in the screen
    int counter =1;

    // event bt3ty el ht7sl 3l el data

  void minus(){
    counter--;
    emit (CounterStateMinus());
  }

  void add(){
    counter++;
    emit (CounterStateAdd());

  }
}
