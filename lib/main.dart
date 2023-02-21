import 'package:app_test/modules/bmi_result/bmi_result.dart';
import 'package:app_test/modules/bmi/bmi_screen.dart';
import 'package:app_test/modules/login/login_screen.dart';
import 'package:app_test/modules/messanger/messanger_screen.dart';
import 'package:app_test/modules/user/user_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       home: LoginScreen(),
     );
  }

}
