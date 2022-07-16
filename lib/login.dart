import 'dart:ui';

import 'package:bookspot/authentication.dart';
import 'package:bookspot/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isloading=false;
  final controller_email=TextEditingController();
  final controller_pswd=TextEditingController();
 bool passwordvisible=false;
  @override
  void initState()
  {
    Authentication().getCurrentUser().then((user) {
        if (user != null) { //if there isn't any user currentUser function returns a null so we should check this case.
          Navigator.pushAndRemoveUntil(
            // we are making YourHomePage widget the root if there is a user.
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false);
        }
      });
      super.initState();

    passwordvisible=false;
  }
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children:[ Container(
              //padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0., MediaQuery.of(context).size.height * 0.01,0,0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/white.jpg'), fit: BoxFit.cover)),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                ),

                  Container(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.3,
                        MediaQuery.of(context).size.height * 0.1,
                        0,
                        MediaQuery.of(context).size.height * 0.04),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/logo1.jpeg'),
                      radius: 70,
                    ),
                  ),

                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.15, 0, 0, 0),
                  child: Text(
                    'BOOK SPOT',
                    style: TextStyle(
                        color: Colors.black87, fontSize: 42.0, letterSpacing: 2.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.03,
                      MediaQuery.of(context).size.height * 0.07,
                      0,
                      0),
                  child: Text('Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.03,
                      MediaQuery.of(context).size.height * 0.01,
                      0,
                      0),
                  child: Text(
                    'Please Sign in to Continue',
                    style: TextStyle(
                        color: Colors.grey, fontSize: 17.0, letterSpacing: 2.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.03,
                      MediaQuery.of(context).size.height * 0.04,
                      MediaQuery.of(context).size.width * 0.03,
                      0),
                  child: TextField(
                    controller: controller_email,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        fillColor: Colors.grey[400],
                        filled: true,
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.03,
                      MediaQuery.of(context).size.height * 0.04,
                      MediaQuery.of(context).size.width * 0.03,
                      0),
                  child: TextField(
                    controller: controller_pswd,
                    obscureText: !passwordvisible,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(

                          Icons.remove_red_eye,
                          ),
                          onPressed: ()
                          {
                            setState(() {
                              passwordvisible=!passwordvisible;
                            });
                          },

                        ),
                        fillColor: Colors.grey[400],
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.3,
                        MediaQuery.of(context).size.height * 0.05,
                        MediaQuery.of(context).size.width * 0.3,
                        0),
                    child: RaisedButton(
                      color: Colors.black87,
                      onPressed: ()async
                      {

                       final email=controller_email.text.trim();
                       final pswd=controller_pswd.text.trim();
                       if(email.compareTo("")==0||pswd.compareTo("")==0){
                         ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                                 backgroundColor: Colors.red,
                                 behavior: SnackBarBehavior.floating,
                                 elevation: 0,
                                 duration: Duration(seconds: 2),
                                 content: Container(
                                   decoration: BoxDecoration(
                                       color: Colors.transparent,
                                       borderRadius: BorderRadius.all(Radius.circular(20))
                                   ),
                                   child: Text(
                                     "Please Enter the details",
                                     style: TextStyle(
                                         fontStyle: FontStyle.italic,
                                         color: Colors.white
                                     ),
                                   ),

                                 )
                             )
                         );}
                       else{
                         setState(() {
                           isloading=true;
                         });


                        dynamic result =await Authentication().signIn(email: email, password: pswd);
                        setState(() {
                          isloading=false;
                        });
                        if(result==1)
                          {
                            Navigator.push(context,
                                PageRouteBuilder(pageBuilder: (_, a1, a2) => HomeScreen()));
                            print("hello new user");
                          }
                        else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 0,
                                    duration: Duration(seconds: 2),
                                    content: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child: Text(
                                        result,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white
                                        ),
                                      ),

                                    )
                                )
                            );
                          }
                       }}
                      ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Log in",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )),
                Row(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.06,
                        MediaQuery.of(context).size.height * 0.04,
                        0,
                        0),
                    child: Text('Don\'t have an Account?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.normal)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height * 0.04, 0, 0),
                    child: TextButton(
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[900]),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            PageRouteBuilder(pageBuilder: (_, a1, a2) => SignUp()));
                      },
                    ),
                  )
                ]),
              ])),
            Opacity(
              opacity: isloading== true? 1 : 0,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*0.3,horizontal: MediaQuery.of(context).size.width*0.4),
                  child: CircularProgressIndicator(color: Colors.pink,)),
            )
          ]
        ),

    )
    );
  }
}
