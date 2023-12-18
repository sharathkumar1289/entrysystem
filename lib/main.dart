import 'package:festum_app/firebase_options.dart';
import 'package:festum_app/iot_sprint.dart';
import 'package:festum_app/login_screen.dart';
import 'package:festum_app/screens/event_reg_screen.dart';
import 'package:festum_app/screens/hh_event.dart';
import 'package:festum_app/screens/home_screen.dart';
import 'package:festum_app/screens/hoodie_screen.dart';

import 'package:festum_app/screens/splash_screen.dart';
import 'package:festum_app/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';





var routes = <String, WidgetBuilder>{
  "/login": (BuildContext context) => LoginScreen(),

  "/splash": (BuildContext context) => SplashScreen(),
  "/hhevent": (BuildContext context) => HHEvent(),
  // "/signup": (BuildContext context) => SignUpScreen(),
  // "/iotsprint2k23": (BuildContext context) => IoTSprintScreen(),



};

Future main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Festum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home:  SplashScreen() ,

      routes: routes,
    );
  }
}


