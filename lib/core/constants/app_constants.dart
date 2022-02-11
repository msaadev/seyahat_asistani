import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:lib_msaadev/lib_msaadev.dart';

class AppConstants {
  static const Color BACKGROUND_COLOR = Color(0xffFFFFFF);
  static const Color LOGIN_END = Color(0xFF4084ff);
  static const LOGIN_START = Color(0xFF4650fe);
  static const BUTTON = Color(0xff4469ff);

  static String? validator(String? value, {int len = 4, String message = '*'}) {
    if (value!.length < len) {
      return message;
    } else {
      return null;
    }
  }

  static void showErrorToas({required String message}) {
    baseToast(message: message, backColor: Colors.red, textColor: Colors.white);
  }

  static void showSuccesToas({required String message}) {
    baseToast(message: message, backColor: Colors.green, textColor: Colors.white);
  }

  static void baseToast(
      {required String message,
      Color backColor = Colors.white,
      Color textColor = Colors.black}) {
    BotToast.showCustomNotification(
        crossPage: true,
        onlyOne: false,
        toastBuilder: (_) {
          return Container(
            height: 50,
            margin: 10.paddingAll,
            padding: 10.paddingAll,
            decoration: BoxDecoration(
              color: backColor,
              borderRadius: 0.radius5,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              message,
              style: TextStyle(color: textColor),
            ),
          );
        });
  }
}
