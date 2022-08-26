import 'package:flutter/material.dart';

class SnackUtils {
  static void showSnackBar(
      {required BuildContext myContext,
      required String message,
      required bool isError}) {
    ScaffoldMessenger.of(myContext).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'Regular',
            color: Colors.white,
          ),
        ),
        duration: const Duration(milliseconds: 900),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }
}
