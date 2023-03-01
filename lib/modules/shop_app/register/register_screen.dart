import 'package:app_test/modules/shop_app/login/login_screen.dart';
import 'package:app_test/shared/components/components.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local /cach_helper.dart';
import 'cubit/ShopRegisterCubit.dart';
import 'cubit/shope_register_state.dart';

class ShopRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext buildContext) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel?.status == true) {

              if(state.registerModel?.data?.token!=null){
                CacheHelper.saveData(key: "token", value: state.registerModel?.data?.token).then((value){
                  showToast(state.registerModel?.message,ToastStates.SUCCESS);
                  token = state.registerModel?.data?.token;
                  navigateToAndFinish(context, ShopLayout());
                });
              }
            } else {
              showToast(state.registerModel?.message,ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineLarge,
                        ),
                        Text(
                          "Register now to browse our last offers",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            hint: "Enter your name",
                            label: "Name",
                            validator: (value) {
                              if (value?.isEmpty == true) {
                                return "Please Enter your Name..";
                              }
                              return null;
                            },
                            prefixIcon: Icons.person,
                            textInputType: TextInputType.name),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            hint: "Enter your phone",
                            label: "Phone",
                            validator: (value) {
                              if (value?.isEmpty == true) {
                                return "Please Enter your Phone..";
                              }
                              return null;
                            },
                            prefixIcon: Icons.phone,
                            textInputType: TextInputType.phone),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            hint: "Enter your Email",
                            label: "Email",
                            validator: (value) {
                              if (value?.isEmpty == true) {
                                return "Please Enter your Email..";
                              }
                              return null;
                            },
                            prefixIcon: Icons.email,
                            textInputType: TextInputType.emailAddress),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                            onSubmit: (value) {},
                            onEyeClick: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            showLock: true,
                            isPassword:
                            ShopRegisterCubit
                                .get(context)
                                .isPasswordShow,
                            controller: passwordController,
                            hint: "Enter your Password",
                            label: "Password",
                            validator: (value) {
                              if (value?.isEmpty == true) {
                                return "Please Enter your Email..";
                              }
                              return null;
                            },
                            prefixIcon: Icons.lock,
                            suffixIcon: ShopRegisterCubit
                                .get(context)
                                .suffix,
                            textInputType: TextInputType.visiblePassword),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) =>
                              defaultButton(
                                  title: "register",
                                  function: () {
                                    register(context);
                                  }),
                          fallback: (context) =>
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("If You Have An Account?"),
                            defaultTextButton(
                                title: "Login Now",
                                onPressed: () {
                                  navigateTo(context, ShopLoginScreen());
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void register(context) {
    if (formKey.currentState?.validate() == true) {
      ShopRegisterCubit.get(context).register(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text,
          phone: phoneController.text
      );
    }
  }
}
