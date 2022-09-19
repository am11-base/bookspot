import 'package:bookspot/viewprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class LendView extends StatefulWidget {
  final String? email;
  const LendView(this.email, {Key? key}) : super(key: key);

  @override
  _LendViewState createState() => _LendViewState();
}

class _LendViewState extends State<LendView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:FirebaseFirestore.instance.collection('users').doc(widget.email).collection('lendbooks').get(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      print(snapshot.data.docs.length);
      if (snapshot.data.docs.length == 0) {
        return Scaffold(
          appBar: AppBar(title: Text("Lent Books",style: TextStyle(color: Colors.black),),elevation:0,centerTitle: true,backgroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.black),),
          body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.4,
                horizontal:
                MediaQuery.of(context).size.width * 0.1),
            child: Center(
              child: Text(
                "No Book Found",
                style:
                TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
          ),
        );
      } else {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lent Books",style: TextStyle(color: Colors.black)),
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
                  padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.01,horizontal:MediaQuery.of(context).size.width*0.04 ),
                  child: (Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Color(0xff7d9d9c),
                    elevation: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.2,
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
                                      color: Colors.white)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.03),
                            child: Text('Status: inhand', style: TextStyle(
                                fontSize: 15,
                                color: Colors.white)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.03),
                            child:Row(
                              children: [
                                Text('Borrower:',style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white)),
                              TextButton(
                                onPressed: ()
                                {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, a1,
                                              a2) => ViewProfile(snapshot.data.docs[position]['borrower'])));

                                },
                                child: Text('${snapshot.data.docs[position]['borrower']}',maxLines: 1, style: TextStyle(
                                    fontStyle:FontStyle.italic,decoration:TextDecoration.underline,
                                      color: Colors.white)),
                              ),
                              ],
                            ),
                          ),

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
                          .height * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding:EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal:
                                MediaQuery.of(context).size.width *
                                    0.03),
                            child: Center(
                              child: Text(snapshot.data
                                  .docs[position]['bookname'],textAlign: TextAlign.center,style: TextStyle(
                                fontSize: 20,)),
                            ),
                          ),
                          Padding(
                            padding:EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal:
                                MediaQuery.of(context).size.width *
                                    0.03),
                            child: Text('Status: Return Requested', style: TextStyle(
                              fontSize: 15,)),
                          ),
                          Padding(
                            padding:EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal:
                                MediaQuery.of(context).size.width *
                                    0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Borrower:', style: TextStyle(
                                  fontSize: 15,)),
                            TextButton(
                              onPressed: ()
                              {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, a1,
                                            a2) => ViewProfile(snapshot.data.docs[position]['borrower'])));

                              },
                              child: Text('${snapshot.data.docs[position]['borrower']}',maxLines:1,style: TextStyle(fontStyle:FontStyle.italic,decoration:TextDecoration.underline,
                                   color: Colors.black),),
                            ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal:
                                MediaQuery.of(context).size.width *
                                    0.3),
                            child: MaterialButton(
                                elevation: 5,
                                color: Color(0xfffadff8),
                                hoverColor: Colors.blueGrey,
                                child:Text("Accept",style: TextStyle(fontSize: 15,color: Colors.black),),onPressed: (){
                              returnAccept(widget.email!,snapshot.data.docs[position]['borrower'],snapshot.data.docs[position]['id']);
                              updateBook(snapshot.data.docs[position]['bookid']);
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
            }));}}
        else
      return Scaffold(body: Center(child: LoadingBouncingGrid.square(
        backgroundColor: Colors.blue,
      )));
        });
  }

 Future returnAccept(String email, String emailb,String id) async{
    await FirebaseFirestore.instance.collection('users').doc(email).collection('lendbooks')
        .doc(id).delete();
    await FirebaseFirestore.instance.collection('users').doc(emailb).collection('borrowedbooks')
        .doc(id).delete();


  }

  Future updateBook(String bid) async {
    await FirebaseFirestore.instance
        .collection('books')
        .doc(bid)
        .update({'status': "available"});
  }
}
