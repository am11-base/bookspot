import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class ViewBooks extends StatefulWidget {
  final QueryDocumentSnapshot snapshot;
  final String? email;
  const ViewBooks(this.snapshot, this.email, {Key? key}) : super(key: key);

  @override
  _ViewBooksState createState() => _ViewBooksState();
}

class _ViewBooksState extends State<ViewBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BookSpot'),centerTitle: true,),
      body: SingleChildScrollView(child:Column(

          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Padding(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.02, MediaQuery.of(context).size.height*0.05, MediaQuery.of(context).size.width*0.02, MediaQuery.of(context).size.height*0),
              child: Text(widget.snapshot['title'],style: TextStyle(
                color: Colors.black,
                fontSize: 25,fontWeight: FontWeight.bold,
              ), ),

            ),


            Padding(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.02, MediaQuery.of(context).size.height*0.01, MediaQuery.of(context).size.width*0.02, MediaQuery.of(context).size.height*0.05),
              child: Container(
                width: MediaQuery.of(context).size.width*0.6,
                height: MediaQuery.of(context).size.height*0.4,


                child: FadeInImage.assetNetwork(
                  placeholder:'assets/Loading_2.gif' ,
                  image: widget.snapshot['url'])

                ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.1, MediaQuery.of(context).size.height*0.001, MediaQuery.of(context).size.width*0.1, MediaQuery.of(context).size.height*0.04),
              child: Text("AUTHOR: ${widget.snapshot['author']}",style: TextStyle(
                color: Colors.black,
                fontSize: 25,fontWeight: FontWeight.bold,
              ), ),),



            Padding(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.1, MediaQuery.of(context).size.height*0.001, MediaQuery.of(context).size.width*0.1, MediaQuery.of(context).size.height*0.04),
              child: Text("LENDER ${widget.snapshot['email']}",style: TextStyle(
                color: Colors.black,
                fontSize: 20,fontWeight: FontWeight.bold,
              ), ),

            ),
            Padding(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.04, MediaQuery.of(context).size.height*0.001, MediaQuery.of(context).size.width*0.004, MediaQuery.of(context).size.height*0.05),
              child: Text("Contact ${widget.snapshot["email"]}",style: TextStyle(
                color: Colors.black,
                fontSize: 20,fontWeight: FontWeight.bold,
              ), ),

            ),
            Padding(
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.04, MediaQuery.of(context).size.height*0.001, MediaQuery.of(context).size.width*0.004, MediaQuery.of(context).size.height*0.04),
                child: FlatButton(
                    color: Colors.red,
                    splashColor: Colors.blue,
                    child: Text('Request'),
                    textColor: Colors.white,
                    onPressed: (){
                      String lender=widget.snapshot["email"];
                      String? borrower=widget.email;
                      String id=widget.snapshot["id"];

                      RequestBooks(lender,borrower,id);

                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, a1, a2) => HomeScreen()));
                    }
                )
            )
            ,



          ]
      ),
      ));

  }
  Future RequestBooks(String lender, String? borrower, String id) async {
    final docBook1= FirebaseFirestore.instance.collection('users').doc(borrower).collection('transactions').doc();
    final docBook2 = FirebaseFirestore.instance.collection('users').doc(lender).collection('transactions').doc();
    final json1 = {
      'id':docBook1.id,
      'Status':"BorrowRequest",
      'lender': lender,
      'borrower':borrower,
      'bookid': id,

    };
    final json2 = {
      'id':docBook2.id,
      'Status':"LendRequest",
      'lender': lender,
      'borrower':borrower,
      'bookid': id,

    };
    try {
      await docBook1.set(json1);
      await docBook2.set(json2);

    } catch (e) {
      print(e);
    }

  }
}

