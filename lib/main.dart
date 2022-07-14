import 'package:flutter/material.dart';
import 'package:practice_app/common/globals.dart';
import 'package:practice_app/pages/entry.dart';
import 'package:practice_app/pages/sign_in/sign_in.dart';
import 'package:practice_app/pages/sign_up/sign_up.dart';
import 'package:practice_app/pages/task/task_create.dart';
import 'package:practice_app/providers/repositories_provider.dart';
import 'package:practice_app/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'pages/dashboard/dashboard.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  start();
}
start() async {  
  await Storage.init();
 runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(providers:[
      ChangeNotifierProvider(create: (context) => TaskProvider()),
      Provider(create: (context)=>RepositoryProvider())
    ],
    child:MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomSheetTheme:  BottomSheetThemeData(
          backgroundColor: Colors.black54.withOpacity(0.1),
        )
      ),
      initialRoute: '/',
      
      routes:{
        '/': (context)=> const Entry(),
        '/login':(context)=> SignInPage(),
        '/register':(context)=> SignUpPage(),
        '/dashboard': (context)=> const DashboardPage(),
         '/task/create': (context)=> const CreateTaskPage()
      }
    )
    );
  }
}
