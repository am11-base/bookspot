import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_screen.dart';

class ViewBooks extends StatefulWidget {
  final Map<String,String> snapshot;
  final String? email;
  const ViewBooks(this.snapshot, this.email, {Key? key}) : super(key: key);

  @override
  _ViewBooksState createState() => _ViewBooksState();
}

class _ViewBooksState extends State<ViewBooks> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users').doc(widget
            .snapshot['email'])
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<dynamic> snapshot1) {
          if (snapshot1.connectionState == ConnectionState.done) {
            return Scaffold(
                backgroundColor: Color(0xFFd6f2ff),
                appBar: AppBar(backgroundColor: Color(0xFFd6f2ff),
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),),
                body: SingleChildScrollView(child: Column(


                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      Container(
                          color: Color(0xFFd6f2ff),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.5,


                      child: FadeInImage.assetNetwork(
                      placeholder:'assets/Loading.gif' ,
                      image: widget.snapshot['url']!)




                      ),

                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.5,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                            color: Colors.white
                        ),
                        child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.02, MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.04, MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.02, MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.02),
                                child: Text(widget.snapshot['title']!,textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),),

                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1, MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.01, MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1, MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.04),
                                child: Text("Author : ${widget
                                    .snapshot['author']}", style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20, fontWeight: FontWeight.bold,
                                ),),),


                              Padding(
                                padding: EdgeInsets.fromLTRB(MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1, MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.001, MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1, MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.0),
                                child: Text("Lender : ${snapshot1
                                    .data["name"]}", style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20, fontWeight: FontWeight.bold,
                                ),),

                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.04, MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.01, MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.004, MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Contact : ${snapshot1.data["phone"]}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    IconButton(icon: Icon(
                                      Icons.message, color: Colors.green,
                                      size: 30,), onPressed: () {
                                      message(snapshot1.data["phone"]);

                                    }),
                                    IconButton(icon: Icon(
                                      Icons.call, color: Colors.green,
                                      size: 30,), onPressed: () {
                                      call(snapshot1.data["phone"]);

                                    })
                                  ],
                                ),

                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.04, MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.001, MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.004, MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.04),
                                  child: FlatButton(
                                      color: Colors.red,
                                      splashColor: Colors.blue,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*0.4,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Request 25 ',
                                              style: TextStyle(fontSize: 20),),
                                            Icon(Icons.monetization_on)
                                          ],
                                        ),
                                      ),
                                      textColor: Colors.white,
                                      onPressed: () async{
                                        String lender = widget
                                            .snapshot["email"]!;
                                        String? borrower = widget.email;
                                        String id = widget.snapshot["id"]!;
                                        String name = widget
                                            .snapshot["title"]!;

                                        int coin=await getcoin(borrower);
                                        if(coin<25)
                                          {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                    backgroundColor: Colors.red,
                                                    behavior: SnackBarBehavior.floating,
                                                    elevation: 5,
                                                    duration: Duration(seconds: 2),
                                                    content: Container(
                                                      height: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.05,
                                                      decoration: BoxDecoration(
                                                          color: Colors.transparent,
                                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                                      ),
                                                      child: Text(
                                                        "Sorry You Don't have enough coin",
                                                        style: TextStyle(
                                                            fontStyle: FontStyle.italic,
                                                            color: Colors.white
                                                        ),
                                                      ),

                                                    )
                                                )
                                            );
                                          }
                                        else{
                                        RequestBooks(
                                            lender, borrower, id, name);}
                                        Timer(Duration(seconds: 3), () {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder: (_, a1,
                                                      a2) => HomeScreen()));
                                        });
                                      }
                                  )
                              )
                              ,

                            ]
                        ),
                      )
                    ]
                ),
                ));
          }
          else
            return Scaffold(body: Center(child: LoadingBouncingGrid.square(
              backgroundColor: Colors.blue,
            )));
        }

    );
  }

  Future<int> getcoin(String? email) async {
    final snapshot= await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get();
    int a=snapshot.data()!['coin'];
    print(a);
    return a;


  }

  Future RequestBooks(String lender, String? borrower, String id,
      String name) async {
    QuerySnapshot a = await FirebaseFirestore.instance.collection('users').doc(
        borrower).collection('transactions')
        .where('bookid', isEqualTo: id)
        .get();
    bool flag = a.docs.isEmpty;
    if (flag == true) {
      final docBook1 = FirebaseFirestore.instance.collection('users').doc(
          borrower).collection('transactions').doc();
      final docBook2 = FirebaseFirestore.instance.collection('users').doc(
          lender).collection('transactions').doc();
      final json1 = {
        'id': docBook1.id,
        'Status': "BorrowRequest",
        'lender': lender,
        'borrower': borrower,
        'bookid': id,
        'bookname': name
      };
      final json2 = {
        'id': docBook2.id,
        'Status': "LendRequest",
        'lender': lender,
        'borrower': borrower,
        'bookid': id,
        'bookname': name
      };
      try {
        await docBook1.set(json1);
        await docBook2.set(json2);
      } catch (e) {
        print(e);
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              elevation: 5,
              duration: Duration(seconds: 2),
              content: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Text(
                  "Sorry You have already placed a request!",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white
                  ),
                ),

              )
          )
      );
    }
  }
  message(int no) async{

    Uri smsUri = Uri(scheme: 'sms', path:"${no}");

    try {
      print(smsUri.toString());
      if (await canLaunchUrl(
        smsUri,
      )) {
        await launchUrl(smsUri);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text('Some error occured'),
        ),
      );
    }

    }

  call(int no) async{


    try {

      if (await canLaunchUrl(Uri.parse("tel:${no}")
      )) {
        await launchUrl(Uri.parse("tel:${no}"));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text('Some error occured'),
        ),
      );
    }

  }

  }

