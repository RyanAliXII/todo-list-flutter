


import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:practice_app/common/callbacks.dart';
import 'package:practice_app/components/snackbars.dart';
import 'package:practice_app/components/spacing.dart';
import 'package:practice_app/models/user.dart';
import 'package:practice_app/pages/entry.dart';
import 'package:practice_app/providers/repositories_provider.dart';
import 'package:practice_app/repositories/repository.dart';
import 'package:practice_app/repositories/user_repository.dart';
import 'package:practice_app/themes/style.dart';
import 'package:provider/provider.dart';


MultiValidator emailValidator = MultiValidator([
    EmailValidator(errorText: "Invalid email address")
]);

MultiValidator passwordValidator = MultiValidator([
    MinLengthValidator(8, errorText:"Password must be atleast 8 characters")

]);
MultiValidator nameValidator = MultiValidator([
    MinLengthValidator(3, errorText:"Name must be atleast 3 characters")
  
]);

class SignUpPage extends StatefulWidget{
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
  
}


class _SignUpPageState extends State<SignUpPage>{

  final emailTextFieldController = TextEditingController();
  final passwordTextFieldController = TextEditingController();
  final nameTextFieldController = TextEditingController();
   GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form( 
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "Sign Up",
                  style: TitleText(),
                ),
              ),

              vSpacing20,
            vSpacing20,
              TextFormField(
                  controller: emailTextFieldController,
                  decoration: const PrimaryTextFieldDecoration(labelText: "Email"),
                  validator: emailValidator,
                  ),
        
              vSpacing12,
                TextFormField(
                  controller: nameTextFieldController,
                  decoration: const PrimaryTextFieldDecoration(labelText: "Fullname"),
                  validator: nameValidator,
                  
                  ),
        
              vSpacing12,
              TextFormField(
                  obscureText: true,
                  controller: passwordTextFieldController,
                  decoration: const PrimaryTextFieldDecoration(labelText: "Password"),
                  validator: passwordValidator,
                  ),
                 
             vSpacing12,
              Center(
                child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                        onPressed: _signUp,
                        style: PrimaryButtonStyle().init(),
                        child: const Text(
                          "Sign up",
                          style: PrimaryButtonTextStyle(),
                        ))),
              )
            ],
          )
          ),
        ));
  }
_signUp()async{
    if(formKey.currentState == null) return;
    if(formKey.currentState!.validate() == false) return;
      User u = User(name: nameTextFieldController.text, email: emailTextFieldController.text, password: passwordTextFieldController.text);
      Response r = await context.read<RepositoryProvider>().userRepository.register(u);
      var data = json.decode(r.body);
   
      if(r.statusCode == StatusCode.OK){
            runIfMounted(mounted,(){
            ScaffoldMessenger.of(context).showSnackBar(successSnackbar("You have successfully registered"));
             } );
      }
      else{
         runIfMounted(mounted,(){
            String err = data['message']['Message'].toString();
            ScaffoldMessenger.of(context).showSnackBar(errorSnackbar(err));
             } );
      }
}
}