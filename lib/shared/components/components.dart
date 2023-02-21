import 'package:flutter/material.dart';

Widget defaultButton({
        double width = double.infinity,
        Color background = Colors.blue,
        required String title,
        required Function() function
        }) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: MaterialButton(
        onPressed: function,
        child:  Text(
          title.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontSize: 24.0),
        ),
      ),
    );



Widget defaultFormField({
  bool showLock = false,
  bool isPassword= false,
  required TextEditingController controller,
  required String hint,
  required String label,
  required String? Function(String?)? validator,
  required IconData prefixIcon,
  required TextInputType textInputType,
  Function()? onEyeClick,
}) =>     TextFormField(
  validator: validator,
  controller: controller,
  keyboardType: textInputType,
  obscureText: isPassword,

  decoration:  InputDecoration(
      hintText: hint,
      labelText: label ,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: showLock ?  IconButton(
          onPressed:onEyeClick ,
          icon:const Icon(Icons.remove_red_eye)):null,
      border: const OutlineInputBorder()),
);