import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              SingleChildScrollView(
                child: Container(
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
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
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
                    color: Colors.lightGreen,
                    onPressed: () {},
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
      ),
    );
  }
}
