import 'package:bookspot/authentication.dart';
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
        child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc('${widget.email}')
                .get(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                String name = snapshot.data['name'];
                print(name);
                return ListView(
                  children: [

                    DrawerHeader(child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hi , ${name} ",style: TextStyle(color: Colors.blueAccent,fontSize: 25),),
                        Icon(Icons.waving_hand,color: Colors.blueGrey,)
                      ],
                    ),
                      decoration: BoxDecoration(
                          image:DecorationImage(
                              image: AssetImage('assets/drawer.jpg')
                          )
                      ),
                    ),

                    ListTile(
                      leading:Icon( Icons.help_outline_outlined),
                      title: Text("Help",style: TextStyle(fontSize: 18),),
                      onTap: (){},

                    ),
                    ListTile(
                      leading:Icon( Icons.logout),
                      title: Text("Log out",style: TextStyle(fontSize: 18),),
                      onTap: (){
                        logout();
                      },

                    ),


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

