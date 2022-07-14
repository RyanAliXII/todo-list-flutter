
import 'package:shared_preferences/shared_preferences.dart';

class Model {
  String baseURL = "http://10.0.2.2:8080/api/1";

   String cookies = "";
   String token = "";
   int currentUserId = 0;
  Model(){
    initAuthRequirements();
  }
  initAuthRequirements() async {
    Future<SharedPreferences> initPref = SharedPreferences.getInstance();
    var sharedPrefs = await initPref;
    cookies = sharedPrefs.get("cookies") as String? ?? " ";
    token = sharedPrefs.get("token") as String? ??  " ";
    currentUserId = sharedPrefs.getInt("userId") ?? 0;


  }


}
