import 'package:flutter/material.dart';
import 'package:bookspot/widgets/add_image_profile.dart';

class AddBooks extends StatefulWidget {
  const AddBooks({Key? key}) : super(key: key);

  @override
  State<AddBooks> createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BookSpot'),
      ),
      body: AddImageProfile(),

    );
  }
}
