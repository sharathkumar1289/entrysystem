import 'package:festum_app/auth_service.dart';
import 'package:festum_app/rollNumberScreen.dart';
import 'package:festum_app/screens/coordinator_login.dart';
import 'package:festum_app/screens/main_home.dart';
import 'package:festum_app/screens/register_sprint.dart';
import 'package:festum_app/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:festum_app/app_colors.dart';
import 'package:festum_app/app_icons.dart';
import 'package:festum_app/app_styles.dart';
import 'package:festum_app/responsive_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool togPo = true;
  logIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();


    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mailController.text.toString().toLowerCase(),
          password: passController.text.toString()
      );

      await prefs.setString('mailId', mailController.text.toString().toLowerCase().replaceAll("@gmail.com", ""));
      // await prefs.setString('rollNumber', mailController.text.toString().replaceAll("@festum.in", ""));

    await prefs.setInt('lType',1);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainHome()));


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showCDialog("Error",'No user found for that email.',"Ok");
      } else if (e.code == 'wrong-password') {
        _showCDialog("Error",'Wrong password provided for that user.',"Ok");
      }
      else{
        _showCDialog("Error",'Invalid Credentials',"Ok");

      }
    }

//     FirebaseAuth.instance.signInWithEmailAndPassword(email: mailController.text.toString(), password: passController.text.toString()).whenComplete(() async =>
//     {
//
// // Save an integer value to 'counter' key.
//
//     await prefs.setString('mailId', mailController.text.toString()),
//
//       await prefs.setInt('lType',2),
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen())),
//
//
//
//     }).then((value) => {
//       print(value.toString()),
//     }).onError((error, stackTrace) => {
//       _showMyDialog(),
//     });

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: ResponsiveWidget.isSmallScreen(context)?
      AppBar(
        title: Text(
          'Festum',
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
                    'Festum',
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
                      SizedBox(height: height * 0.2),
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
                              text: ' Log In 👇',
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
                      Text('Hey, Enter your details to get Log in \nto your account.',
                        style: ralewayStyle.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(height: height * 0.064),

                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Email Id',
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
                          controller: mailController,

                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),


                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: IconButton(
                              onPressed: (){},
                              icon: Image.asset(AppIcons.emailIcon),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: 'Enter Your Email',
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
                        child: Text('Password:',
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

                          controller: passController,
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),
                          obscureText: togPo,

                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  togPo = !togPo;
                                });
                              },
                              icon: Image.asset(AppIcons.eyeIcon),
                            ),
                            prefixIcon: IconButton(
                              onPressed: (){




                              },
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
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: (){
                            _showMyDialog();

                          },
                          child: Text('Forgot Password?',
                            style: ralewayStyle.copyWith(
                              fontSize: 12.0,
                              color: AppColors.mainBlueColor,
                              fontWeight: FontWeight.w600,
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
                              logIn();
                            },
                            borderRadius: BorderRadius.circular(16.0),
                            child: Ink(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 18.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: AppColors.mainBlueColor,
                              ),
                              child: Text('Log In',
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
                          onPressed: () async {
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SignUpScreen()));
                            // if(await AuthService().signInWithGoogle() == 1){
                            //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SignUpScreen()));
                            //
                            // }
                            // else if(await AuthService().signInWithGoogle() == 2){
                            //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => RollNumberScreen()));
                            //
                            // }
                            // else{
                            //   _showMyDialog();
                            // }

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CoordinatorLogin()));

                          },

                          child: Text("Coordinator Login",
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
          ],
        ),
      ),
    );



  }
  Future<void> _showMyDialog() async {
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
                Text('For any Queries Contact ',style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.normal,
                )),
                Text('Festum: 1234567890 ',style: ralewayStyle.copyWith(
                  fontSize: 16.0,
                  color: AppColors.blueDarkColor,
                  fontWeight: FontWeight.normal,
                )),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCDialog(a,b,c) async {
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
