import 'package:festum_app/app_colors.dart';
import 'package:festum_app/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';


class EventAttend extends StatefulWidget {
  final String id;
  const EventAttend({Key? key, required this.id}) : super(key: key);


  @override
  State<EventAttend> createState() => _EventAttendState();
}

class _EventAttendState extends State<EventAttend> {

   List<String> list = <String>['Select','Hardware Hackathon', 'Software Hackathon', 'Campus Automation Contest', 'Social Events','FUn Events','Paper Presentation','Coding Contest','Models','Cadathon','Fun Events','Capture the Flag','Gaming','Spot-Light','Flutter','Rust','3d Printing','Hands-On 3D and Arduino', 'Model based Design','Datathon - Workshop','Drone Tech - Workshop','FPGA - Workshop','Drafathon','Industrial Automation','RoboJam','Data Visualiztion','UPSC ','Git GitHub'];
   String dropdownValue = "Select";


   registerEvent(String id) async {




     final gSheet = GSheets(cred);
     var now = DateTime.now();
     // var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
     // return formatter.format(now);

     final ss = await gSheet.spreadsheet(sId);
     var sheet = ss.worksheetByTitle("Sheet1");
     final secondRow = {
       'Info': '',
       'Payment Id': id,
       'Event': dropdownValue,
       'Time': now.toString(),
     };
     await sheet?.values.map.appendRow(secondRow);

     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Participant Registered")));
  Navigator.pop(context);
   }

  @override
  Widget build(BuildContext context) {


    return SafeArea(child: Scaffold(


      body: Center(
        child: Column(
          children: [

            SizedBox(height: 20,),


        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){
                      registerEvent(widget.id);
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext builder)=> ScanQR(type: 2)));

                    },
                    borderRadius: BorderRadius.circular(16.0),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 18.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: AppColors.mainBlueColor,
                      ),
                      child: Text('Register Event',
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
    ));
  }
}
