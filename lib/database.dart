import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices
{
  dynamic instance1=FirebaseFirestore.instance;
  Future<void> createUser({required String name,required String email,required String password,required int phone}) async
  {

    final docUser=instance1.collection('users').doc(email);
    Map<String,dynamic> data={
       'id':docUser.id,
      'name':name,
       'email':email,
      'password':password,
      'phone':phone


    };
    await docUser.set(data);


  }
}