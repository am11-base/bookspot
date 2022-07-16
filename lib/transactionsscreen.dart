import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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
              .collection('users').doc(widget.email).collection('transactions')
              .get(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot.data.docs.length);
              snapshot.data.docs.forEach((element) {
                print(element.get('bookid'));
              });
              return (ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (_, int position)
                  {
                    if(snapshot.data.docs[position]['Status'].compareTo("LendRequest")==0)
                    {return (Card(
                      color: Colors.blueAccent,
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                        },
                        child: Container(
                          // width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Text(snapshot.data.docs[position]['Status']),
                        ),
                      ),
                    ));}
                    else if(snapshot.data.docs[position]['Status'].compareTo("BorrowRequest")==0)
                      {
                        return (Card(
                          color: Colors.yellow,
                          elevation: 5,
                          child: InkWell(
                            onTap: () {
                            },
                            child: Container(
                              // width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Text(snapshot.data.docs[position]['Status']),
                            ),
                          ),
                        ));
                      }
                    else if(snapshot.data.docs[position]['Status'].compareTo("Accepted")==0)
                    {
                      return (Card(
                        color: Colors.green,
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                          },
                          child: Container(
                            // width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Text(snapshot.data.docs[position]['Status']),
                          ),
                        ),
                      ));
                    }
                    else if(snapshot.data.docs[position]['Status'].compareTo("Rejected")==0 )
                    {
                      return (Card(
                        color: Colors.red,
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                          },
                          child: Container(
                            // width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Text(snapshot.data.docs[position]['Status']),
                          ),
                        ),
                      ));
                    }
                    else
                      return Text("hi");
                  }));
            } else
              return Center(child: CircularProgressIndicator());
          }),
    ));
  }
}
