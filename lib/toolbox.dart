import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';



class MyDIO{

  static Future<bool> fcmSend({required String title,required String body}) async {
    String serverKey ='AAAAPLHzgPY:APA91bHJXCUlKpBDZ5fDlo8g6iRwz9m8WEmXm_WI5p6MxAohWZoAGCm9KKs0GxaHcENwg7Ac48GwRntT34uwSCjpixKtfP36x5ZImgAfyEgAiSX91-iD3BR2W_lIXgipYdpNJ-Ok2-WW';
    String uri = "https://fcm.googleapis.com/fcm/send";
    String token = 'dMwmtG3sRLuJLbWKnJaEnH:APA91bFbvWnysCT2WmvQcMADdXtLYRc3B0dbetcWXjjx3gnM5Vdu7RAB6t0a_-QXGFfb9OcdlDRzxT5ajyoi6lHi5qLauHKgVAceONEGvs-AxTrrfHeJu889UsFYH_OLbqouXR7SIdA9';
    var jsonData =json.encode({
      "to": token,
      "notification":{
        "title": title,
        "body": body,
      }
    });


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

      if(response.statusCode==200){
        return true;
      }else{
        return false;
      }
  }

}