import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class Help extends StatefulWidget {
  final String? email;
  const Help(this.email, {Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final query=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Contact",style: TextStyle(color: Colors.black),),elevation:0,centerTitle: true,backgroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.black),),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.05,horizontal: MediaQuery.of(context).size.width*0.07),
              child: TextField(
                maxLines: 7,
                controller: query,
                decoration: InputDecoration(
                  hintText: "Write to us",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
              ),
            ),
            MaterialButton(onPressed: ()async{
              String datetime=DateTime.now().toString();
              String query1=query.text.trim();
              addQuery(query1,widget.email,datetime);
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, a1, a2) => HomeScreen()));
            },child: Text("Submit",style: TextStyle(fontSize: 16),),color: Colors.greenAccent[200],)
          ],
        ),
      persistentFooterButtons: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text("© Team Bookspot ",textAlign: TextAlign.center,),
        )
      ],
    );
  }

  Future<void> addQuery(String query1, String? email, String datetime) async {
    final docBook = FirebaseFirestore.instance.collection('queries').doc();
    final json={
      "date":datetime,
      "user":email,
      "query":query1
    };
    try{
      await docBook.set(json);
    }
    catch(e){
      print(e);
    }

  }
}
