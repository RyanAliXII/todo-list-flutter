

import 'package:flutter/material.dart';

class PrimaryButtonStyle{
  ButtonStyle init(){
    return TextButton.styleFrom(backgroundColor: Colors.blue, );
}    
}

class SecondaryButtonStyle{
  ButtonStyle init(){
    return TextButton.styleFrom(backgroundColor: Colors.grey.shade500, );
}    
}
class PrimaryTextFieldDecoration extends InputDecoration {

  const PrimaryTextFieldDecoration({String? labelText}):super(labelText:labelText,
                                    focusedErrorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.redAccent,
                                          width: 2.0,
                                        ),
                                      ),
                                      errorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.redAccent,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 2.0,
                                        ),
                                      ),
                                    );
}  

class PrimaryButtonTextStyle extends TextStyle{
  const PrimaryButtonTextStyle():super(
    color:Colors.white, fontFamily: "Montserrat", fontSize: 15, fontWeight: FontWeight.w600
  );
}

class TitleText extends TextStyle{
    const TitleText():super(
    fontFamily: "Monstserrat", fontWeight: FontWeight.w600, fontSize: 30, color: Colors.blue
  );
}