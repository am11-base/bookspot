

import 'package:bookspot/AddBook.dart';
import 'package:bookspot/editprofile.dart';
import 'package:bookspot/widgets/add_image_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'add_books.dart';
import 'authentication.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  String? email;
  String? imageurl;

  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        color:Colors.blueGrey[800],
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: Authentication().getCurrentUser(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    User a = snapshot.data;
                    email = a.email;
                    return (FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc('${email}')
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            imageurl=snapshot.data['image'];
                            if(imageurl?.compareTo("null")==0)
                              imageurl="https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png";

                            return Column(children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage:FadeInImage.assetNetwork(
                                          placeholder:'assets/Loading_2.gif' ,
                                          image:imageurl!).image

                                        ),
                                      ),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.center,children: [

                                        /*Text(
                                      "Name : ",
                                      style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Pacifico",
                                      ),
                                    ),*/
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.02),
                                          child: Center(
                                            child: Text(
                                              '${snapshot.data['name']}',
                                              style: TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                               // fontFamily: "Pacifico",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      Center(
                                        child: Text('${snapshot.data['email']}',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              //fontFamily: "Pacifico",
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.02),
                                        child: Center(
                                          child: Text('${snapshot.data['phone']}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                //fontFamily: "Pacifico",
                                              )),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        child: RaisedButton(
                                          color:Color(0xFF7f85f8),
                                          child: Text('Edit Profile',style:TextStyle(fontSize: 16,color: Colors.black,fontFamily:"Pacifio"),),
                                          onPressed: (){
                                            Navigator.push(context,
                                                PageRouteBuilder(pageBuilder: (_, a1, a2) => EditProfile(snapshot,imageurl)));
                                          },
                                        ),
                                      ),

                                      //Text('${snapshot.data['email']}'),
                                      //Text('${snapshot.data['password']}'),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(

                          padding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                                child: InkWell(
                                  child: Container(
                                    width:MediaQuery.of(context).size.width*1,
                                    height:MediaQuery.of(context).size.width*0.1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),


                                    child: Center(child: Text("BookSpot Coins",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                                  ),
                                  onTap: ()async{
                                   int coin= await getcoin(email);
                                    showDialog(context: context, builder: (BuildContext context)=>Container(
                                      width: 300,
                                      child: AlertDialog(
                                        title: Text("BookSpot Coins"),
                                        content: Text("Coins Earned : ${coin}"),
                                        actions: [
                                          MaterialButton(child:Text("OK"),onPressed: (){
                                            Navigator.pop(context);

                                          }),
                                          MaterialButton(child:Text("Earn More"),onPressed: (){
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (_, a1, a2) =>
                                                        AddBooks(email)));

                                          }),

                                        ],
                                      ),
                                    ));
                                  },
                                ),
                              ),
                              Padding(

                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: InkWell(
                                  child: Container(
                                    width:MediaQuery.of(context).size.width*1,
                                    height:MediaQuery.of(context).size.width*0.1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),


                                    child: Center(child: Text("View Added Books",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                                  ),
                                  onTap: (){

                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (_, a1, a2) =>
                                                  ViewAddedBook(email)));

                                  },
                                ),
                              )
                            ]);
                          } else
                            return Center(
                              child: LoadingBouncingGrid.square(
                                backgroundColor: Colors.blue,
                              ),
                            );
                        }));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ));
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


}

class ViewAddedBook extends StatefulWidget {
  final String? email;
  const ViewAddedBook(this.email, {Key? key}) : super(key: key);

  @override
  _ViewAddedBookState createState() => _ViewAddedBookState();
}

class _ViewAddedBookState extends State<ViewAddedBook> {
  @override
  Widget build(BuildContext context) {
    return (FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('books')
            .where("email", isEqualTo: widget.email)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data.docs.length);
            /* snapshot.data.docs.forEach((element){
               print(element.get('title'));
             });*/
            // print(snapshot.data.docs[2]['title']);
            if (snapshot.data.docs.length == 0) {
              return Scaffold(
                appBar: AppBar(title: Text("Added Books",style: TextStyle(color: Colors.black),),elevation:0,centerTitle: true,backgroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.black),),
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
                appBar: AppBar(title: Text("Added Books",style: TextStyle(color: Colors.black),),elevation:0,centerTitle: true,backgroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.black),),
                body: (ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (_, int position) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (Card(
                          color:  Color(0xffbaef54),
                          elevation: 5,
                          child: InkWell(
                            onTap: () {
                              print("clicked");
                              print(
                                  snapshot.data.docs[position]['category']);
                            },
                            child: Expanded(
                              child: Container(
                                // width: MediaQuery.of(context).size.width,
                               // height:
                                //MediaQuery.of(context).size.height * 0.2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03),
                                      child: Text(
                                          snapshot.data.docs[position]['title'],
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.black)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03),
                                      child: Text("Author : ${
                                          snapshot.data.docs[position]['author']}",
                                          style: TextStyle(
                                              fontSize: 17, color: Colors.black)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03),
                                      child: Text("Category : ${
                                          snapshot.data.docs[position]['category']}",
                                          style: TextStyle(
                                              fontSize: 17, color: Colors.black)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.35),
                                      child: MaterialButton(color:Color(0xffe2d2fe),child: Text("Delete"),onPressed: ()async{
                                        if((snapshot.data.docs[position]['status']).compareTo("notavailable")==0)
                                          {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                backgroundColor: Colors.red,
                                                behavior: SnackBarBehavior.floating,
                                                elevation: 0,
                                                content: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(20))),
                                                  child: Text(
                                                    "Cannot Delete as book is lended",
                                                    style: TextStyle(
                                                        fontStyle: FontStyle.italic,
                                                        color: Colors.white),
                                                  ),
                                                )));
                                          }
                                        else
                                          {
                                            updatecoin(widget.email);
                                            await FirebaseFirestore.instance.collection('books').doc(snapshot.data.docs[position]['id']).delete();
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                backgroundColor: Colors.red,
                                                behavior: SnackBarBehavior.floating,
                                                elevation: 0,
                                                content: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(20))),
                                                  child: Text(
                                                    "Successfull",
                                                    style: TextStyle(
                                                        fontStyle: FontStyle.italic,
                                                        color: Colors.white),
                                                  ),
                                                )));
                                          }
                                        setState(() {
                                        });
                                      },),
                                    )

                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                      );
                    })),
              );
            }
          } else
            return Scaffold(body: Center(child: CircularProgressIndicator()));
        }));
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
  Future updatecoin(String? email) async{
    int coin=await getcoin(email);
    int ncoin=coin-25;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .update({'coin': ncoin});
  }
}

