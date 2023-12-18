import 'package:carousel_slider/carousel_slider.dart';
import 'package:festum_app/app_colors.dart';
import 'package:festum_app/app_styles.dart';
import 'package:festum_app/auth_service.dart';
import 'package:festum_app/login_screen.dart';
import 'package:festum_app/responsive_widget.dart';
import 'package:festum_app/rollNumberScreen.dart';
import 'package:festum_app/screens/on_board_screen.dart';
import 'package:festum_app/screens/splash_screen.dart';
import 'package:festum_app/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:festum_app/app_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsheets/gsheets.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  // signUp() async {
  //   if(await AuthService().signInWithGoogle() == 1){
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SignUpScreen()));
  //
  //   }
  //   else if(await AuthService().signInWithGoogle() == 2){
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => RollNumberScreen()));
  //
  //   }
  //   else{
  //   // _showMyDialog();
  //   }
  // }

  List stuDes=[];
  List mailIds=[];
  List regIds=[];
  // List id3=[];
  // List id4=[];
  bool hcollect = true;


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
  // String domainS = "TBD";
  // String pSS = "TBD";
  // String teamMemS = "TBD";
  int loadV = -1;
  int loged=-1;


//   checkHoodie() async {
//
//     const cred = r'''
//     {
//   "type": "service_account",
//   "project_id": "sintillashunz",
//   "private_key_id": "fa4052e782b18b660af8420811cd2a42167f6796",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCkBULMBq4fEyA7\nWdYNKQq+aZlRWVS4ZxXVRDZ2rZyBCjlanhyA+tc6BAn8qd6HNZ6Aq1oQQKlGbRG6\nrAmjDN3zmlxbKY/QLGTTMaS71yNcF6GE8EbWz6MRSY171Wp6RoJsSfGHka0sch9h\nh+XtBh280J3qeRrYfxZKVP9vayrLgIdALrNk8rZV3aUt34HYyJux6uUpCsUtzgY/\nyE2ExUS/38NLDi7tRPhkUda8dfI6WjHiJ/roGIS/zRGR5d5XUgjzZtBMuWEPQoTu\n36XhmaBiDCWH+6vHPV6bqrGkwSeDU1zyTONRxTwioIGvnu1qEdjzuRZIbhC+0L+/\nJgCnKjxtAgMBAAECggEABavQ5XENsDFfGe4/QnE6196a2H84OLAHxzn2kB/sm2GZ\nHhL9dVA3BOCC3+OXuCEYe+Zw1MMHl1HKHSQ5qROW0QdzTguf11jRm6PJyFzl8hc3\nFHuiV2cSglSCuddlORkbBVeBLGjTDghcIWkrgAiIGrEz5JmPXhD22lcaBeY0spiO\n3i0r3yUf4XLdQ8hqMu2ozOm7Yf5tf4wtEYP+52YJhuQMj07YUWnJCHPJ8Ne9IFhk\nfgvRegv9YFSZUfB2WLK/iOlRClDh9QunRA0XRO4jDpJUimUAD+K9280agvMj0GBB\naFl9dDlUWp5z6uJcGTnUjAuzbm/lnWMix7ItNJMcAQKBgQDdYoeikCmMmxN1HRSC\n23YiT12BUkA5yky9wGK+uNxmISAzdq7ScCKrcKqVyc8owADU/REiCg5ITSKjNcFN\nWIj0nnwxXL8sF2WtVOMcbtGkM+WiTPP7lu3DI61Pm76Tg43nEGsOiR9hKH0V6ixR\ncE3OwYKp7j+ysU/llwGklWmJ7QKBgQC9qpVvsaaz8hAmuoRGsIP80pARZhBriF8Y\nZ8cey1n3JMipbzb1bU5PaQ3KQN2yMhmM+PAJsAG3Ghi7zLCfUyqpuOpmfeHGCRQq\nGzBbIGCAgZhD4g7d9MuunO/KauKiEAgjy2lsM6i6OGi6BkOAOxKyFxIaxOejudFF\nY3VfmYMsgQKBgQDVl4CBSVGtBNmK/pmRfyfFBomSgcbReur7kCg1FqoeJwuoW3Nk\nOShZ/AO5LNIf4M9srxTeoJETFMi8atqrQyYvzNDJ10/ivFgvGV1dS1YcdK2zH0eu\njvmqcjt+OSdvr1czfdWsWoPZ+3RjtmE32YBYYL8uMF1ojEYnnr/JCRagKQKBgHso\nlbjdpt4aRRqg6tvsKwi0whBKMkdhWj7CxK3eZiDxpctACHP98mfmU6oNzOe1WJoN\n2/Cuda6sJ3trQxVyL7Xd+XdsLnsl0g41cYT61S8c9/68f+Lo3ooYJi1OkrOhrWdw\n4pf8Q4gIsRh6kMJnmZBDIuJ3EeNi+d0Q5FqbmG4BAoGAemDsrqkX9iEFe8VHOSEr\n6FCUn/bcLMEdo1HrybF6gtahpNsnMif+c04AkX3QJlLsCpLb6BfopV+Ry1yJCTj7\nBJMHujZ4KApnEDLs/jlCIFlPbxaNxk4NQUCfG2QQuiYY5+3JJh2AYm8pijgfDMiw\nXB9MzvtlrEFqiHAnhGCSLPM=\n-----END PRIVATE KEY-----\n",
//   "client_email": "sintillashunz@sintillashunz.iam.gserviceaccount.com",
//   "client_id": "114369371662251435396",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sintillashunz%40sintillashunz.iam.gserviceaccount.com"
// }
//     ''';
//
//
//     const sId = '1XN0ui2eBWIV4CLFg4j4CjjsaL7vLsma66S3DpnCHDZY';
//
//
//     final gSheet = GSheets(cred);
//
//
//     final ss = await gSheet.spreadsheet(sId);
//     var sheet = ss.worksheetByTitle("Sheet1");
//
//     await sheet?.values.value(column:11,row:rowId).then((value) => {
//       setState(() {
//         // print("Test"+value.toString());
//         hcollect = (value =='1');
//       }),
//
//     });
//
//   }
  checkReg() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      mailId = prefs.getString("mailId").toString().toLowerCase();
    });




    final gSheet = GSheets(cred);


    final ss = await gSheet.spreadsheet(sId);
    var sheet = ss.worksheetByTitle("Sheet1");
    if (prefs.getString("regId") == null) {
      final sheetData = await sheet?.values.allRows();
//         // print(sheet?.values.insertValue("value", column: 1, row: 3));
      int lrn = sheetData!.length;
      await sheet?.values.column(2, fromRow: 2, length: 3000).then((value) =>

      mailIds = value,

      );
      //
      // await sheet?.values.column(2,fromRow: 2,length: 500).then((value) =>
      //
      //   regIds = value,
      //
      //   );

      for (int i = 0; i < mailIds.length; i++) {
        if (mailId.toString().toLowerCase() ==
            mailIds[i].replaceAll("@vnrvjiet.in", "").replaceAll(
                "@festum.in", "").replaceAll("@gmail.com", "")) {

          await prefs.setInt('rowId',i+2);


          await sheet?.values.row(i+2,fromColumn:1,length:11).then((value) =>
              setState(() {
                stuDes = value;
              }),

          );
          await prefs.setString('regId',stuDes[0]);
          await prefs.setString('roll',stuDes[3]);
          await prefs.setString('name',stuDes[2]);
          await prefs.setString('phone',stuDes[4]);
          await prefs.setString('size',stuDes[5]);
          await prefs.setString('clg',stuDes[6]);
          await prefs.setString('course',stuDes[7]);
          await prefs.setString('branch',stuDes[8]);
          await prefs.setString('year',stuDes[9]);

          setState(() {
            sRegId = stuDes[1];
            sName = stuDes[3];
            sRollNo = stuDes[4];
            sPhone = stuDes[5];

            sHS = stuDes[6];
            sClg = stuDes[7];
            sCourse = stuDes[8];
            sBranch = stuDes[9];

            sYear = stuDes[10];




          });

        }
      }
    }

    setState(() {
      sRegId = prefs.getString("regId")!;
      sName = prefs.getString("name")!;
      sRollNo = prefs.getString("roll")!;
      sPhone = prefs.getString("phone")!;
      rowId = prefs.getInt("rowId")!;

      sHS = prefs.getString("size")!;
      sClg = prefs.getString("clg")!;
      sCourse = prefs.getString("course")!;
      sBranch = prefs.getString("branch")!;

      sYear = prefs.getString("year")!;




    });

    // checkHoodie();
  }
//   checkReg() async {
//
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     // FirebaseAuth.instance
//     //     .authStateChanges()
//     //     .listen((User? user) async {
//       // print(user);
//       if(prefs.getInt('lType')==1){
//         setState(() {
//           loged=1;
//         });
//
//         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
//         final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//         setState(() {
//           mailId = prefs.getString("mailId").toString().toUpperCase();
//           // reF = prefs.getString("RegId")!= null;
//           // print(reF);
//
//         });
//
//         const cred= r'''
//     {
//   "type": "service_account",
//   "project_id": "sintillashunz",
//   "private_key_id": "fa4052e782b18b660af8420811cd2a42167f6796",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCkBULMBq4fEyA7\nWdYNKQq+aZlRWVS4ZxXVRDZ2rZyBCjlanhyA+tc6BAn8qd6HNZ6Aq1oQQKlGbRG6\nrAmjDN3zmlxbKY/QLGTTMaS71yNcF6GE8EbWz6MRSY171Wp6RoJsSfGHka0sch9h\nh+XtBh280J3qeRrYfxZKVP9vayrLgIdALrNk8rZV3aUt34HYyJux6uUpCsUtzgY/\nyE2ExUS/38NLDi7tRPhkUda8dfI6WjHiJ/roGIS/zRGR5d5XUgjzZtBMuWEPQoTu\n36XhmaBiDCWH+6vHPV6bqrGkwSeDU1zyTONRxTwioIGvnu1qEdjzuRZIbhC+0L+/\nJgCnKjxtAgMBAAECggEABavQ5XENsDFfGe4/QnE6196a2H84OLAHxzn2kB/sm2GZ\nHhL9dVA3BOCC3+OXuCEYe+Zw1MMHl1HKHSQ5qROW0QdzTguf11jRm6PJyFzl8hc3\nFHuiV2cSglSCuddlORkbBVeBLGjTDghcIWkrgAiIGrEz5JmPXhD22lcaBeY0spiO\n3i0r3yUf4XLdQ8hqMu2ozOm7Yf5tf4wtEYP+52YJhuQMj07YUWnJCHPJ8Ne9IFhk\nfgvRegv9YFSZUfB2WLK/iOlRClDh9QunRA0XRO4jDpJUimUAD+K9280agvMj0GBB\naFl9dDlUWp5z6uJcGTnUjAuzbm/lnWMix7ItNJMcAQKBgQDdYoeikCmMmxN1HRSC\n23YiT12BUkA5yky9wGK+uNxmISAzdq7ScCKrcKqVyc8owADU/REiCg5ITSKjNcFN\nWIj0nnwxXL8sF2WtVOMcbtGkM+WiTPP7lu3DI61Pm76Tg43nEGsOiR9hKH0V6ixR\ncE3OwYKp7j+ysU/llwGklWmJ7QKBgQC9qpVvsaaz8hAmuoRGsIP80pARZhBriF8Y\nZ8cey1n3JMipbzb1bU5PaQ3KQN2yMhmM+PAJsAG3Ghi7zLCfUyqpuOpmfeHGCRQq\nGzBbIGCAgZhD4g7d9MuunO/KauKiEAgjy2lsM6i6OGi6BkOAOxKyFxIaxOejudFF\nY3VfmYMsgQKBgQDVl4CBSVGtBNmK/pmRfyfFBomSgcbReur7kCg1FqoeJwuoW3Nk\nOShZ/AO5LNIf4M9srxTeoJETFMi8atqrQyYvzNDJ10/ivFgvGV1dS1YcdK2zH0eu\njvmqcjt+OSdvr1czfdWsWoPZ+3RjtmE32YBYYL8uMF1ojEYnnr/JCRagKQKBgHso\nlbjdpt4aRRqg6tvsKwi0whBKMkdhWj7CxK3eZiDxpctACHP98mfmU6oNzOe1WJoN\n2/Cuda6sJ3trQxVyL7Xd+XdsLnsl0g41cYT61S8c9/68f+Lo3ooYJi1OkrOhrWdw\n4pf8Q4gIsRh6kMJnmZBDIuJ3EeNi+d0Q5FqbmG4BAoGAemDsrqkX9iEFe8VHOSEr\n6FCUn/bcLMEdo1HrybF6gtahpNsnMif+c04AkX3QJlLsCpLb6BfopV+Ry1yJCTj7\nBJMHujZ4KApnEDLs/jlCIFlPbxaNxk4NQUCfG2QQuiYY5+3JJh2AYm8pijgfDMiw\nXB9MzvtlrEFqiHAnhGCSLPM=\n-----END PRIVATE KEY-----\n",
//   "client_email": "sintillashunz@sintillashunz.iam.gserviceaccount.com",
//   "client_id": "114369371662251435396",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sintillashunz%40sintillashunz.iam.gserviceaccount.com"
// }
//     ''';
//
//
//         const sId = '1SdpD-Xu6lFqbUaMySR1AdFZlJsu_i-jDT_V4276HTpA';
//         const sId2 = '1-FWQ576cPO_57xVi-cuNdEGN-QUbTUSPgu8x5vLDzA0';
//
//         final gSheet = GSheets(cred);
//
//         final ss  = await gSheet.spreadsheet(sId);
//         var sheet = ss.worksheetByTitle("Sheet1");
//
//         final sheetData = await sheet?.values.allRows();
//         // print(sheet?.values.insertValue("value", column: 1, row: 3));
//         int lrn = sheetData!.length;
//         await sheet?.values.column(1,fromRow: 2,length: 500).then((value) =>
//
//         id1 = value,
//
//         );
//
//         await sheet?.values.column(2,fromRow: 2,length: 500).then((value) =>
//
//         id2 = value,
//
//         );
//         print(id1);
//         final ss2  = await gSheet.spreadsheet(sId2);
//         var sheet2 = ss2.worksheetByTitle("Sheet1");
//
//
//         // await sheet?.values.column(12,fromRow: 2,length: 500).then((value) =>
//         //
//         // id2 = value,
//         //
//         // );
//
//
//
//
//
//         print(id1);
//         print(id2);
//         print(rollNum);
//
//
//
//
//           for(int i=0;i<id1.length;i++){
//
//             if(id1[i].toString().toUpperCase() == rollNum.replaceAll("@VNRVJIET.IN", "").replaceAll("@festum.in", "")){
//
//               final SharedPreferences prefs = await SharedPreferences.getInstance();
//               prefs.setString("RegID", id2[i]);
//               setState(() {
//                 teamS = int.parse(id2[i]);
//                 isLead = true;
//               });
//
//               print(teamS);
//               break;
//
//
//
//
//
//
//             }
//           }
//
//
//
//           print(rollNum);
//
//         if(teamS !=-1){
//
//           await sheet2?.values.row(int.parse(teamS.toString()),fromColumn:1,length:11).then((value) =>
//               setState(() {
//                 teamDes = value;
//               }),
//
//
//
//           );
//
//
//           print(teamDes);
//
//           setState(()  {
//             teamNameS = "Team Name: " +teamDes[2];
//             pSS = "PS: " +teamDes[8];
//             domainS = "Domain: " +teamDes[9];
//             teamMemS = "Members: "+teamDes[4].toString()+" , "+teamDes[5].toString()+" , "+teamDes[6].toString()+" , "+teamDes[7].toString();
//
//
//           });
//
//
//           final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//           await prefs.setString("RegId", teamS.toString());
//
//         }
//       }
//
//    // });
//     print(teamS);
//   }


  final List<String> imgL = [
  //  'https://res.cloudinary.com/dxr8nm7g8/image/upload/v1697290301/Screenshot_2023-10-14_at_7.01.29_PM_vsqs6m.png',
  // 'https://res.cloudinary.com/dxr8nm7g8/image/upload/v1697290301/Screenshot_2023-10-14_at_7.01.29_PM_vsqs6m.png',
  //   'https://res.cloudinary.com/dxr8nm7g8/image/upload/v1697290301/Screenshot_2023-10-14_at_7.01.29_PM_vsqs6m.png',
    'https://res.cloudinary.com/dxr8nm7g8/image/upload/v1701536189/WhatsApp_Image_2023-12-02_at_12.26.14_PM_bxl3wy.jpg',
    'https://res.cloudinary.com/dxr8nm7g8/image/upload/v1702462727/IMG-20231210-WA0000_mkt28o.jpg',
    'https://res.cloudinary.com/dxr8nm7g8/image/upload/v1701536189/WhatsApp_Image_2023-12-01_at_1.55.34_PM_ypcyfn.jpg',
    'https://res.cloudinary.com/dxr8nm7g8/image/upload/v1701584663/Copy_of_CONVERGENCE_t9ip30.png',
    'https://res.cloudinary.com/dxr8nm7g8/image/upload/v1702462882/Software_Hackathon_llnnjr.png',
    'https://res.cloudinary.com/dxr8nm7g8/image/upload/v1702463114/Copy_of_Auto_Expo_loyypx.png',



  ];


  List<Widget> imageLis(){
    return  imgL.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(

            //  width: MediaQuery.of(context).size.width<400?MediaQuery.of(context).size.width:400,

            margin: EdgeInsets.symmetric(horizontal: 5.0),

            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1.0),
            ),
            child: Container(
              // alignment: Alignment.center,
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(


                    children: <Widget>[
                      Center(child: Image.network(i, fit: BoxFit.fill,width: 1000,)),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'Convergence 2023R',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        },
      );
    }).toList();


  }

  @override
  Widget build(BuildContext context) {
    if(loadV ==-1){
      checkReg();
      setState(() {
        loadV=1;
      });

    }


    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: Footer(),
        // appBar: ResponsiveWidget.isSmallScreen(context)?
        // AppBar(
        //   title: Text(
        //     'Festum',
        //     style: ralewayStyle.copyWith(
        //       fontSize: 28.0,
        //       color: AppColors.whiteColor,
        //       fontWeight: FontWeight.w800,
        //     ),
        //   ),
        //
        //   backgroundColor: AppColors.mainBlueColor,):null,
        body: Container(
          height: MediaQuery.of(context).size.height,

          padding: EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Column(

              children: [

                CarouselSlider(

                    options: CarouselOptions(
                      aspectRatio: 16/7,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      // autoPlayCurve: Curves.fastOutSlowIn,
                      //enlargeFactor: 0.3,
                      // onPageChanged: callbackFunction,
                      //   scrollDirection: Axis.horizontal,
                    ),
                    items:  imageLis()


                ),
                // AspectRatio(aspectRatio: 18/8,
                //
                //
                // ),


        //////////////////// ////////////////////


                ////////////////////

                //
                // Visibility(
                //   visible: teamS !=-1,
                //   child: Card(
                //     shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4),),
                //     color: MyColorsSample.primaryDark,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: <Widget>[
                //         Container(
                //           padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: <Widget>[
                //                Text("You are Successfully Registered For IoT Sprint 2k23", style: ralewayStyle.copyWith(
                //                 fontSize: 18.0,
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.w700,
                //               ),
                //               ),
                //               Container(height: 10),
                //               Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Text(teamNameS, style: ralewayStyle.copyWith(
                //                   fontSize: 13.0,
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.w700,
                //                 ),),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Text(domainS, style: ralewayStyle.copyWith(
                //                   fontSize: 13.0,
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.w700,
                //                 ),),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Text(pSS, style: ralewayStyle.copyWith(
                //                   fontSize: 13.0,
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.w700,
                //                 ),),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Text(teamMemS, style: ralewayStyle.copyWith(
                //                   fontSize: 13.0,
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.w700,
                //                 ),),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Visibility(
                //             visible: isLead,
                //             child: Align(
                //               alignment: Alignment.center,
                //               child: Material(
                //                 color: Colors.transparent,
                //                 child: InkWell(
                //                   onTap: () async {
                //                     // js.context.callMethod('open', ['https://chat.whatsapp.com/EKuBHTU2xCuDfIvGglTxOm']);
                //
                //                     // final Uri url = Uri.parse('https://chat.whatsapp.com/EKuBHTU2xCuDfIvGglTxOm');
                //                     // if (!await launchUrl(url,mode: LaunchMode.externalApplication,)) {
                //                     //   throw Exception('Could not launch $_url');
                //                     // }
                //                     if(loged==1){
                //                       // FirebaseAuth.instance.signOut();
                //                       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
                //
                //                     }
                //                     else{
                //                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                //
                //                     }
                //
                //                   },
                //                   borderRadius: BorderRadius.circular(2.0),
                //                   child: Ink(
                //                     padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(4.0),
                //                       color: Colors.white,
                //                     ),
                //                     child: Text(loged==1?'Join WhatsApp Group':"Log In",
                //                       style: ralewayStyle.copyWith(
                //                         fontWeight: FontWeight.w900,
                //                         color: Colors.black,
                //                         fontSize: 16.0,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //
                //       ],
                //     ),
                //   ),
                // ),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width-20,
                //     decoration: BoxDecoration(
                //       // color: Color(0XAEB0F6FF)
                //     ),
                //     child: Column(
                //       children: [
                //
                //         Row(
                //           children: <Widget>[
                //             Expanded(
                //               flex: 1,
                //               child: Card(
                //                 color: Colors.blue,
                //                 elevation: 2,
                //                 shape: const RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.all(Radius.circular(16)),
                //                 ),
                //                 child: InkWell(
                //                   borderRadius: const BorderRadius.all(Radius.circular(16)),
                //                   onTap: () {},
                //                   child: Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: <Widget>[
                //                       Padding(
                //                         padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                //                         child: Column(
                //                           children: [
                //                             Text("IoT Sprint 2k23 by IoT Club @VNRVJIET",
                //                               maxLines: 2,
                //                               style: ralewayStyle.copyWith(
                //                                 fontSize: 13.0,
                //                                 color: AppColors.whiteColor,
                //                                 fontWeight: FontWeight.w800,
                //                               ),
                //                               overflow: TextOverflow.ellipsis,
                //                             ),
                //                             Text("",
                //                               maxLines: 2,
                //                               style: ralewayStyle.copyWith(
                //                                 fontSize: 13.0,
                //                                 color: AppColors.whiteColor,
                //                                 fontWeight: FontWeight.w800,
                //                               ),
                //                               overflow: TextOverflow.ellipsis,
                //                             ),
                //                             Visibility(
                //                               visible: teamS ==-1 && !reF,
                //                               child: Align(
                //                                 alignment: Alignment.center,
                //                                 child: Material(
                //                                   color: Colors.transparent,
                //                                   child: InkWell(
                //                                     onTap: (){
                //                                       // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OnBoardScreen()));
                //
                //                                       // js.context.callMethod('open', ['https://forms.gle/2NovrLBdPWHJXy169']);
                //
                //                                     },
                //                                     borderRadius: BorderRadius.circular(2.0),
                //                                     child: Ink(
                //                                       padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                //                                       decoration: BoxDecoration(
                //                                         borderRadius: BorderRadius.circular(4.0),
                //                                         color: Colors.black,
                //                                       ),
                //                                       child: Text('Register As Team',
                //                                         style: ralewayStyle.copyWith(
                //                                           fontWeight: FontWeight.w900,
                //                                           color: Colors.white,
                //                                           fontSize: 16.0,
                //                                         ),
                //                                       ),
                //                                     ),
                //                                   ),
                //                                 ),
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                       const Divider(),
                //                       Padding(
                //                         padding: const EdgeInsets.all(8.0),
                //                         child: Column(
                //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                           children:  <Widget>[
                //                             Center(
                //                               child: Column(
                //                                 children: [
                //                                   Text(
                //                                     '19th Oct, 2023',
                //                                     style: ralewayStyle.copyWith(
                //                                       fontSize: 13.0,
                //                                       color: AppColors.whiteColor,
                //                                       fontWeight: FontWeight.w800,
                //                                     ),
                //                                     maxLines: 2,
                //                                     overflow: TextOverflow.ellipsis,
                //
                //
                //
                //                                   ),
                //                                 ],
                //                               ),
                //                             ),
                //                             // Icon(Icons.date_range),//, color: appStore.iconColor
                //                           ],
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //
                //
                //             ),
                //             Container(width: 2),
                //             // Expanded(
                //             //   flex: 1,
                //             //   child: Card(
                //             //     color: Colors.deepPurpleAccent,
                //             //     elevation: 2,
                //             //     shape: const RoundedRectangleBorder(
                //             //       borderRadius: BorderRadius.all(Radius.circular(16)),
                //             //     ),
                //             //     child: InkWell(
                //             //       borderRadius: const BorderRadius.all(Radius.circular(16)),
                //             //       onTap: () {},
                //             //       child: Column(
                //             //         crossAxisAlignment: CrossAxisAlignment.start,
                //             //         children: <Widget>[
                //             //           Padding(
                //             //             padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                //             //             child: Column(
                //             //               children: [
                //             //                 Text("Tech Session by IoT Club and ISTE",
                //             //                   maxLines: 2,
                //             //                   style: ralewayStyle.copyWith(
                //             //                     fontSize: 13.0,
                //             //                     color: AppColors.whiteColor,
                //             //                     fontWeight: FontWeight.w800,
                //             //                   ),
                //             //                   overflow: TextOverflow.ellipsis,
                //             //
                //             //                 ),
                //             //                 Text("Opens Soon..!",
                //             //                   maxLines: 2,
                //             //                   style: ralewayStyle.copyWith(
                //             //                     fontSize: 13.0,
                //             //                     color: AppColors.whiteColor,
                //             //                     fontWeight: FontWeight.w800,
                //             //                   ),
                //             //                   overflow: TextOverflow.ellipsis,
                //             //
                //             //                 ),
                //             //               ],
                //             //             ),
                //             //           ),
                //             //           const Divider(),
                //             //           Padding(
                //             //             padding:  EdgeInsets.all(8.0),
                //             //             child: Column(
                //             //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             //               children:  <Widget>[
                //             //                 Text(
                //             //                   '17, Oct 2023',//style: secondaryTextStyle(color: appStore.textSecondaryColor),
                //             //                   style: ralewayStyle.copyWith(
                //             //                     fontSize: 13.0,
                //             //                     color: AppColors.whiteColor,
                //             //                     fontWeight: FontWeight.w800,
                //             //                   ),
                //             //                 ),
                //             //                 // Icon(Icons.date_range),//, color: appStore.iconColor
                //             //               ],
                //             //             ),
                //             //           )
                //             //         ],
                //             //       ),
                //             //     ),
                //             //   ),
                //             //
                //             //
                //             // ),
                //           ],
                //         ),
                //         Container(height: 5),
                //
                //         // //////////////////// ////////////////////
                //
                //         //
                //         //         Card(
                //         //           shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8),),
                //         //           clipBehavior: Clip.antiAliasWithSaveLayer,
                //         //           child: Column(
                //         //             crossAxisAlignment: CrossAxisAlignment.start,
                //         //             children: <Widget>[
                //         //               // Image.asset(ImgSample.get('relaxing-man.png'),
                //         //               //   height: 160, width: double.infinity, fit: BoxFit.cover,
                //         //               // ),
                //         //               Container(
                //         //                 padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                //         //                 child: Column(
                //         //                   crossAxisAlignment: CrossAxisAlignment.start,
                //         //                   children: <Widget>[
                //         //                     Text("Cards Title 2", style: TextStyle(
                //         //                         fontSize: 24,
                //         //                         color: Colors.grey[800]
                //         //                     ),),
                //         //                     Container(height: 10),
                //         //                     Text("card_text", style: TextStyle(
                //         //                         fontSize: 15, color: Colors.grey[700]
                //         //                     )),
                //         //
                //         //                     Row(
                //         //                       children: <Widget>[
                //         //                         const Spacer(),
                //         //                         TextButton(
                //         //                           style: TextButton.styleFrom(foregroundColor: Colors.transparent),
                //         //                           child: const Text("SHARE",
                //         //                             style: TextStyle(color: MyColorsSample.accent),
                //         //                           ),
                //         //                           onPressed: (){},
                //         //                         ),
                //         //                         TextButton(
                //         //                           style: TextButton.styleFrom(foregroundColor: Colors.transparent),
                //         //                           child: const Text("EXPLORE",
                //         //                             style: TextStyle(color: MyColorsSample.accent),
                //         //                           ),
                //         //                           onPressed: (){},
                //         //                         )
                //         //                       ],
                //         //                     ),
                //         //
                //         //                   ],
                //         //                 ),
                //         //               ),
                //         //
                //         //               Container(height: 5)
                //         //             ],
                //         //           ),
                //         //         ),
                //         //
                //         //
                //         Container(height: 5),
                //
                //       ],
                //     ),
                //   ),
                // ),




                // Visibility(
                //   visible: true,
                //   child: Align(
                //     alignment: Alignment.center,
                //     child: Material(
                //       color: Colors.transparent,
                //       child: InkWell(
                //         onTap: () {
                //
                //           // js.context.callMethod('open', ['https://docs.google.com/document/d/1bnKx8_40znxmltmZgHYaVbu4F0gzHQA0icb7WEgUTuE/edit?usp=sharing']);
                //
                //         //   if(loged==1){
                //         //     FirebaseAuth.instance.signOut();
                //         //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
                //         //
                //         //   }
                //         //   else{
                //         //    signUp();
                //         //
                //         // }
                //
                //         },
                //         borderRadius: BorderRadius.circular(2.0),
                //         child: Ink(
                //           padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(4.0),
                //             color: Colors.purpleAccent,
                //           ),
                //           child: Text("Problem Statements",
                //             style: ralewayStyle.copyWith(
                //               fontWeight: FontWeight.w900,
                //               color: Colors.white,
                //               fontSize: 16.0,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),



                // Container(height: 5),
                //
                //
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       flex: 1,
                //       child: Card(
                //         shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4),),
                //         color: Colors.teal[800],
                //         // color: MyColorsSample.primary,
                //         clipBehavior: Clip.antiAliasWithSaveLayer,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Container(
                //               padding: const EdgeInsets.all(15),
                //               child: const Text("Today Event \nLive", style: TextStyle(
                //                   fontSize: 24,
                //                   color: Colors.white
                //               ),),
                //             ),
                //             const Divider(color: Colors.white, thickness: 0.5, height: 0,),
                //             Row(
                //               children: <Widget>[
                //                 Container(width: 15,),
                //                 const Text("March 19, 2023", style: TextStyle(color: Colors.white),),
                //                 const Spacer(),
                //                 IconButton(
                //                   icon: const Icon(Icons.event, color: Colors.white),
                //                   onPressed: (){},
                //                 ),
                //                 Container(width: 4,),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     Container(width: 2),
                //     Expanded(
                //       flex: 1,
                //       child: Card(
                //         shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4),),
                //         color: MyColorsSample.primary,
                //         clipBehavior: Clip.antiAliasWithSaveLayer,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Row(
                //               children: <Widget>[
                //                 Container(width: 15,),
                //                 const Text("Call", style: TextStyle(color: Colors.white),),
                //                 const Spacer(),
                //                 IconButton(
                //                   icon: const Icon(Icons.call, color: Colors.white),
                //                   onPressed: (){},
                //                 ),
                //                 Container(width: 4,),
                //               ],
                //             ),
                //             Container(
                //               padding: const EdgeInsets.all(15),
                //               child: const Text("John Smith \nTek", style: TextStyle(
                //                   fontSize: 24,
                //                   color: Colors.white
                //               ),),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),






                Container(height: 10),


            // Container(
            //   // padding: EdgeInsets.all(2),
            //   width: MediaQuery.of(context).size.width>500?MediaQuery.of(context).size.width/2:MediaQuery.of(context).size.width-20,
            //   decoration: BoxDecoration(
            //     gradient: RadialGradient(
            //       center: Alignment.center, // Center point of the gradient
            //       radius: 1.3729, // Radius of the gradient, scaled to fit the container
            //       colors: [
            //         Color(0xFF82cfff), // Colors are defined in ARGB hex format
            //         Color(0xFF7cc7f7),
            //         Color(0xFF398ac4),
            //         Color(0xFF215178),
            //         Color(0xFF093256),
            //         Color(0xff31c5a9),
            //       ],
            //
            //       stops: [0.0, 0.034, 0.3491, 0.6105, 0.8054, 0.9118], // Stops for color gradation
            //     ),
            //   ),
            //   // decoration: BoxDecoration(
            //   //   gradient: LinearGradient(
            //   //     begin: Alignment.topLeft,
            //   //     end: Alignment.bottomRight,
            //   //     colors: [ Colors.blue,Colors.purple,Colors.blue],
            //   //   ),
            //   // ),
            //   child: Card(
            //     elevation: 5,
            //
            //     color: Colors.transparent,
            //     child: Padding(
            //       padding: const EdgeInsets.all(20.0),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           Center(child: detailText('Your Details: ')),
            //           detailText('Name: ${sName}'),
            //           detailText('Mail: ${mailId}'),
            //           detailText('Roll Number: ${sRollNo}'),
            //           detailText('Phone: ${sPhone}'),
            //           detailText('Hoodie Size: ${sHS}'),
            //           detailText('College: ${sClg}'),
            //           detailText('Course: ${sCourse}'),
            //           detailText('Branch: ${sBranch}'),
            //           detailText('Year: ${sYear}'),
            //           Center(
            //             child: Visibility(
            //               visible: !hcollect,
            //                 child:Card(
            //                   color: Colors.white,
            //                   elevation: 10,
            //                   child: Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Column(
            //                       children: [
            //                         Text("Collect Your Hoodie by Showing this QR Code"),
            //                         QrImageView(
            //                           data: sRegId,
            //                           version: QrVersions.auto,
            //                           size: ResponsiveWidget.isSmallScreen(context) ? 200:400,
            //                           gapless: true,
            //                           embeddedImage: AssetImage('images/logosplash.png'),
            //                           embeddedImageStyle: QrEmbeddedImageStyle(
            //                             size: Size(40, 40),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 )
            //             ),
            //           ),
            //
            //           Visibility(
            //             visible: hcollect,
            //               child: detailText("You have Successfully collected your Hoodie\nThank You..!")),
            //           // detailText('Hoodie Status: ${hcollect}'),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

                // StuDetailsW(),


                Footer(),

              ],

            ),

          ),


        ),
      ),
    );






  }


}


class ImgSample {
  static String get(String name){
    return 'assets/images/$name';
  }
}

class MyColorsSample {
  static const Color primary = Color(0xFF12376F);
  static const Color primaryDark = Color(0xFF0C44A3);
  static const Color primaryLight = Color(0xFF43A3F3);
  static const Color green = Colors.green;
  static Color black = const Color(0xFF000000);
  static const Color accent = Color(0xFFFF4081);
  static const Color accentDark = Color(0xFFF50057);
  static const Color accentLight = Color(0xFFFF80AB);
  static const Color grey_3 = Color(0xFFf7f7f7);
  static const Color grey_5 = Color(0xFFf2f2f2);
  static const Color grey_10 = Color(0xFFe6e6e6);
  static const Color grey_20 = Color(0xFFcccccc);
  static const Color grey_40 = Color(0xFF999999);
  static const Color grey_60 = Color(0xFF666666);
  static const Color grey_80 = Color(0xFF37474F);
  static const Color grey_90 = Color(0xFF263238);
  static const Color grey_95 = Color(0xFF1a1a1a);
  static const Color grey_100_ = Color(0xFF0d0d0d);
  static const Color transparent = Color(0x00f7f7f7);
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(16.0),

      height: 400,
      // child: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Festum \nYour Gateway to Unforgettable Events\nPowered by Saola Innovations Pvt. Ltd.',
              textAlign: TextAlign.start,


              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
                fontSize: 20


              ),
            ),
          ],
        ),
      // ),
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
