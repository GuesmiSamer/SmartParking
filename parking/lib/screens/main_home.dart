import 'package:flutter/material.dart';
import 'package:parking/screens/home_callendar.dart';
import 'package:parking/screens/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:parking/screens/reservations.dart';





class HomeMain extends StatefulWidget {
  const HomeMain({ Key? key }) : super(key: key);

  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int _page=0;
  final _pageoptions =  [
    Home(),
    Reservations(),
    HomeScreen(),
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
    backgroundColor: Color(0xFF6C2A7C),
    items: <Widget>[
      Icon(Icons.add, size: 30),
       Icon(Icons.list, size: 30),
      Icon(Icons.person,size: 30),
    ],
    onTap: (index) {
    setState(() {
      _page=index;
    });
    },
  ),
  body: _pageoptions [_page],
    );
  }
}