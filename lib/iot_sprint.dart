import 'package:festum_app/responsive_widget.dart';
import 'package:flutter/material.dart';

class IoTSprintScreen extends StatefulWidget {
  const IoTSprintScreen({super.key});


  @override
  State<IoTSprintScreen> createState() => _IoTSprintScreenState();
}

class _IoTSprintScreenState extends State<IoTSprintScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: ResponsiveWidget.isSmallScreen(context)?  AppBar(title: Text("Festum"),):null,

      body: Column(


        children: [



        ],
      ),


    );
  }
}
