import 'package:bookspot/navdrawer.dart';
import 'package:bookspot/viewbooks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../add_books.dart';

class Search_Textfield_BookSpot extends StatefulWidget {
  final String? email;
  const  Search_Textfield_BookSpot(this.email, {Key? key}) : super(key: key);

  @override
  State<Search_Textfield_BookSpot> createState() =>
      _Search_Textfield_BookSpotState();
}

class _Search_Textfield_BookSpotState extends State<Search_Textfield_BookSpot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMain(widget.email),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            TextField(
              //obscureText: true,
              decoration: InputDecoration(
                hintText: 'Search For Book Name',
                icon: Icon(Icons.search),
              ),
            ),
            //  FutureBuilder(builder: builder)
            FutureBuilder(
                future: FirebaseFirestore.instance.collection('books').where('email',isNotEqualTo: widget.email).get(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    print(snapshot.data.docs.length);
                    /*snapshot.data.docs.forEach((element){
               print(element.get('title'));
             });*/
                   // print(snapshot.data.docs[2]['title']);
                    return (ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                         shrinkWrap: true,
                         itemCount: snapshot.data.docs.length,
                        itemBuilder: (_, int position)
                    {
                      return (Card(
                        color: Colors.green,
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                            print("clicked");
                            print(snapshot.data.docs[position]['category']);
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (_, a1, a2) => ViewBooks(snapshot.data.docs[position],widget.email)));
                          },
                          child: Container(
                           // width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Text(snapshot.data.docs[position]['title']),
                          ),
                        ),
                      ));
                    }));
                  } else
                    return CircularProgressIndicator();
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[400],
        child: Icon(Icons.add),
        onPressed: () {
          print(widget.email);
          Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, a1, a2) => AddBooks(widget.email)));
        },
      ),
    );
  }
}
