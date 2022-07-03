import 'package:bookspot/profile.dart';
import 'package:bookspot/transactionsscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookspot/widgets/bottom_navigation_bookspot.dart';
import 'package:bookspot/widgets/search_textfield.dart';
import 'add_books.dart';
import 'authentication.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  int _selectedIndex = 0;
  late String? email;
   List<Widget> widgetoptions(){
     return[
    Search_Textfield_BookSpot(email),
    Transactions(),
    Profile()];
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BookSpot'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: Authentication().getCurrentUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              User a = snapshot.data;
              email = a.email;
              print(email);
              return widgetoptions().elementAt(_selectedIndex);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
        selectedItemColor: Colors.cyan,
      ),
    );
  }
}
