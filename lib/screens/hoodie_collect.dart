import 'package:festum_app/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsheets/gsheets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HoodieCollect extends StatefulWidget {
  const HoodieCollect({super.key});

  @override
  State<HoodieCollect> createState() => _HoodieCollectState();
}

class _HoodieCollectState extends State<HoodieCollect> {



  bool hCollect = true;
  String sRegId = "TBU";
  int rowId =-1;
  int load =-1;

  checkHoodie() async {



    final gSheet = GSheets(cred);


    final ss = await gSheet.spreadsheet(sId);
    var sheet = ss.worksheetByTitle("Sheet1");

    await sheet?.values.value(column:11,row:rowId).then((value) => {
      setState(() {
        // print("Test"+value.toString());
        hCollect = (value =='1');
      }),

    });

  }


  getDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      rowId = prefs.getInt("rowId")!;
      sRegId = prefs.getString("regId")!;
    });

    checkHoodie();
  }

  @override
  Widget build(BuildContext context) {
    if(load==-1){
      getDetails();
      load = 1;
    }


    return SafeArea(child: Scaffold(
      body: Column(
        children: [

          SizedBox(height: 20,),
          Visibility(
            visible: !hCollect,
              child: Text("Loading")),
          Center(
            child: Visibility(
                visible: !hCollect,
                child:Card(
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("Collect Your Hoodie by Showing this QR Code"),
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
                )
            ),
          ),

          Visibility(
              visible: hCollect,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("You have Successfully collected your Hoodie\nThank You..!",
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:30,
                ),),
              )),
          // detailText('Hoodie Status: ${hcollect}'),
        ],
      ),
    ));
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