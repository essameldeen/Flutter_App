import 'package:app_test/layout/shop_app/cubit/shop_home_cubit.dart';
import 'package:app_test/layout/shop_app/cubit/states.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:app_test/shared/components/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopHomeStates>(
      listener: (context,state){
         if(state is ShopHomeGetUserDataSuccessState){
            emailController.text = state.loginModel?.data?.email??"";
            nameController.text = state.loginModel?.data?.name??"";
            phoneController.text = state.loginModel?.data?.phone??"";
         }
      },
      builder: (context,state) {
        var userModel = ShopCubit.get(context).userModel;
        emailController.text = userModel?.data?.email??"";
        nameController.text = userModel?.data?.name??"";
        phoneController.text = userModel?.data?.phone??"";

        return ConditionalBuilder(
        condition: ShopCubit.get(context).userModel !=null,
        builder:(context)=>Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              defaultFormField(
                  controller: nameController,
                  hint: "Enter your Name",
                  label: "Name",
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return "Please must enter your name";
                    }
                    return null;
                  },
                  prefixIcon: Icons.person,
                  textInputType: TextInputType.name),
              const SizedBox(height: 20.0,),
              defaultFormField(
                  controller: phoneController,
                  hint: "Enter your Phone",
                  label: "Phone",
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return "Please must enter your name";
                    }
                    return null;
                  },
                  prefixIcon: Icons.phone,
                  textInputType: TextInputType.phone),
              const SizedBox(height: 20.0,),
              defaultFormField(
                  controller: emailController,
                  hint: "Enter your Email",
                  label: "Email",
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return "Please must enter your email";
                    }
                    return null;
                  },
                  prefixIcon: Icons.email,
                  textInputType: TextInputType.emailAddress),
              const SizedBox(height: 20.0,),
              defaultButton(title: "log out ", function: (){
                ShopCubit.get(context).currentIndex=0;
                signOut(context);
              })
            ],
          ),
        ) ,
        fallback:(context)=>const Center(child: CircularProgressIndicator(),) ,

      );
      },
    );
  }
}
