import 'package:bookspot/viewprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class BorrowedList extends StatefulWidget {
  final String? email;
  const BorrowedList(this.email, {Key? key}) : super(key: key);

  @override
  _BorrowedListState createState() => _BorrowedListState();
}

class _BorrowedListState extends State<BorrowedList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.email)
            .collection('borrowedbooks')
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data.docs.length);
            if (snapshot.data.docs.length == 0) {
              return Scaffold(
                appBar: AppBar(title: Text("Borrowed Books",style: TextStyle(color: Colors.black),),elevation:0,centerTitle: true,backgroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.black),),
                body: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.4,
                      horizontal:
                      MediaQuery.of(context).size.width * 0.1),
                  child: Center(
                    child: Text(
                      "No Book Found",
                      style:
                      TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                ),
              );
            } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Borrowed Books",style: TextStyle(color: Colors.black)),
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                ),
                body: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (_, int position) {
                      if((snapshot.data.docs[position]['status']).compareTo("inhand")==0)
                        {
                          return Padding(
                            padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.01,horizontal:MediaQuery.of(context).size.width*0.05 ),
                            child: (Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.deepPurpleAccent,
                              elevation: 5,
                              child: Container(
                                // width: MediaQuery.of(context).size.width,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.25,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.02),
                                      child: Center(
                                        child: Text(snapshot.data
                                            .docs[position]['bookname'],textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.white),),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Status : inhand',style: TextStyle(fontSize: 16,color: Colors.white),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Lender : ',style: TextStyle(fontSize: 16,color: Colors.white),),
                                        TextButton(
                                            onPressed: ()
                                            {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      pageBuilder: (_, a1,
                                                          a2) => ViewProfile(snapshot.data.docs[position]['lender'])));

                                            },
                                            child: Expanded(child: Text('${snapshot.data.docs[position]['lender']}',maxLines: 1,style: TextStyle(fontStyle:FontStyle.italic,decoration:TextDecoration.underline,color: Colors.white),))),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.3),
                                      child: MaterialButton(
                                          elevation: 5,
                                          color: Color(0xffe2d2fe),
                                          hoverColor: Colors.blueGrey,
                                          child:Text("Return",style: TextStyle(fontSize: 16),),onPressed: (){
                                            returnRequest(widget.email!,snapshot.data.docs[position]['lender'],snapshot.data.docs[position]['id']);
                                            setState(() {

                                            });
                                      }
                                          ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                          );
                        }

                      else
                      {
                      return Padding(
                        padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.01,horizontal:MediaQuery.of(context).size.width*0.05 ),
                        child: (Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Color(0xffbaef54),
                          elevation: 5,
                          child: Container(
                            // width: MediaQuery.of(context).size.width,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal:
                                      MediaQuery.of(context).size.width *
                                          0.03),
                                  child: Text(snapshot.data
                                      .docs[position]['bookname'],style: TextStyle(fontSize:20,color: Colors.black),),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal:
                                      MediaQuery.of(context).size.width *
                                          0.03),
                                  child: Text('Status: Return Requested',style: TextStyle(fontSize:16,color: Colors.black),),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal:
                                      MediaQuery.of(context).size.width *
                                          0.03),
                                  child: Row(
                                    children: [
                                      Text('Lender: ',style: TextStyle(fontSize:16,color: Colors.black),),
                                      TextButton(
                                          onPressed: ()
                                          {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (_, a1,
                                                        a2) => ViewProfile(snapshot.data.docs[position]['lender'])));

                                          },
                                          child: Expanded(child: Text('${snapshot.data.docs[position]['lender']}',maxLines: 1,style: TextStyle(fontStyle:FontStyle.italic,decoration:TextDecoration.underline,color: Colors.black),))),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        )),
                      );
                    }
                    }));}
          } else
            return Scaffold(body: Center(child: LoadingBouncingGrid.square(
              backgroundColor: Colors.blue,
            )));
        });
  }

  Future returnRequest(String email,String emaill, String id) async{
    await FirebaseFirestore.instance.collection('users').doc(email).collection('borrowedbooks')
        .doc(id)
        .update({'status':'request'});

    await FirebaseFirestore.instance.collection('users').doc(emaill).collection('lendbooks')
        .doc(id)
        .update({'status':'request'});
  }
}
