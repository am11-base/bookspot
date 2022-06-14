import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'database.dart';

class Authentication {
  final auth = FirebaseAuth.instance;

  Future signUp({required String email, required String password}) async {

    try {

      UserCredential user= await auth
          .createUserWithEmailAndPassword(email: email, password: password);

    }
    catch (e) {

      print("error is ${e.toString()}");
      String a=e.toString();
      String a1=(a.substring(a.indexOf(']')+1,a.length));
      return a1;
    }
    return 'a';
  }

  Future signIn({required String email, required String password}) async{
    try {
       await auth.signInWithEmailAndPassword(email: email, password: password);
    }
    catch(e)
    {
      print(e.toString());
      String a=e.toString();
      String a1=(a.substring(a.indexOf(']')+1,a.indexOf('.')));
      return a1;
    }
    return 1;
  }

}