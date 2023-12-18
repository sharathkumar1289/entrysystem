
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  List stuDes=[];
  List mailIds=[];
  List regIds=[];
  // List id3=[];
  // List id4=[];



  String mailId="";
  int rowId = -1;
  String sName = "TBU";
  String sRegId = "TBU";
  String sRollNo = "TBU";
  String sPhone = "TBU";
  String sHS = "TBU";
  String sClg = "TBU";
  String sBranch = "TBU";
  String sYear = "TBU";
  String sCourse = "TBU";


  getDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      sRegId = prefs.getString("regId")!;
      sName = prefs.getString("name")!;
      sRollNo = prefs.getString("roll")!;
      sPhone = prefs.getString("phone")!;
      rowId = prefs.getInt("rowId")!;
      mailId = prefs.getString("mailId").toString().toLowerCase() +"@gmail.com";


      sHS = prefs.getString("size")!;
      sClg = prefs.getString("clg")!;
      sCourse = prefs.getString("course")!;
      sBranch = prefs.getString("branch")!;

      sYear = prefs.getString("year")!;




    });
  }


  @override
  Widget build(BuildContext context) {
    getDetails();


    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [

            Container(
              // padding: EdgeInsets.all(2),
              // width: MediaQuery.of(context).size.width>500?MediaQuery.of(context).size.width/2:MediaQuery.of(context).size.width-20,
              // decoration: BoxDecoration(
              //   gradient: RadialGradient(
              //     center: Alignment.center, // Center point of the gradient
              //     radius: 1.3729, // Radius of the gradient, scaled to fit the container
              //     colors: [
              //       Color(0xFF82cfff), // Colors are defined in ARGB hex format
              //       Color(0xFF7cc7f7),
              //       Color(0xFF398ac4),
              //       Color(0xFF215178),
              //       Color(0xFF093256),
              //       Color(0xff31c5a9),
              //     ],
              //
              //     stops: [0.0, 0.034, 0.3491, 0.6105, 0.8054, 0.9118], // Stops for color gradation
              //   ),
              // ),
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     colors: [ Colors.blue,Colors.purple,Colors.blue],
              //   ),
              // ),
              child: Card(
                elevation: 5,

                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(child: detailText('Your Details: ')),
                      detailText('Name: ${sName}'),
                      detailText('Mail: ${mailId}'),
                      detailText('Roll Number: ${sRollNo}'),
                      detailText('Phone: ${sPhone}'),
                      detailText('Hoodie Size: ${sHS}'),
                      detailText('College: ${sClg}'),
                      detailText('Course: ${sCourse}'),
                      detailText('Branch: ${sBranch}'),
                      detailText('Year: ${sYear}'),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}




Widget detailText(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}