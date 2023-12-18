import 'dart:math';

import 'package:festum_app/app_colors.dart';
import 'package:festum_app/app_icons.dart';
import 'package:festum_app/app_styles.dart';
import 'package:festum_app/login_screen.dart';
import 'package:festum_app/responsive_widget.dart';
import 'package:festum_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:festum_app/app_styles.dart';
import 'package:gsheets/gsheets.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RegisterIoT extends StatefulWidget {
  const RegisterIoT({super.key});

  @override
  State<RegisterIoT> createState() => _RegisterIoTState();
}

class _RegisterIoTState extends State<RegisterIoT> {



  List ids=[];
  List foundLis=[];
  int memFound =0;
  String leadNo = "";
  var domains = ["Select","Hardware","Software"];
  var teamSiz = ["Select","3 - Members","4 - Members"];
  String domain = "Select";
  String teamT = "Select";

  initS() async {

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
          // print(user);
          if(user == null){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
return;
          }

    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();


    leadNo = prefs.getString("rollNumber").toString().toUpperCase();



    const cred= r'''
    {
  "type": "service_account",
  "project_id": "sintillashunz",
  "private_key_id": "fa4052e782b18b660af8420811cd2a42167f6796",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCkBULMBq4fEyA7\nWdYNKQq+aZlRWVS4ZxXVRDZ2rZyBCjlanhyA+tc6BAn8qd6HNZ6Aq1oQQKlGbRG6\nrAmjDN3zmlxbKY/QLGTTMaS71yNcF6GE8EbWz6MRSY171Wp6RoJsSfGHka0sch9h\nh+XtBh280J3qeRrYfxZKVP9vayrLgIdALrNk8rZV3aUt34HYyJux6uUpCsUtzgY/\nyE2ExUS/38NLDi7tRPhkUda8dfI6WjHiJ/roGIS/zRGR5d5XUgjzZtBMuWEPQoTu\n36XhmaBiDCWH+6vHPV6bqrGkwSeDU1zyTONRxTwioIGvnu1qEdjzuRZIbhC+0L+/\nJgCnKjxtAgMBAAECggEABavQ5XENsDFfGe4/QnE6196a2H84OLAHxzn2kB/sm2GZ\nHhL9dVA3BOCC3+OXuCEYe+Zw1MMHl1HKHSQ5qROW0QdzTguf11jRm6PJyFzl8hc3\nFHuiV2cSglSCuddlORkbBVeBLGjTDghcIWkrgAiIGrEz5JmPXhD22lcaBeY0spiO\n3i0r3yUf4XLdQ8hqMu2ozOm7Yf5tf4wtEYP+52YJhuQMj07YUWnJCHPJ8Ne9IFhk\nfgvRegv9YFSZUfB2WLK/iOlRClDh9QunRA0XRO4jDpJUimUAD+K9280agvMj0GBB\naFl9dDlUWp5z6uJcGTnUjAuzbm/lnWMix7ItNJMcAQKBgQDdYoeikCmMmxN1HRSC\n23YiT12BUkA5yky9wGK+uNxmISAzdq7ScCKrcKqVyc8owADU/REiCg5ITSKjNcFN\nWIj0nnwxXL8sF2WtVOMcbtGkM+WiTPP7lu3DI61Pm76Tg43nEGsOiR9hKH0V6ixR\ncE3OwYKp7j+ysU/llwGklWmJ7QKBgQC9qpVvsaaz8hAmuoRGsIP80pARZhBriF8Y\nZ8cey1n3JMipbzb1bU5PaQ3KQN2yMhmM+PAJsAG3Ghi7zLCfUyqpuOpmfeHGCRQq\nGzBbIGCAgZhD4g7d9MuunO/KauKiEAgjy2lsM6i6OGi6BkOAOxKyFxIaxOejudFF\nY3VfmYMsgQKBgQDVl4CBSVGtBNmK/pmRfyfFBomSgcbReur7kCg1FqoeJwuoW3Nk\nOShZ/AO5LNIf4M9srxTeoJETFMi8atqrQyYvzNDJ10/ivFgvGV1dS1YcdK2zH0eu\njvmqcjt+OSdvr1czfdWsWoPZ+3RjtmE32YBYYL8uMF1ojEYnnr/JCRagKQKBgHso\nlbjdpt4aRRqg6tvsKwi0whBKMkdhWj7CxK3eZiDxpctACHP98mfmU6oNzOe1WJoN\n2/Cuda6sJ3trQxVyL7Xd+XdsLnsl0g41cYT61S8c9/68f+Lo3ooYJi1OkrOhrWdw\n4pf8Q4gIsRh6kMJnmZBDIuJ3EeNi+d0Q5FqbmG4BAoGAemDsrqkX9iEFe8VHOSEr\n6FCUn/bcLMEdo1HrybF6gtahpNsnMif+c04AkX3QJlLsCpLb6BfopV+Ry1yJCTj7\nBJMHujZ4KApnEDLs/jlCIFlPbxaNxk4NQUCfG2QQuiYY5+3JJh2AYm8pijgfDMiw\nXB9MzvtlrEFqiHAnhGCSLPM=\n-----END PRIVATE KEY-----\n",
  "client_email": "sintillashunz@sintillashunz.iam.gserviceaccount.com",
  "client_id": "114369371662251435396",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sintillashunz%40sintillashunz.iam.gserviceaccount.com"
}
    ''';


    const sId = '1Dki7olZVx_iUNNffPUJwRCn3-Yz4EMQ_K_R1BBKuDU8';

    final gSheet = GSheets(cred);

    final ss  = await gSheet.spreadsheet(sId);
    var sheet = ss.worksheetByTitle("Sheet1");


    // print(sheet?.values.insertValue("value", column: 1, row: 3));
    await sheet?.values.column(4,fromRow: 2,length: 500).then((value) =>

    ids = value,

    );


  }

  TextEditingController teamNameController = TextEditingController();
  TextEditingController psController = TextEditingController();
  TextEditingController m1Controller = TextEditingController();
  TextEditingController m2Controller = TextEditingController();
  TextEditingController m3Controller = TextEditingController();


  findEl(String a,List b){
    for(int i=0;i<b.length;i++){
      if(b[i].toString().toUpperCase()==a.toUpperCase()){
        return 1;
      }
      else{
        return 0;
      }
    }

  }

  registerTeam() async {
    initS();


    const cred= r'''
    {
  "type": "service_account",
  "project_id": "sintillashunz",
  "private_key_id": "fa4052e782b18b660af8420811cd2a42167f6796",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCkBULMBq4fEyA7\nWdYNKQq+aZlRWVS4ZxXVRDZ2rZyBCjlanhyA+tc6BAn8qd6HNZ6Aq1oQQKlGbRG6\nrAmjDN3zmlxbKY/QLGTTMaS71yNcF6GE8EbWz6MRSY171Wp6RoJsSfGHka0sch9h\nh+XtBh280J3qeRrYfxZKVP9vayrLgIdALrNk8rZV3aUt34HYyJux6uUpCsUtzgY/\nyE2ExUS/38NLDi7tRPhkUda8dfI6WjHiJ/roGIS/zRGR5d5XUgjzZtBMuWEPQoTu\n36XhmaBiDCWH+6vHPV6bqrGkwSeDU1zyTONRxTwioIGvnu1qEdjzuRZIbhC+0L+/\nJgCnKjxtAgMBAAECggEABavQ5XENsDFfGe4/QnE6196a2H84OLAHxzn2kB/sm2GZ\nHhL9dVA3BOCC3+OXuCEYe+Zw1MMHl1HKHSQ5qROW0QdzTguf11jRm6PJyFzl8hc3\nFHuiV2cSglSCuddlORkbBVeBLGjTDghcIWkrgAiIGrEz5JmPXhD22lcaBeY0spiO\n3i0r3yUf4XLdQ8hqMu2ozOm7Yf5tf4wtEYP+52YJhuQMj07YUWnJCHPJ8Ne9IFhk\nfgvRegv9YFSZUfB2WLK/iOlRClDh9QunRA0XRO4jDpJUimUAD+K9280agvMj0GBB\naFl9dDlUWp5z6uJcGTnUjAuzbm/lnWMix7ItNJMcAQKBgQDdYoeikCmMmxN1HRSC\n23YiT12BUkA5yky9wGK+uNxmISAzdq7ScCKrcKqVyc8owADU/REiCg5ITSKjNcFN\nWIj0nnwxXL8sF2WtVOMcbtGkM+WiTPP7lu3DI61Pm76Tg43nEGsOiR9hKH0V6ixR\ncE3OwYKp7j+ysU/llwGklWmJ7QKBgQC9qpVvsaaz8hAmuoRGsIP80pARZhBriF8Y\nZ8cey1n3JMipbzb1bU5PaQ3KQN2yMhmM+PAJsAG3Ghi7zLCfUyqpuOpmfeHGCRQq\nGzBbIGCAgZhD4g7d9MuunO/KauKiEAgjy2lsM6i6OGi6BkOAOxKyFxIaxOejudFF\nY3VfmYMsgQKBgQDVl4CBSVGtBNmK/pmRfyfFBomSgcbReur7kCg1FqoeJwuoW3Nk\nOShZ/AO5LNIf4M9srxTeoJETFMi8atqrQyYvzNDJ10/ivFgvGV1dS1YcdK2zH0eu\njvmqcjt+OSdvr1czfdWsWoPZ+3RjtmE32YBYYL8uMF1ojEYnnr/JCRagKQKBgHso\nlbjdpt4aRRqg6tvsKwi0whBKMkdhWj7CxK3eZiDxpctACHP98mfmU6oNzOe1WJoN\n2/Cuda6sJ3trQxVyL7Xd+XdsLnsl0g41cYT61S8c9/68f+Lo3ooYJi1OkrOhrWdw\n4pf8Q4gIsRh6kMJnmZBDIuJ3EeNi+d0Q5FqbmG4BAoGAemDsrqkX9iEFe8VHOSEr\n6FCUn/bcLMEdo1HrybF6gtahpNsnMif+c04AkX3QJlLsCpLb6BfopV+Ry1yJCTj7\nBJMHujZ4KApnEDLs/jlCIFlPbxaNxk4NQUCfG2QQuiYY5+3JJh2AYm8pijgfDMiw\nXB9MzvtlrEFqiHAnhGCSLPM=\n-----END PRIVATE KEY-----\n",
  "client_email": "sintillashunz@sintillashunz.iam.gserviceaccount.com",
  "client_id": "114369371662251435396",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sintillashunz%40sintillashunz.iam.gserviceaccount.com"
}
    ''';


    const sId = '1-FWQ576cPO_57xVi-cuNdEGN-QUbTUSPgu8x5vLDzA0';
    const sId2 = '1SdpD-Xu6lFqbUaMySR1AdFZlJsu_i-jDT_V4276HTpA';

    final gSheet = GSheets(cred);

    final ss  = await gSheet.spreadsheet(sId);
    var sheet = ss.worksheetByTitle("Sheet1");

    final sheetData = await sheet?.values.allRows();

    final ss2  = await gSheet.spreadsheet(sId2);
    var sheet2 = ss2.worksheetByTitle("Sheet1");

    final sheetData2 = await sheet2?.values.allRows();
    // Get the length (number of rows) of the sheet
    // print(sheetData);

    // int lrn = sheetData!.length;
    // await  sheet?.values.insertRow(lrn+1, [FirebaseAuth.instance.currentUser?.email.toString(),passwordController.text.toString(),clgName,rollNum.toUpperCase(),nameNumberController.text.toString(),yearController.text.toString(),branchVal,gender,hosBol, bioController.text.toString(),""]).whenComplete(() => {


    if(teamT == "3 - Members"){
      m3Controller.text = "2000000000";
    }
    if(teamNameController.text.length<3){
      _showMyDialog("Error","Enter Valid Team Name","Ok");
      return;
    }

    if(domain == "Select"){
      _showMyDialog("Error","Select Domain","Ok");
      return;
    }
    if(psController.text.length<10){
      _showMyDialog("Error","Enter Valid Problem Statement","Ok");
      return;
    }

    if(m1Controller.text.length!=10||m2Controller.text.length!=10||m3Controller.text.length!=10 || m1Controller.text.toUpperCase()==m2Controller.text.toUpperCase()||m1Controller.text.toUpperCase()==m3Controller.text.toUpperCase() || m2Controller.text.toUpperCase()==m3Controller.text.toUpperCase()|| leadNo==m3Controller.text.toString().toUpperCase()||leadNo==m2Controller.text.toString().toUpperCase()||leadNo==m1Controller.text.toString().toUpperCase()){
      _showMyDialog("Error","Enter Valid Team Member Roll Numbers","Ok");
      return;

    }
    for(int i=0;i<ids.length;i++){
      if(ids[i].toString().toUpperCase() == m1Controller.text.toString().toUpperCase() ||ids[i].toString().toUpperCase() == m2Controller.text.toString().toUpperCase() ||ids[i].toString().toUpperCase() == m3Controller.text.toString().toUpperCase() ){


        if(  !findEl(ids[i].toString().toUpperCase(),foundLis)){
          foundLis.add(ids[i].toString().toUpperCase());
    }
        memFound=memFound+1;


      }
    }
    if(memFound!=3){
      _showMyDialog("Found"+foundLis.toString(),"Ask All your Team Mates to Sign Up in the Platform","Ok");
      return;

    }


    int lrn = sheetData!.length;
    var rng = Random();

    String teamId = "IS23"+rng.nextInt(9999).toString();
    await  sheet?.values.insertRow(lrn+1, [FirebaseAuth.instance.currentUser?.email.toString(),teamId,teamNameController.text.toString(),"",leadNo,m1Controller.text.toString().toUpperCase(),m2Controller.text.toString().toUpperCase(), m3Controller.text.toString().toUpperCase(),psController.text.toString(),domain,lrn+1]).whenComplete(() => {

    });
    int lrn2 = sheetData2!.length;
    await  sheet2?.values.insertRows(lrn2+1, [[leadNo,lrn+1],[m1Controller.text.toString().toUpperCase(),lrn+1],[m2Controller.text.toString().toUpperCase(),lrn+1],[m3Controller.text.toString().toUpperCase(),lrn+1]]).whenComplete(() => {

    });


    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Team Created Successfully")));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));



  }


  @override
  Widget build(BuildContext context) {
    initS();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: ResponsiveWidget.isSmallScreen(context)?
      AppBar(
        title: Text(
          'IoT Club @VNRVJIET',
          style: ralewayStyle.copyWith(
            fontSize: 28.0,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w800,
          ),
        ),

        backgroundColor: AppColors.mainBlueColor,):null,

      body: SizedBox(
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ResponsiveWidget.isSmallScreen(context) ? const SizedBox() : Expanded(
              child: Container(
                height: height,
                color: AppColors.mainBlueColor,
                child: Center(
                  child: Text(
                    'IoT Club @VNRVJIET',
                    style: ralewayStyle.copyWith(
                      fontSize: 48.0,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: height,
                margin: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context)? height * 0.032 : height * 0.12),
                color: AppColors.backColor,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.1),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Let’s',
                                style: ralewayStyle.copyWith(
                                  fontSize: 25.0,
                                  color: AppColors.blueDarkColor,
                                  fontWeight: FontWeight.normal,
                                )),
                            TextSpan(
                              text: ' Register Your Team 👇',
                              style: ralewayStyle.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.blueDarkColor,
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Text('Disclaimer: Only Team Lead need to Register.',
                        style: ralewayStyle.copyWith(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Text('Enter your Team Details to get Started with\nIoT Sprint 2k23.',
                        style: ralewayStyle.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: height * 0.064),

                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Team Name*',
                          style: ralewayStyle.copyWith(
                            fontSize: 14.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: AppColors.whiteColor,
                        ),
                        child: TextFormField(
                          controller: teamNameController,

                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),


                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.people),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: 'Enter Your Team Name:',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.014),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Domain:*',
                          style: ralewayStyle.copyWith(
                            fontSize: 14.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: DropdownButton(

                          // Initial Value
                          value: domain,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: domains.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              domain = newValue!;

                            });
                          },
                        ),
                      ),

                      SizedBox(height: height * 0.014),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Team Size:*',
                          style: ralewayStyle.copyWith(
                            fontSize: 14.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: DropdownButton(

                          // Initial Value
                          value: teamT,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: teamSiz.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              teamT = newValue!;

                            });
                          },
                        ),
                      ),
                      SizedBox(height: height * 0.014),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Problem Statement (Title) *',
                          style: ralewayStyle.copyWith(
                            fontSize: 14.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: AppColors.whiteColor,
                        ),
                        child: TextFormField(

                          controller: psController,
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),


                          decoration: InputDecoration(
                            border: InputBorder.none,

                            prefixIcon: IconButton(
                              onPressed: (){

                              },
                              icon: Icon(Icons.calendar_today),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: 'Enter PS You have chosen:',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),



                      SizedBox(height: height * 0.014),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Team Member 1*',
                          style: ralewayStyle.copyWith(
                            fontSize: 14.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: AppColors.whiteColor,
                        ),
                        child: TextFormField(

                          controller: m1Controller,

                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),


                          decoration: InputDecoration(
                            border: InputBorder.none,

                            prefixIcon: IconButton(
                              onPressed: (){

                              },
                              icon: Icon(Icons.person),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: 'Unique Number (Mobile or College ID(in Caps))',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.014),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Team Member 2*',
                          style: ralewayStyle.copyWith(
                            fontSize: 14.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: AppColors.whiteColor,
                        ),
                        child: TextFormField(

                          controller: m2Controller,
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),


                          decoration: InputDecoration(
                            border: InputBorder.none,

                            prefixIcon: IconButton(
                              onPressed: (){

                              },
                              icon: Icon(Icons.person),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: 'Unique Number (Mobile or College ID(in Caps))',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.014),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Team Member 3'+(teamT=="3 - Members"?'':"*"),
                          style: ralewayStyle.copyWith(
                            fontSize: 14.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: AppColors.whiteColor,
                        ),
                        child: TextFormField(

                          controller: m3Controller,
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),


                          decoration: InputDecoration(
                            border: InputBorder.none,

                            prefixIcon: IconButton(
                              onPressed: (){

                              },
                              icon: Icon(Icons.person),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: 'Unique Number (Mobile or College ID(in Caps))',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.05),
                      Align(
                        alignment: Alignment.center,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){
                              // logIn();
                              memFound =0;
                              foundLis=[];

                              registerTeam();
                            },
                            borderRadius: BorderRadius.circular(16.0),
                            child: Ink(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 18.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.purple,
                              ),
                              child: Text('Register',
                                style: ralewayStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.whiteColor,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.005),

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

  Future<void> _showMyDialog(String a,String b,String c) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('IoT Club @VNRVJIET',style: ralewayStyle.copyWith(
            fontSize: 18.0,
            color: AppColors.blueDarkColor,
            fontWeight: FontWeight.normal,
          )),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(a,style: ralewayStyle.copyWith(
                  fontSize: 16.0,
                  color: AppColors.blueDarkColor,
                  fontWeight: FontWeight.normal,
                )),
                Text(b,style: ralewayStyle.copyWith(
                  fontSize: 16.0,
                  color: AppColors.blueDarkColor,
                  fontWeight: FontWeight.normal,
                )),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text(c),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}
