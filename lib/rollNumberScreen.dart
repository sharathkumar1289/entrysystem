import 'package:festum_app/app_colors.dart';
import 'package:festum_app/responsive_widget.dart';
import 'package:festum_app/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:festum_app/app_icons.dart';
import 'package:festum_app/app_styles.dart';
import 'package:festum_app/responsive_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RollNumberScreen extends StatefulWidget {
  const RollNumberScreen({super.key});

  @override
  State<RollNumberScreen> createState() => _RollNumberScreenState();
}

class _RollNumberScreenState extends State<RollNumberScreen> {


  TextEditingController rollController = TextEditingController();
  TextEditingController clgController = TextEditingController();
 var clgType =['Select','VNR VJIET', 'Non VNR VJIET'];
 bool clgVnr = true;
 String ClgDisp = "Select";


  logIn() async {

    if(rollController.text.length!=10){
      _showCDialog("Error","Enter Valid Roll Number","Ok");
      return;
    }
    if(ClgDisp=="Select"){
      _showCDialog("Error","Please Select College","Ok");
      return;
    }

    if(clgController.text.length<10 && !clgVnr){
      _showCDialog("Error","Enter College Name","Ok");
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('lType', 1);
    await prefs.setString('clgName',clgVnr?"VNR VJIET": clgController.text.toString());
    await prefs.setString('rollNumber',rollController.text.toString().toLowerCase());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SignUpScreen()));

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
                              text: ' Get Started 👇',
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
                      Text('Enter your College details to continue.',
                        style: ralewayStyle.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(height: height * 0.064),

                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Enter any Unique Number (Mobile or College ID)',
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
                          controller: rollController,

                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),


                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.info),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: 'Enter any Unique Number (Mobile or College ID)',
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
                        child: DropdownButton(

                          // Initial Value
                          value: ClgDisp,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: clgType.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              ClgDisp = newValue!;
                              if(newValue == "Non VNR VJIET"){
                                clgVnr = false;
                              }
                              else{
                                clgVnr = true;
                              }
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 6.0),
                      Visibility(
                        visible: !clgVnr,
                        child: Container(
                          height: 50.0,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: AppColors.whiteColor,
                          ),
                          child: TextFormField(

                            controller: clgController,
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
                                icon: Icon(Icons.school),
                              ),
                              contentPadding: const EdgeInsets.only(top: 16.0),
                              hintText: 'College Name:',
                              hintStyle: ralewayStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.blueDarkColor.withOpacity(0.5),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.03),


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
                              child: Text('Continue',
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
