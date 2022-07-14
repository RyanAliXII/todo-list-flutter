import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practice_app/common/logging_utils.dart';
import 'package:practice_app/components/spacing.dart';
import 'package:practice_app/models/user.dart';
import 'package:practice_app/pages/dashboard/dashboard.dart';
import 'package:practice_app/pages/sign_up/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../themes/style.dart';

Logger logger = Logger("pages:sign_in.dart");

class SignInPage extends StatefulWidget {
   bool hasError = false;
  SignInPage({Key? key}) : super(key: key);
 
  @override
  State<SignInPage> createState() => _SignInPageState();

}

class _SignInPageState extends State<SignInPage> {
  final emailTextFieldController = TextEditingController();
  final passwordTextFieldController = TextEditingController();
  Timer? _timer;
  
  @override
  void dispose(){
    _timer?.cancel();
     super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "Sign In",
                  style: TitleText(),
                ),
              ),

              vSpacing20,

              Visibility(
                  visible: widget.hasError,
                  child: Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Row(children: [
                    hSpacing10,
                    const Icon(Icons.error, color: Colors.red),
                    hSpacing10,
                    const Text("Invalid username or password", style: TextStyle(fontFamily: "Montserrat",color: Colors.red)),
                    ],),
                  )
                  ),
            vSpacing20,
              TextFormField(
                  controller: emailTextFieldController,
                  decoration: const PrimaryTextFieldDecoration(labelText: "Email")
                  
                  ),
        
              vSpacing12,
              TextFormField(
                  obscureText: true,
                  controller: passwordTextFieldController,
                  decoration: const PrimaryTextFieldDecoration(labelText: "Password")),
             vSpacing12,
              Center(
                
                child:
                
                Column(children: [
                SizedBox(
                   width: double.infinity,
                   height: 50,
                    child: TextButton(
                        onPressed: _signIn,
                        style: PrimaryButtonStyle().init(),
                        child: const Text(
                          "Sign In",
                          style: PrimaryButtonTextStyle(),
                        ))
                        ),
                        vSpacing12,
                         SizedBox(
                   width: double.infinity,
                   height: 50,
                    child: TextButton(
                        onPressed: _redirectToSignUpPage,
                        style: SecondaryButtonStyle().init(),
                        child: const Text(
                          "Register",
                          style: PrimaryButtonTextStyle(),
                        ))
                        ),
                ],)
                
              )
            ],
          ),
        ));
  }

  onPressedSignIn() {
    _signIn();
  }
_redirectToSignUpPage (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage()));
    
}
  _signIn() async {
    final response = await User(
            email: emailTextFieldController.text,
            password: passwordTextFieldController.text)
        .login();
    if (response.statusCode == 200) {
      String cookies = response.headers['set-cookie'] ?? " ";
      String token = response.headers['access-token'] ?? " ";
      String userId = response.headers['user-id'] ?? " ";
      Future<SharedPreferences> prefs = SharedPreferences.getInstance();
      final sp = await prefs;
      sp.setString("token", token);
      sp.setString("cookies", cookies);
      sp.setInt("userId", int.parse(userId));
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
          ModalRoute.withName('/login'));
    }
    else{
      setState(() {
        widget.hasError = true;
      });
     _timer = Timer(const Duration(seconds: 3),(){
         setState(() {
        widget.hasError = false;
      });
      } );
    }
    logger.info(response.body);
  }
}
