import 'package:app_test/layout/news_app/news_layout.dart';
import 'package:app_test/shared/block_0bserver.dart';
import 'package:app_test/shared/cubit/cubit.dart';
import 'package:app_test/shared/cubit/states.dart';
import 'package:app_test/shared/network/local%20/cach_helper.dart';
import 'package:app_test/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/news_app/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // to ensure that all function finished before running
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();

  bool? isDark = CacheHelper.getData("isDark");
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()..getBusinessData(),
        ),
        BlocProvider(
            create: (context) =>
                AppCubit()..changeThemeMode(isDarkFromSharedPref: isDark))
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          themeMode: AppCubit.get(context).appMode,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: Colors.white,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange),
            appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
                color: Colors.white,
                elevation: 0.0,
                backwardsCompatibility: false,
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarColor: Colors.white)),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 20.0),
            textTheme: const TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: HexColor('333739'),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange),
            appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                iconTheme: const IconThemeData(color: Colors.white),
                titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
                color: HexColor('333739'),
                elevation: 0.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.light,
                    statusBarColor: HexColor('333739'))),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('333739'),
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.deepOrange,
                elevation: 20.0),
            textTheme: const TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ),
          debugShowCheckedModeBanner: false,
          home: NewsLayout(),
        ),
      ),
    );
  }
}
