import 'package:bookspot/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../profile.dart';
import '../transactionsscreen.dart';

class BottomNavigationBookSpot extends StatefulWidget {
  const BottomNavigationBookSpot({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBookSpot> createState() => _BottomNavigationBookSpotState();
}

class _BottomNavigationBookSpotState extends State<BottomNavigationBookSpot> {
  @override
  int _selectedIndex=0;
  int _currentIndex=0;
  List<Widget> widgetoptions=<Widget>[
    HomeScreen(),
    Transactions(),
    Profile()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        currentIndex:_selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mms),
            label: 'Transaction',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.black,
          ),
        ],
       onTap: _onItemTapped,
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}


