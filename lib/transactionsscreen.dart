import 'dart:async';

import 'package:bookspot/home_screen.dart';
import 'package:bookspot/viewprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class Transactions extends StatefulWidget {
  final String email;
  const Transactions(this.email, {Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      physics: ScrollPhysics(),
      child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.email)
              .collection('transactions')
              .get(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot.data.docs.length);
              snapshot.data.docs.forEach((element) {
                print(element.get('bookid'));
              });
              if (snapshot.data.docs.length == 0) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.4,
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: Center(
                    child: Text(
                      "No active transactions",
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ),
                );
              } else {
                return (ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (_, int position) {
                      if (snapshot.data.docs[position]['Status']
                              .compareTo("LendRequest") ==
                          0) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: (Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color(0xffd9f8c4),
                            elevation: 5,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                // width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03),
                                      child: Center(
                                        child: Text(
                                            snapshot.data.docs[position]
                                                ['bookname'],textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black)),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03),
                                      child: Text("Status      : Lend Request",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03),
                                      child: Row(
                                        children: [
                                          Text(
                                              "Borrower : "),
                                        TextButton(
                                          onPressed: ()
                                          {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (_, a1,
                                                        a2) => ViewProfile(snapshot.data.docs[position]['borrower'])));

                                          },
                                          child: Text("${snapshot.data.docs[position]['borrower']}",

                                                style: TextStyle(
                                                    fontStyle:FontStyle.italic,decoration:TextDecoration.underline,
                                                    fontSize: 14,
                                                    color: Colors.black)),
                                        ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0.0, 20.0),
                                                    blurRadius: 30.0,
                                                    color: Colors.black12)
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(22)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0,
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.03),
                                            child: MaterialButton(
                                              onPressed: () async {
                                                acceptBook(snapshot
                                                    .data.docs[position]);
                                                deleterecords(snapshot
                                                    .data.docs[position]);
                                                Timer(Duration(seconds: 1), () {
                                                  Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                          pageBuilder: (_, a1,
                                                                  a2) =>
                                                              HomeScreen()));
                                                });
                                              },
                                              child: Text("Accept",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.green)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0.0, 20.0),
                                                    blurRadius: 30.0,
                                                    color: Colors.black12)
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(22)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0,
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.03),
                                            child: MaterialButton(
                                              elevation: 2,
                                              onPressed: () async {
                                                deleterecords(snapshot
                                                    .data.docs[position]);
                                                Timer(Duration(seconds: 1), () {
                                                  Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                          pageBuilder: (_, a1,
                                                                  a2) =>
                                                              HomeScreen()));
                                                });
                                              },
                                              child: const Text("Reject",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.red)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                        );
                      } else if (snapshot.data.docs[position]['Status']
                              .compareTo("BorrowRequest") ==
                          0) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color(0XFFf9f9c5),
                            elevation: 5,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0,
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        child: Center(
                                          child: Text(
                                              snapshot.data.docs[position]
                                                  ['bookname'],textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black87)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0,
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        child: Text("Status : Request Sent",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0,
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        child: Row(
                                          children: [
                                            Text(
                                                "Lender : "),
                                          TextButton(
                                            onPressed: ()
                                            {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      pageBuilder: (_, a1,
                                                          a2) => ViewProfile(snapshot.data.docs[position]['lender'])));

                                            },
                                            child: Text("${snapshot.data.docs[position]['lender']}",
                                                  style: TextStyle(
                                                      fontStyle:FontStyle.italic,decoration:TextDecoration.underline,
                                                      fontSize: 14,
                                                      color: Colors.black87)),
                                          ),
                                          ],
                                        ),
                                      ),
                                    ])),
                          ),
                        );
                      } else
                        return Text("hi");
                    }));
              }
            } else
              return Center(
                  child: LoadingBouncingGrid.square(
                backgroundColor: Colors.blue,
              ));
          }),
    ));
  }

  Future deleterecords(doc) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .doc(doc['lender'])
        .collection('transactions')
        .where('bookid', isEqualTo: doc['bookid'])
        .get();
    result.docs.forEach((element) {
      element.reference.delete();
    });

    QuerySnapshot result1 = await FirebaseFirestore.instance
        .collection('users')
        .doc(doc['borrower'])
        .collection('transactions')
        .where('bookid', isEqualTo: doc['bookid'])
        .get();
    result1.docs.forEach((element) {
      element.reference.delete();
    });
  }

  Future<int> getcoin(String? email) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    int a = snapshot.data()!['coin'];
    print(a);
    return a;
  }

  Future acceptBook(doc) async {
    print("in accept");
    String lender = doc['lender'];
    String borrower = doc['borrower'];
    String id = doc['bookid'];
    String name = doc['bookname'];
    int bcoin = await getcoin(borrower);
    int lcoin = await getcoin(lender);
    int lncoin =lcoin + 10;
    int bncoin =bcoin - 25;
    final docBook1 = FirebaseFirestore.instance
        .collection('users')
        .doc(borrower)
        .collection('borrowedbooks')
        .doc();
    final docBook2 = FirebaseFirestore.instance
        .collection('users')
        .doc(lender)
        .collection('lendbooks')
        .doc(docBook1.id);
    final json1 = {
      'id': docBook1.id,
      'lender': lender,
      'borrower': borrower,
      'bookid': id,
      'bookname': name,
      'status': 'inhand'
    };
    final json2 = {
      'id': docBook2.id,
      'lender': lender,
      'borrower': borrower,
      'bookid': id,
      'bookname': name,
      'status': 'inhand'
    };
    try {
      await docBook1.set(json1);
      await docBook2.set(json2);
    } catch (e) {
      print(e.toString());
    }
    print(id);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(borrower)
        .update({'coin': bncoin});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(borrower)
        .update({'coin': lncoin});

    //updating availability
    await FirebaseFirestore.instance
        .collection('books')
        .doc(id)
        .update({'status': "notavailable"});
  }
}
