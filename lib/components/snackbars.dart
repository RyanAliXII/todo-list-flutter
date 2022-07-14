



import 'package:flutter/material.dart';
import 'package:practice_app/components/spacing.dart';



SnackBar successSnackbar(String message){

  return SnackBar(content:buildSuccessSnackbarContent(message), padding: EdgeInsets.zero, backgroundColor:Colors.green);
}
SnackBar errorSnackbar(String message){

  return SnackBar(content:buildErrorSnackbarContent(message), padding: EdgeInsets.zero, backgroundColor:Colors.redAccent);
}


Widget buildSuccessSnackbarContent(String message){

    return SizedBox( 
      height: 50,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
          hSpacing10,
          const Icon(Icons.check_circle,color: Colors.white),
          hSpacing10,
          Text(message)
      ],
    )
    );
}
Widget buildErrorSnackbarContent(String message){

    return SizedBox( 
      height: 50,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
          hSpacing10,
          const Icon(Icons.error_rounded,color: Colors.white),
          hSpacing10,
          Flex(direction: Axis.horizontal,children: [Text(message)])
      ],
    )
    );
}