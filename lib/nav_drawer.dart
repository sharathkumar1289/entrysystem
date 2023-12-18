import 'package:flutter/material.dart';


class NavDrawer extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  NavDrawer({required this.selectedIndex, required this.onItemTapped});

  @override
  _NavDrawerState createState() => _NavDrawerState();
}


class _NavDrawerState extends State<NavDrawer>  {


  // static const IconData directions_bike = IconData(0xe1d2, fontFamily: 'MaterialIcons');


  String uName ='';
  String mail ='';

  // Future<void> getInfo() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //     setState(() {
  //   uName = prefs.getString('userName').toString();
  //   mail = prefs.getString('mailId').toString();
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // getInfo();
    return SafeArea(
      child: Drawer(


          backgroundColor: Color(0xA30772FF),
          child: Stack(

            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    height: 100,
                    child: Column(
                      children: [
                        Row(



                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Image(image: AssetImage("assets/loc.png")),
                            // ),
                            Text(

                              uName,
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            SizedBox(width:5),
                          ],
                        ),

                        Text(mail,
                            style: TextStyle(
                                color: Colors.white

                            )),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xA30772FF),

                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home,
                      color: Colors.white,
                    ),
                    title: Text('Home' ,style: TextStyle(
                        color: Colors.white

                    )),
                    onTap: () =>{
                      widget.onItemTapped(0),
                      Navigator.of(context).pop(),
                    },
                    selected: widget.selectedIndex == 0,
                  ),
                  ListTile(
                    leading: Icon(Icons.person,
                      color: Colors.white,),
                    title: Text('Profile',style: TextStyle(
                        color: Colors.white

                    )),
                    onTap: () =>{
                      widget.onItemTapped(1),
                      Navigator.of(context).pop(),

                    },
                    selected: widget.selectedIndex == 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_cart,
                      color: Colors.white,),
                    title: Text('Collect Hoodie',style: TextStyle(
                        color: Colors.white

                    )),
                    onTap: () =>{
                      widget.onItemTapped(2),
                      Navigator.of(context).pop(),

                    },
                    selected: widget.selectedIndex == 2,
                  ),

                  ListTile(
                    leading: Icon(Icons.history,
                      color: Colors.white,),
                    title: Text('Events',style: TextStyle(
                        color: Colors.white

                    )),
                    onTap: () =>{
                      widget.onItemTapped(3),
                      Navigator.of(context).pop(),

                    },
                    selected: widget.selectedIndex == 3,
                  ),

                  // ListTile(
                  //   leading: Icon(Icons.subscriptions,
                  //     color: Colors.white,),
                  //   title: Text('Subscription',style: TextStyle(
                  //       color: Colors.white
                  //
                  //   )),
                  //   onTap: () =>{
                  //     widget.onItemTapped(4),
                  //     Navigator.of(context).pop(),
                  //
                  //   },
                  //   selected: widget.selectedIndex == 4,
                  // ),

                  // ListTile(
                  //   leading: Icon(Icons.info,
                  //     color: Colors.white,),
                  //   title: Text('Info',style: TextStyle(
                  //       color: Colors.white
                  //
                  //   )),
                  //   onTap: () =>{
                  //     widget.onItemTapped(5),
                  //     Navigator.of(context).pop(),
                  //
                  //   },
                  //   selected: widget.selectedIndex == 5,
                  // ),
                  //
                  // ListTile(
                  //   leading: Icon(Icons.help,
                  //     color: Colors.white,),
                  //   title: Text('Help',style: TextStyle(
                  //       color: Colors.white
                  //
                  //   )),
                  //   onTap: () =>{
                  //     widget.onItemTapped(6),
                  //     Navigator.of(context).pop(),
                  //
                  //   },
                  //   selected: widget.selectedIndex == 6,
                  // ),

                  //SizedBox(height: 200,),



                ],
              ),

              // Positioned(
              //   bottom: 0,
              //   width: MediaQuery.of(context).size.width,
              //   child: Container(
              //
              //     decoration: BoxDecoration(
              //       color: Color(0xD28E00FF),
              //     ),
              //     child: ListTile(
              //
              //       leading: Icon(Icons.exit_to_app,
              //         color: Colors.white,),
              //       title: Text('Log Out',style: TextStyle(
              //           color: Colors.white
              //
              //       )),
              //       onTap: () =>{
              //         widget.onItemTapped(7),
              //         Navigator.of(context).pop(),
              //
              //       },
              //       selected: widget.selectedIndex == 7,
              //
              //     ),
              //   ),
              // ),
            ],
          )
      ),
    );

  }

}
