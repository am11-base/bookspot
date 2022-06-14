import 'package:flutter/material.dart';

class BottomNavigationBookSpot extends StatefulWidget {
  const BottomNavigationBookSpot({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBookSpot> createState() => _BottomNavigationBookSpotState();
}

class _BottomNavigationBookSpotState extends State<BottomNavigationBookSpot> {
  @override
  int _selectedIndex=0;
  int _currentIndex=0;
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}


