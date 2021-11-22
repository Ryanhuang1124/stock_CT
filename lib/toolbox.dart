import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_ct/home_page.dart';

class MyColor {
  static Color buttonYellow = const Color.fromRGBO(255, 190, 64, 1);
  static Color buttonBlue = const Color(0xFFACB2E6);
  static Color appThemeBackground = const Color(0xFF303455);
  static Color segmentWhite = Colors.white.withOpacity(0.35);
  static Color blockBackground = const Color.fromRGBO(37, 40, 66, 1);
  static Color textWhite = Colors.white;

  static LinearGradient homePageLinear = const LinearGradient(colors: [
    Color.fromRGBO(255, 255, 255, 0.4),
    Color.fromRGBO(255, 255, 255, 0.1)
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
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

class CloudFirestore {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static addDeviceToken({required String token, required String name}) {
    firestore
        .collection('DeviceToken')
        .doc('token')
        .update({name: token})
        .then((value) => print('success'))
        .catchError((error) => print(error));
  }
}

class MyDialog {
  static TextEditingController nameController = TextEditingController();
  static Future<void> showAccountDialog(
      {required context, required token}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('輸入名稱'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  style: MyText.myTextStyle(
                      fontSize: 18, fontColor: MyColor.textWhite),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('登入'),
              onPressed: () {
                print(nameController.text.runtimeType);
                if (nameController.text.isNotEmpty) {
                  CloudFirestore.addDeviceToken(
                      token: token, name: nameController.text);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const HomePage();
                  }));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
