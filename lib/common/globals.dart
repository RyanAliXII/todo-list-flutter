

import 'package:shared_preferences/shared_preferences.dart';

class Storage {      
  static SharedPreferences? local;
  static Future init() async {
    local = await SharedPreferences.getInstance();
  }
}
