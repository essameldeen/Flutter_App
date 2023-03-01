import 'package:app_test/layout/shop_app/shop_layout.dart';
import 'package:app_test/modules/shop_app/login/cubit/ShopCubit.dart';
import 'package:app_test/modules/shop_app/login/cubit/shope_login_state.dart';
import 'package:app_test/modules/shop_app/register/register_screen.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:app_test/shared/components/constants.dart';
import 'package:app_test/shared/network/local%20/cach_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext buildContext) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel?.status == true) {
              if(state.loginModel?.data?.token!=null){
                CacheHelper.saveData(key: "token", value: state.loginModel?.data?.token).then((value){
                  showToast(state.loginModel?.message,ToastStates.SUCCESS);
                  token = state.loginModel?.data?.token;
                  navigateToAndFinish(context, ShopLayout());
                });

              }

            } else {
              showToast(state.loginModel?.message,ToastStates.ERROR);
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
                          "LOGIN",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          "Login now to browse our last offers",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
                            onSubmit: (value) {
                              login(context);
                            },
                            onEyeClick: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            showLock: true,
                            isPassword:
                                ShopLoginCubit.get(context).isPasswordShow,
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
                            suffixIcon: ShopLoginCubit.get(context).suffix,
                            textInputType: TextInputType.visiblePassword),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                              title: "LOGIN",
                              function: () {
                                login(context);
                              }),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't Have An Account?"),
                            defaultTextButton(
                                title: "Register Now",
                                onPressed: () {
                                  navigateTo(context, ShopRegisterScreen());
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

  void login(context) {
    if (formKey.currentState?.validate() == true) {
      ShopLoginCubit.get(context).login(
          email: emailController.text, password: passwordController.text);
    }
  }
}
