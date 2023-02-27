import 'package:app_test/modules/shop_app/login/login_screen.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:app_test/shared/network/local%20/cach_helper.dart';
import 'package:flutter/material.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shop App",style: TextStyle(color: Colors.black),),
      actions: [
        defaultTextButton(title: "sign out", onPressed: (){
          CacheHelper.clearData("token").then((value){
            if(value == true){
              navigateToAndFinish(context, ShopLoginScreen());
            }
          });
        })
      ],
      ),
      body: Column(children: [
        Text("Home Screen"),
      ],),
    );
  }
}
