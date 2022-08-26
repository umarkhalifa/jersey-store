import 'package:flutter/material.dart';
import 'package:untitled/contsants/extension.dart';

class AuthForm extends StatelessWidget {
  final String hint;
  final String name;
  final IconData iconData;
  final TextEditingController controller;

  const AuthForm(
      {Key? key,
      required this.hint,
      required this.name,
      required this.iconData, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        String pattern =
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp regExp = RegExp(pattern);
        if (name.capitalize() == 'Password') {
          if (value != null &&
              value.length < 7 &&
              regExp.hasMatch(value) == false) {
            return "Enter a valid Password";
          }
        } else if (value != null && value.length < 7) {
          return "Enter a valid ${name.capitalize()}";
        }
        return null;
      },
      obscureText: name.capitalize() == "Password" ? true : false,
      controller: controller,
      style: TextStyle(
        fontFamily: "Regular",color: Colors.grey.shade800
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(iconData, color: Colors.grey,),
        hintText: name.capitalize(),
        hintStyle: TextStyle(fontFamily: "Regular",color: Colors.grey.shade400),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.transparent),),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Colors.transparent),),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Colors.transparent),),
      ),
    );
  }
}
