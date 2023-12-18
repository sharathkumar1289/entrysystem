import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:shared_preferences/shared_preferences.dart';


class InfoScreen extends StatefulWidget {
  final String id;
  const InfoScreen({Key? key, required this.id}) : super(key: key);


  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {

  int loading = -1;
  int load= -1;

  List regIds=[];
  String pRoll = "";
  String pSize = "";

  int rowId= -1;
  // List id3=[];
  // List id4=[];
  bool hcollect = true;


  setTaken() async {


    final gSheet = GSheets(cred);


    final ss = await gSheet.spreadsheet(sId);
    var sheet = ss.worksheetByTitle("Sheet1");
    await  sheet?.values.insertValue("1", column: 11, row: rowId).whenComplete(() => {

      setState((){
        loading=1;
        hcollect=false;
      }),

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Give Hoodie"))),

    }
    );
  }
  checkHoodie() async {


    final gSheet = GSheets(cred);


    final ss = await gSheet.spreadsheet(sId);
    var sheet = ss.worksheetByTitle("Sheet1");

    await sheet?.values.value(column:4,row:rowId).then((value) => {

      pRoll = value,
    });
    await sheet?.values.value(column:6,row:rowId).then((value) => {
pSize = value,
    });
    await sheet?.values.value(column:11,row:rowId).then((value) => {
    if(value =='1'){

        setState(() {
      // print("Test"+value.toString());
    hcollect=true;
    loading=1;
    }),

        }else{

      setTaken(),


        }



    });

  }


  checkReg() async {


    final gSheet = GSheets(cred);


    final ss = await gSheet.spreadsheet(sId);
    var sheet = ss.worksheetByTitle("Sheet1");
    if (widget.id != null) {
      final sheetData = await sheet?.values.allRows();
//         // print(sheet?.values.insertValue("value", column: 1, row: 3));
      int lrn = sheetData!.length;
      await sheet?.values.column(1, fromRow: 2, length: 3000).then((value) =>

      regIds = value,

      );
      //
      // await sheet?.values.column(2,fromRow: 2,length: 500).then((value) =>
      //
      //   regIds = value,
      //
      //   );

      print(widget.id);
      for (int i = 0; i < regIds.length; i++) {
        if (widget.id.toString() ==
            regIds[i].toString()) {

          rowId = i+2;

          checkHoodie();
          break;




        }
      }
    }




  }

  @override
  Widget build(BuildContext context) {
    // print(widget.id);
    if(load==-1){
      checkReg();
      load=1;
    }

    return SafeArea(child: Scaffold(

      body: Center(
        child: Column(
          children: [

            SizedBox(height: 20,),
            Visibility(
              visible: loading==-1,
                child: Text("Loading", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:20,
                ))),

            Visibility(
              visible: hcollect && loading!=-1,
                child: Text("Already Collected Hooide", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:20,
                ))),

            Visibility(
                visible: !hcollect && loading!=-1,
                child: Column(
                  children: [
                    Text("Give Hooide", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:20,
                    )),
                    Text("Roll No: $pRoll", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:20,
                    )),
                    Text("Size: $pSize", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:20,
                    )),
                  ],
                )),



          ],
        ),
      ),
    ));
  }
}
