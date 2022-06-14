import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _State();
}

class _State extends State<AddBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookSpot'),
        ),
      body: SingleChildScrollView(
        child: TextField(
          decoration: InputDecoration(
              filled: true,
              hintText: 'ADD BOOK TITLE',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }
}
