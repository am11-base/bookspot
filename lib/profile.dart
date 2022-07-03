import 'package:bookspot/editprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        color: const Color(0XFFF3F8FE),
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
                                          backgroundImage:NetworkImage('${imageurl}')

                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                        child: Row(children: [
                                          /*Text(
                                      "Name : ",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Pacifico",
                                      ),
                                    ),*/
                                          Text(
                                            '${snapshot.data['name']}',
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Pacifico",
                                            ),
                                          ),
                                        ]),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                            MediaQuery.of(context).size.width *
                                                0,
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                        child: Row(children: [
                                          /*Text(
                                      "Name : ",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Pacifico",
                                      ),
                                    ),*/
                                          Text('${snapshot.data['email']}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Pacifico",
                                              )),
                                          Container(
                                            height: 40,
                                            child: VerticalDivider(
                                              thickness: 5,
                                              color: Colors.green,
                                            ),
                                          ),
                                          Text('${snapshot.data['phone']}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Pacifico",
                                              )),
                                        ]),
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
                                          color:Colors.lightGreen,
                                          child: Text('Edit Profile'),
                                          onPressed: (){
                                            Navigator.push(context,
                                                PageRouteBuilder(pageBuilder: (_, a1, a2) => EditProfile(email,imageurl)));
                                          },
                                        ),
                                      ),

                                      //Text('${snapshot.data['email']}'),
                                      //Text('${snapshot.data['password']}'),
                                    ],
                                  ),
                                ),
                              ),
                            ]);
                          } else
                            return Center(
                              child: CircularProgressIndicator(),
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
}
