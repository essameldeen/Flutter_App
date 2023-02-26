import 'package:app_test/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var isObscure= true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(

            child: Form(
              key: formKey ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height:30.0,
                  ),

                  defaultFormField(
                      controller: emailController
                      , hint: 'Enter your Email',
                      label: 'Email',
                      validator: (value){
                        if(value?.isEmpty==true){
                          return "Email Address must not be empty!!";
                        }
                        return null;
                      },
                      prefixIcon: Icons.email,
                      textInputType: TextInputType.emailAddress)
             ,
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    onEyeClick: (){
                      setState(() {
                        isObscure=!isObscure;
                      });
                    },
                    showLock: true,
                    isPassword: isObscure,
                    textInputType: TextInputType.visiblePassword,
                      controller: passwordController,
                      hint: "Enter your password",
                      label: "Password",
                      validator: (value){
                        if(value?.isEmpty==true){
                          return "Password  must not be empty!!";
                        }
                        return null;
                      },
                      prefixIcon: Icons.lock),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultButton(title: "login", function: (){
                    if(formKey.currentState?.validate()==true){
                      print(emailController.text);
                      print(passwordController.text);
                    }


                  }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                    const Text("Don't have an Account?",),
                      TextButton(onPressed: (){}, child: Text("Register Now"))
                  ],)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
