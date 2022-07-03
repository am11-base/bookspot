import 'dart:ui';

import 'package:bookspot/authentication.dart';
import 'package:bookspot/database.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final controller_name = TextEditingController();
  final controller_email = TextEditingController();
  final controller_pswd = TextEditingController();
  final controller_phone = TextEditingController();
  bool passwordvisible = false;
  @override
  void initState() {
    passwordvisible = false;
  }

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
                      color: Colors.black87,
                      fontSize: 42.0,
                      letterSpacing: 2.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.03,
                    MediaQuery.of(context).size.height * 0.07,
                    0,
                    0),
                child: Text('Sign Up',
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
                  'Create an Account',
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
                  controller: controller_name,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.people),
                      fillColor: Colors.grey[400],
                      filled: true,
                      hintText: 'Name',
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
                  controller: controller_email,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      fillColor: Colors.grey[400],
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  keyboardType: TextInputType.emailAddress,
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
                        onPressed: () {
                          setState(() {
                            passwordvisible = !passwordvisible;
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
                    MediaQuery.of(context).size.width * 0.03,
                    MediaQuery.of(context).size.height * 0.04,
                    MediaQuery.of(context).size.width * 0.03,
                    0),
                child: TextField(
                  controller: controller_phone,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      fillColor: Colors.grey[400],
                      filled: true,
                      hintText: 'Mobile Number',
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
                    onPressed: () async {
                      final name = controller_name.text.trim();
                      final email = controller_email.text.trim();
                      final password = controller_pswd.text.trim();
                      final phoneno_s = controller_phone.text;

                      int phoneno = int.parse(phoneno_s);
                      final regexp =
                          RegExp(r'(^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$)');
                      dynamic noflag = regexp.hasMatch(phoneno_s);
                      dynamic flag = 'a';
                      if (noflag == true) {
                        flag = await Authentication().signUp(
                          email: email,
                          password: password,
                        );
                      }
                      if (flag == 'a' && noflag == true) {
                        var a = DatabaseServices().createUser(
                            name: name,
                            email: email,
                            password: password,
                            phone: phoneno,
                            image:"null"
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            elevation: 0,
                            duration: Duration(seconds: 1),
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
                        Future.delayed(Duration(milliseconds: 300), () {
                          // Do something
                        });
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, a1, a2) => Login()));
                      } else {
                        String msg;
                        if (noflag == false)
                          msg = "Invalid Number";
                        else
                          msg = flag;
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
                                msg,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),
                              ),
                            )));
                        print("hello");
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Sign Up",
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
                      MediaQuery.of(context).size.width * 0.06),
                  child: Text('Already have an Account?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.normal)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0,
                      MediaQuery.of(context).size.height * 0.04,
                      0,
                      MediaQuery.of(context).size.width * 0.06),
                  child: TextButton(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue[900]),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, a1, a2) => Login()));
                    },
                  ),
                )
              ]),
            ])),
      ),
    );
  }
}
