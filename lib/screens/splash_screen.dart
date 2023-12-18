import 'dart:async';


import 'package:festum_app/login_screen.dart';
import 'package:festum_app/screens/check_screen.dart';
import 'package:festum_app/screens/event_reg_screen.dart';
import 'package:festum_app/screens/event_screen.dart';
import 'package:festum_app/screens/home_screen.dart';
import 'package:festum_app/screens/hoodie_screen.dart';
import 'package:festum_app/screens/main_home.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startTime();
  }
  startTime() async {
    var _duration = new Duration(milliseconds: 1700);
    return new Timer(_duration, navigationPage);
  }

  int lType=-1;
 getStat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {

      if(prefs.getInt('lType')==null){
        lType=0;
      }
      else{
        lType = prefs.getInt('lType')!;

      }
      print(lType);
    });
  }

  

  @override
  Widget build(BuildContext context) {
    getStat();
    return SafeArea(
      child: Scaffold(

        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(image: AssetImage('images/logosplash.png')),

                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text(
                         "Festum",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0),
                        )
                      ],
                    ),
                  ),
                ),



                Center(child: Text("Powered by Saola Innovations Pvt. Limited", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16,
                    fontStyle: FontStyle.normal))),
                SizedBox(height: 10,)
              ],
            )
          ],
        ),

      ),
    );

  }


  void navigationPage() {
    // FirebaseAuth.instance.signOut();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user != null ) {
        if(lType == 1){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainHome()));
        }
        else if(lType ==2){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => EventScreen()));
        }
        else if(lType ==3){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HoodieScreen()));
        } else if(lType ==4){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => EventRegistration()));
        }


        // Navigator.pushNamed(context, '/LoginScreen');

      }
      else{
        // Navigator.of(context).pushReplacementNamed('/LoginScreen');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));

      }
    });


  }
}
