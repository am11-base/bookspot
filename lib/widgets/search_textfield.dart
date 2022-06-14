import 'package:flutter/material.dart';

class Search_Textfield_BookSpot extends StatefulWidget {
  const Search_Textfield_BookSpot({Key? key}) : super(key: key);

  @override
  State<Search_Textfield_BookSpot> createState() => _Search_Textfield_BookSpotState();
}

class _Search_Textfield_BookSpotState extends State<Search_Textfield_BookSpot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        //obscureText: true,
        decoration: InputDecoration(
          hintText: 'Search For Book Name',
          icon: Icon(Icons.search),
        ),
      ),
    );
  }
}
