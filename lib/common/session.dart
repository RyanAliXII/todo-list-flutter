import 'package:practice_app/common/globals.dart';
class Session {
  String token = "";
  String cookies = "";
  int userId = 0;
  Session(){
      cookies = Storage.local?.get("cookies") as String? ?? " ";
      token = Storage.local?.get("token") as String? ??  " ";
      userId = Storage.local?.getInt("userId") ?? 0;

  }


}