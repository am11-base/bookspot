import 'package:bookspot/authentication.dart';
import 'package:bookspot/borrowedbooks.dart';
import 'package:bookspot/help.dart';
import 'package:bookspot/lendedbooks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class DrawerMain extends StatefulWidget {
  final String? email;
  const DrawerMain(this.email, {Key? key}) : super(key: key);

  @override
  _DrawerMainState createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade300,
        child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc('${widget.email}')
                .get(),
            builder: (BuildContext context,  snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data);
                Map data=snapshot.data!.data() as Map;
                String name = data['name'];
                print(name);
                return ListView(
                  children: [

                    DrawerHeader(child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hi, ${name} ",style: TextStyle(color: Colors.blueAccent,fontSize: 25),),
                        Icon(Icons.waving_hand,color: Colors.blueGrey,)
                      ],
                    ),
                      decoration: BoxDecoration(
                        color: Color(0xffffee63),
                          image:DecorationImage(
                              image: AssetImage('assets/drawer.jpg')
                          )
                      ),
                    ),
                    Container(
                      child: Column(

                      children:[
                      ListTile(
                        leading:Icon( Icons.book_rounded),
                        title: Text("Borrowed Books",style: TextStyle(fontSize: 18),),
                        onTap: (){
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, a1, a2) =>BorrowedList(widget.email)));
                        },

                      ),
                      ListTile(
                        leading:Icon( Icons.book_online_outlined),
                        title: Text("Lent Books",style: TextStyle(fontSize: 18),),
                        onTap: (){
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, a1, a2) => LendView(widget.email
                                  )));
                        },

                      ),
                      ListTile(
                        leading:Icon( Icons.help_outline_outlined),
                        title: Text("Help",style: TextStyle(fontSize: 18),),
                        onTap: (){
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, a1, a2) =>Help(widget.email)));
                        },

                      ),
                      ListTile(
                        leading:Icon( Icons.logout),
                        title: Text("Log out",style: TextStyle(fontSize: 18),),
                        onTap: (){
                          logout();
                        },

                      ),
                      ]
                      ),
                    )

                  ],
                );
              } else
                return Center(child: CircularProgressIndicator());
            }));
  }
  Future logout() async {
    await Authentication().logout().then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()),(route) => false));
  }
  }

