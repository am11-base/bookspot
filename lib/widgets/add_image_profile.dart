import 'package:flutter/material.dart';

class AddImageProfile extends StatefulWidget {
  const AddImageProfile({Key? key}) : super(key: key);

  @override
  State<AddImageProfile> createState() => _AddImageProfileState();
}

class _AddImageProfileState extends State<AddImageProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(children: <Widget>[
            Text('Add Image',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(140,30,150,50),
              child: Image.asset('assets/images/profile1.png'),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Add Book Title',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Add Author Name',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Category',
              ),
            ),
            /*ElevatedButton(onPressed: () {},
                child: Text('Submit'),
            ),*/
            Padding(padding: EdgeInsets.fromLTRB(100,30,150,50),),
            ElevatedButton(onPressed: () {},
              child: Text('Submit'),
            ),

          ]
          )
      ),
    );
  }
}

