import 'package:flutter/material.dart';
import 'package:bookspot/widgets/bottom_navigation_bookspot.dart';
import 'package:bookspot/widgets/float_action_button.dart';
import 'package:bookspot/widgets/search_textfield.dart';
import 'add_books.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BookSpot'),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.01, MediaQuery.of(context).size.height*0.03, 0, 0),
          child: Search_Textfield_BookSpot()),
      floatingActionButton: FloatActionButtonBookSpot(),
      bottomNavigationBar: BottomNavigationBookSpot(),
    );
  }
}
