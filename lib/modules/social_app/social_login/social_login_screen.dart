import 'package:app_test/layout/social_app/social_layout.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:app_test/shared/network/local%20/cach_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../social_register/social_register_screen.dart';
import 'cubit/SocialCubit.dart';
import 'cubit/social_login_state.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext buildContext) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(state.error, ToastStates.ERROR);
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: "uId", value: state.uId).then((value) {
              navigateToAndFinish(context, SocialLayout());
            });
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
                          "Login now to Share your Moments",
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
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            showLock: true,
                            isPassword:
                                SocialLoginCubit.get(context).isPasswordShow,
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
                            suffixIcon: SocialLoginCubit.get(context).suffix,
                            textInputType: TextInputType.visiblePassword),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
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
                                  navigateTo(context, SocialRegisterScreen());
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
      SocialLoginCubit.get(context).login(
          email: emailController.text, password: passwordController.text);
    }
  }
}
