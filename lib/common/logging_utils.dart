import 'dart:developer' as developer;
import 'package:logging/logging.dart';
class Logger {
  
  String name;

  Logger(this.name);

  info(String message){
   
      developer.log(message, time: DateTime.now(), level:Level.INFO.value, name: name);
  }
   warning(String message){
   
      developer.log(message, time: DateTime.now(), level:Level.WARNING.value, name: name);
  }
   severe(String message){
   
      developer.log(message, time: DateTime.now(), level:Level.SEVERE.value, name: name);
  }


}



