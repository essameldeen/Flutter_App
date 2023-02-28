import 'package:app_test/layout/shop_app/cubit/shop_home_cubit.dart';
import 'package:app_test/layout/shop_app/shop_layout.dart';
import 'package:app_test/modules/shop_app/login/login_screen.dart';
import 'package:app_test/modules/shop_app/on_boarding/onboarding_screen.dart';
import 'package:app_test/shared/block_0bserver.dart';
import 'package:app_test/shared/components/constants.dart';
import 'package:app_test/shared/cubit/cubit.dart';
import 'package:app_test/shared/cubit/states.dart';
import 'package:app_test/shared/network/local%20/cach_helper.dart';
import 'package:app_test/shared/network/remote/dio_helper.dart';
import 'package:app_test/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/news_app/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // to ensure that all function finished before running
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();

  Widget? screen;
  bool? isDark = CacheHelper.getData("isDark");
  bool? onBoarding = CacheHelper.getData("onBoarding");
  String? tokenUser = CacheHelper.getData("token");
  token = tokenUser;
  if (tokenUser != null && onBoarding != null) {
    screen = ShopLayout();
  } else if (onBoarding == true) {
    screen = ShopLoginScreen();
  } else {
    screen = OnBoardingScreen();
  }

  runApp(MyApp(isDark, screen));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? screen;

  MyApp(this.isDark, this.screen);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()..getBusinessData(),
        ),
        BlocProvider(
            create: (context) =>
                AppCubit()..changeThemeMode(isDarkFromSharedPref: isDark)),
        BlocProvider(create: (context) => ShopCubit()..getHomeData())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          themeMode: AppCubit.get(context).appMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: screen,
        ),
      ),
    );
  }
}
