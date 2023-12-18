import 'package:festum_app/app_colors.dart';
import 'package:festum_app/app_styles.dart';
import 'package:festum_app/screens/scan_qr.dart';
import 'package:flutter/material.dart';

class HoodieScreen extends StatefulWidget {
  const HoodieScreen({super.key});

  @override
  State<HoodieScreen> createState() => _HoodieScreenState();
}

class _HoodieScreenState extends State<HoodieScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(

          children: [

            SizedBox(height: 10,),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){
                      // logIn();
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext builder)=> ScanQR(type: 1)));
                      
                    },
                    borderRadius: BorderRadius.circular(16.0),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 18.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: AppColors.mainBlueColor,
                      ),
                      child: Text('Grant Hoodie',
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
            ),


          ],
        ),
      ),
    );
  }
}
