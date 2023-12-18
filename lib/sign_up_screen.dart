import 'package:festum_app/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:festum_app/app_colors.dart';
import 'package:festum_app/app_icons.dart';
import 'package:festum_app/app_styles.dart';
import 'package:festum_app/responsive_widget.dart';
import 'package:gsheets/gsheets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  List ids=[];
  int val = 1;
  var genders = [
  'Select',
  'Male',
  'Female',
  ];
  var branches = [
    'Select',
    'ECE',
    'CSE IoT',
    'CSE (and Allied Branches)',
    'EIE',
    'EEE',
    'Civil',
    'Mechanical',
    'AE',

  ];
  var clgHos = [
    'Select',
    'Yes',
    'No',
  ];
  String gender="Select";
  String hosBol="Select";
  String branchVal="Select";
  bool togP = true;

  setNull() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('lType', -1);
}
  initS() async {

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
    await sheet?.values.column(1,fromRow: 1,length: 500).then((value) =>

    ids = value,

    );
  }

  String rollNum="";
  String clgName="";

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameNumberController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

setRoll() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  setState(() {
    rollNum = prefs.getString("rollNumber").toString().toUpperCase();
    clgName = prefs.getString("clgName").toString();
    if(clgName != "VNR VJIET"){
      hosBol = "No";
    }

  });






  }

  signUp() async {

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


    const sId = '1Dki7olZVx_iUNNffPUJwRCn3-Yz4EMQ_K_R1BBKuDU8';

    final gSheet = GSheets(cred);

    final ss  = await gSheet.spreadsheet(sId);
    var sheet = ss.worksheetByTitle("Sheet1");

    final sheetData = await sheet?.values.allRows();

    // Get the length (number of rows) of the sheet
    print(sheetData);

 for(int i=0;i<ids.length;i++){
   if(ids[i].toString() == rollNum){
     _showMyDialog("Account Exists ","Try to Login","Ok");
     return;
   }
 }

 if(nameNumberController.text.length<3){
   _showMyDialog("Error ","Please Enter Valid Name","Ok");
   return;
 }
 if(bioController.text.length<3){
   _showMyDialog("Error ","Please Enter Valid Bio","Ok");
   return;
 }

    if(phoneController.text.length!=10){
      _showMyDialog("Error ","Please Enter Valid Phone Number","Ok");
      return;
    }

 if(!(yearController.text == "1" || yearController.text == "2" || yearController.text == "3" || yearController.text == "4")){
   _showMyDialog("Error ","Please Enter Valid Year","Ok");
   return;
 }

    if(gender == "Select"){
      _showMyDialog("Error ","Please Select Gender","Ok");
      return;
    }
    if(hosBol == "Select"){
      _showMyDialog("Error ","Please Select College Hostel or Not","Ok");
      return;
    }
 if(passwordController.text.length<8){
   _showMyDialog("Error ","Please Enter Valid Password","Ok");
   return;
 }

    // Get the length (number of rows) of the sheet
    int lrn = sheetData!.length;
 await  sheet?.values.insertRow(lrn+1, [FirebaseAuth.instance.currentUser?.email.toString(),passwordController.text.toString(),clgName,rollNum.toUpperCase(),nameNumberController.text.toString(),yearController.text.toString(),branchVal,gender,hosBol, bioController.text.toString(),phoneController.text.toString()]).whenComplete(() => {

    // done=1,
   FirebaseAuth.instance.createUserWithEmailAndPassword(email: rollNum.toLowerCase()+"@festum.in", password: passwordController.text.toString()).whenComplete(() =>
   {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registered Succesfully"))),
     FirebaseAuth.instance.signOut(),
     setNull(),
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen())),

   }),
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account Created"))),




 },

 );

        }



  @override
  Widget build(BuildContext context) {
  if(val ==1){
    setRoll();
    initS();
    val=0;

  }


    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: ResponsiveWidget.isSmallScreen(context)?
      AppBar(title: Text(
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
                              ),
                            ),
                            TextSpan(
                              text: ' Sign Up 👇',
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
                      Text('Hey, Enter your details to create a new account with Festum.',
                        style: ralewayStyle.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(height: height * 0.064),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Roll Number: $rollNum',
                          style: ralewayStyle.copyWith(
                            fontSize: 18.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Name: (For Certificate)',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
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
                          controller: nameNumberController,
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: IconButton(
                              onPressed: (){},
                              icon: Icon( Icons.person),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: 'Enter Your Name',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      const SizedBox(height: 6.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Enter Bio (For Profile)',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
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
                          controller: bioController,
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: IconButton(
                              onPressed: (){},
                              icon: Icon( Icons.person),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: 'Enter Bio',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Mobile Number',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
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
                          controller: phoneController,
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: IconButton(
                              onPressed: (){},
                              icon: Icon( Icons.call),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: 'Enter Your Mobile Number',
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
                        child: Text('Year of Studying:',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
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
                          controller: yearController,
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),

                          decoration: InputDecoration(
                            border: InputBorder.none,

                            prefixIcon: IconButton(
                              onPressed: (){},
                              icon: Icon( Icons.calendar_month),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: '1 - 4',
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
                        child: Text('Branch:',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
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
                          value: branchVal,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: branches.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              branchVal = newValue!;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: height * 0.014),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Gender:',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
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
                          value: gender,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: genders.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              gender = newValue!;
                            });
                          },
                        ),
                      ),

                      // const SizedBox(height: 6.0),
                      // const SizedBox(height: 6.0),
                      SizedBox(height: height * 0.014),


                      Visibility(
                        visible:  clgName == "VNR VJIET"?true:false,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text('Stays in VNR College Hostel:',
                                style: ralewayStyle.copyWith(
                                  fontSize: 12.0,
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
                                value:  hosBol,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),


                                // Array list of items
                                items: clgHos.map((String items) {
                                  return DropdownMenuItem(

                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    hosBol = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 6.0),

                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Password:',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.bold,
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
                          controller: passwordController,
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),
                          obscureText: togP,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  togP = !togP;
                                });
                              },
                              icon: Image.asset(AppIcons.eyeIcon),
                            ),
                            prefixIcon: IconButton(
                              onPressed: (){},
                              icon: Image.asset(AppIcons.lockIcon),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: 'Enter Password',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.03),
                      Align(
                        alignment: Alignment.center,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){

                              signUp();

                            },
                            borderRadius: BorderRadius.circular(16.0),
                            child: Ink(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 18.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: AppColors.mainBlueColor,
                              ),
                              child: Text('Sign Up',
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: (){

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));

                          },
                          child: Text("Already have an Account? \nLog In Here",
                            textAlign: TextAlign.center,
                            style: ralewayStyle.copyWith(
                              fontSize: 12.0,
                              color: AppColors.mainBlueColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ResponsiveWidget.isSmallScreen(context) ? const SizedBox() :  Expanded(
              child: Container(
                height: height,
                color: AppColors.mainBlueColor,
                child: Center(
                  child: Text(
                    'IoT CLub @VNRVJIET',
                    style: ralewayStyle.copyWith(
                      fontSize: 48.0,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w800,
                    ),
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
          title:  Text('Festum',style: ralewayStyle.copyWith(
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
