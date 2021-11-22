import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyDIO {
  static Future<bool> fcmSend(
      {required String title,
      required String body,
      required List<String> target}) async {
    String serverKey =
        'AAAAPLHzgPY:APA91bHJXCUlKpBDZ5fDlo8g6iRwz9m8WEmXm_WI5p6MxAohWZoAGCm9KKs0GxaHcENwg7Ac48GwRntT34uwSCjpixKtfP36x5ZImgAfyEgAiSX91-iD3BR2W_lIXgipYdpNJ-Ok2-WW';
    String uri = "https://fcm.googleapis.com/fcm/send";
    var jsonData;
    if (target.length > 1) {
      jsonData = json.encode({
        "registration_ids": target,
        "notification": {
          "title": title,
          "body": body,
        }
      });
    } else {
      jsonData = json.encode({
        "to": target[0],
        "notification": {
          "title": title,
          "body": body,
        }
      });
    }

    var response = await Dio().post(uri,
        data: jsonData,
        options: Options(
            headers: {
              HttpHeaders.authorizationHeader: "key=$serverKey",
            },
            contentType: 'application/json',
            validateStatus: (status) {
              print(status);
              return true;
            }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

class MyColor {
  static Color appThemeBackground = const Color(0xFF303455);
  static Color textWhite = Colors.white;
}

class MyText {
  static TextStyle myTextStyle(
      {required double fontSize,
      FontWeight? weight,
      String? fontFamily,
      Color? fontColor}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily ?? 'NotoSansTC',
      fontWeight: weight ?? FontWeight.normal,
      color: fontColor ?? Colors.black,
    );
  }
}
