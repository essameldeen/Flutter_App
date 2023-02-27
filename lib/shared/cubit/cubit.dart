
import 'package:app_test/shared/cubit/states.dart';
import 'package:app_test/shared/network/local%20/cach_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/todo_app/ tasks/new_task_screen.dart';
import '../../modules/todo_app/archived_task/archived_task_screen.dart';
import '../../modules/todo_app/done_tasks/done_tasks_screen.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  late Database db;

  List<Map> newTasks = [];
  List<Map> archivedTasks = [];
  List<Map> doneTasks = [];
  List<Widget> screen = [
    NewTaskScreen(),
    ArchivedTaskScreen(),
    DoneTasksScreen()
  ];
  List<String> titlesList = ["New Task", "Archived Task", "Done Task"];

  int currentIndex = 0;
  IconData fabIcon = Icons.edit;
  bool isBottomSheetShow = false;

  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    emit(AppChangeBottomNavBarState());
  }

  void changeBottomSheetState(
      {required bool newValue, required IconData newIcon}) {
    isBottomSheetShow = newValue;
    fabIcon = newIcon;
    emit(AppChangeBottomSheetState());
  }

  void createDataBase() {
    openDatabase("todo.db", onCreate: (databaseObject, version) {
      databaseObject.execute(
          "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT,status TEXT)");
    }, onOpen: (dataBaseObject) {
      getDataFromDataBase(dataBaseObject);
    }, version: 1)
        .then((value) {
      db = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertIntoDatabase(
      {required String title,
      required String time,
      required String date}) async {
    await db.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$time","$date","new")')
          .then((value) {
        emit(AppInsertDatabaseState());
        getDataFromDataBase(db);
      });
    });
  }

  void updateDataInDB({
    required int id,
    required String newStatus,
  }) {
    db.rawUpdate("UPDATE tasks set status = ? WHERE id =?",
        [newStatus, id]).then((value) {
      getDataFromDataBase(db);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteDataInDB({required int id}){
    db.rawDelete("DELETE FROM tasks WHERE id =?",
        [id]).then((value) {
      getDataFromDataBase(db);
      emit(AppDeleteDatabaseState());
    });
  }

  void getDataFromDataBase(Database dataBaseObject) {
    emit(AppShowProgressBarState());
    dataBaseObject.rawQuery("SELECT * FROM tasks").then((value) {
      newTasks.clear();
      archivedTasks.clear();
      doneTasks.clear();
      for (var element in value) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      }
      emit(AppGetDatabaseState());
    });
  }


  ThemeMode appMode = ThemeMode.dark;

  void changeThemeMode({bool? isDarkFromSharedPref}) {

    if(isDarkFromSharedPref!=null){
       if(isDarkFromSharedPref){
         appMode=ThemeMode.dark;
       }else{
         appMode=ThemeMode.light;
       }
       emit(AppChangeThemeModeState());
    }else{
      if (appMode == ThemeMode.dark) {
        appMode = ThemeMode.light;
        CacheHelper.saveData(key: "isDark", value: false);
      } else {
        appMode = ThemeMode.dark;
        CacheHelper.saveData(key: "isDark", value: true);
      }
      emit(AppChangeThemeModeState());
    }



  }
}
