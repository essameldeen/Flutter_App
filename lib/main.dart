import 'package:app_test/layout/shop_app/cubit/shop_home_cubit.dart';
import 'package:app_test/layout/social_app/cubit/cubit.dart';
import 'package:app_test/layout/social_app/social_layout.dart';
import 'package:app_test/modules/social_app/social_login/social_login_screen.dart';
import 'package:app_test/shared/block_0bserver.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:app_test/shared/components/constants.dart';
import 'package:app_test/shared/cubit/cubit.dart';
import 'package:app_test/shared/cubit/states.dart';
import 'package:app_test/shared/network/local%20/cach_helper.dart';
import 'package:app_test/shared/network/remote/dio_helper.dart';
import 'package:app_test/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/news_app/cubit/cubit.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print(" on background message");
  print(message.data);
  print(message.notification.toString());
  showToast("on message background ", ToastStates.SUCCESS);
}


void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // to ensure that all function finished before running
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

   await Firebase.initializeApp();

  var tokenApp = await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen((event) {
    print("hena");
    print(event.data.toString());
    print(event.notification.toString());

    showToast("on message", ToastStates.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("hena on background");
    print(event.data.toString());
    print(event.notification.toString());
    showToast("on message open app ", ToastStates.SUCCESS);

  });


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


   print(tokenApp);
  DioHelper.init();

  Widget? screen;
  bool? isDark = CacheHelper.getData("isDark");
  // bool? onBoarding = CacheHelper.getData("onBoarding");
  // String? tokenUser = CacheHelper.getData("token");
  String? uId = CacheHelper.getData("uId");

  token = uId;
  // if (tokenUser != null && onBoarding != null) {
  //   screen = ShopLayout();
  // } else if (onBoarding == true) {
  //   screen = ShopLoginScreen();
  // } else {
  //   screen = OnBoardingScreen();
  // }
  if (uId != null) {
    screen = SocialLayout();
  } else {
    screen = SocialLoginScreen();
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
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
        BlocProvider(
          create: (context) => NewsCubit()..getBusinessData(),
        ),
        BlocProvider(
            create: (context) =>
                AppCubit()..changeThemeMode(isDarkFromSharedPref: isDark)),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getHomeCategoriesData()
              ..getHomeFavoritiesData()
              ..getUserData())
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
