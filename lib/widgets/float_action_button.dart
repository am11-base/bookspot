import 'package:bookspot/add_books.dart';
import 'package:flutter/material.dart';

import '../add_books.dart';

class FloatActionButtonBookSpot extends StatefulWidget {
  const FloatActionButtonBookSpot({Key? key}) : super(key: key);

  @override
  State<FloatActionButtonBookSpot> createState() => _FloatActionButtonBookSpotState();
}

class _FloatActionButtonBookSpotState extends State<FloatActionButtonBookSpot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        child: Icon(
          Icons.add
        ),
        onPressed: (){
          Navigator.push(context, PageRouteBuilder(pageBuilder: (_,a1,a2)=>AddBooks()));
        },
        backgroundColor: Colors.blue,

      ),
    );
  }
}

