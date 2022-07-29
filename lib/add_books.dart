import 'package:flutter/material.dart';
import 'package:bookspot/widgets/add_image_profile.dart';

class AddBooks extends StatefulWidget {
  final String? email;
  const AddBooks(this.email, {Key? key}) : super(key: key);

  @override
  State<AddBooks> createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: SingleChildScrollView(

      child:AddImageProfile(widget.email),
      )
    );
  }
}
