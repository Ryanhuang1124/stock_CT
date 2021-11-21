import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyColor {
  static Color buttonYellow = const Color.fromRGBO(255, 190, 64, 1);
  static Color buttonBlue = const Color(0xFFACB2E6);
  static Color appThemeBackground = const Color(0xFF303455);
  static Color segmentWhite = Colors.white.withOpacity(0.35);
  static Color blockBackground = const Color.fromRGBO(37, 40, 66, 1);

  static LinearGradient homePageLinear = const LinearGradient(colors: [
    Color.fromRGBO(255, 255, 255, 0.4),
    Color.fromRGBO(255, 255, 255, 0.1)
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}

class MyText {
  static TextStyle myTextStyle(
      {required double fontSize, FontWeight? weight, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily ?? 'NotoSansTC',
      fontWeight: weight ?? FontWeight.normal,
    );
  }
}

class CloudFirestore {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static addDeviceToken({required String token}) {
    firestore
        .collection('DeviceToken').doc('token')
        .set({
          'token':token
        })
        .then((value) => print('success'))
        .catchError((error) => print(error));
  }
}
