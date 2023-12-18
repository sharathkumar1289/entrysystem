
import 'package:festum_app/nav_drawer.dart';
import 'package:festum_app/screens/home_screen.dart';
import 'package:festum_app/screens/hoodie_collect.dart';
import 'package:festum_app/screens/join_event.dart';

import 'package:festum_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {

  String uName ='';
  String mail ='';

  // Future<void> getInfo() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     uName = prefs.getString('userName').toString();
  //     mail = prefs.getString('mailId').toString();
  //   });
  // }
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),

   ProfileScreen(),

    HoodieCollect(),

    JoinEvent(),
    HomeScreen(),

    HomeScreen(),



  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    //getInfo();
    return Scaffold(
      appBar: AppBar(
        title:

        Text("Festum", style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold


        ),),

        backgroundColor: Color(0xA30772FF),
      ),
      drawer: NavDrawer(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: _pages[_selectedIndex],
    );
  }
}



