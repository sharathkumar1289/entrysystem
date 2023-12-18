import 'package:festum_app/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class JoinEvent extends StatefulWidget {
  const JoinEvent({super.key});

  @override
  State<JoinEvent> createState() => _JoinEventState();
}

class _JoinEventState extends State<JoinEvent> {

  String sRegId = "TBU";

  int load =-1;
  setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {

      sRegId = prefs.getString("regId")!;

    });
  }

  @override
  Widget build(BuildContext context) {

    if(load==-1){
      setData();
      load = 1;

    }


    return SafeArea(child: Scaffold(


      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Text("Show this QR Code to mark Attend or Register for a Event in Convergence 2023R.",
            style: TextStyle(
              fontWeight: FontWeight.bold,

            ),),
            QrImageView(
              data: sRegId,
              version: QrVersions.auto,
              size: ResponsiveWidget.isSmallScreen(context) ? 200:400,
              gapless: true,
              embeddedImage: AssetImage('images/logosplash.png'),
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: !ResponsiveWidget.isSmallScreen(context)?Size(40, 40):Size(20, 20),
              ),
            ),




          ],
        ),
      ),
    ));
  }
}
