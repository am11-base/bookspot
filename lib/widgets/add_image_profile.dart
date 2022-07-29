import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:path/path.dart' as Path;
import 'package:audioplayers/audioplayers.dart';

import '../home_screen.dart';

class AddImageProfile extends StatefulWidget {
  final String? email;
  const AddImageProfile(this.email, {Key? key}) : super(key: key);

  @override
  State<AddImageProfile> createState() => _AddImageProfileState();
}

class _AddImageProfileState extends State<AddImageProfile> {
  final player = AudioPlayer();
  bool isloading = false;
  final author1 = TextEditingController();
  final title1 = TextEditingController();
  final category1 = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String? url;
  FirebaseStorage storage = FirebaseStorage.instance;
  UploadTask? task;
  File? _images;
  Future<String> uploadFile(File file, String filename) async {
    //File file1=File(file);
    try {
      final ref = storage.ref().child('books/$filename');
      task = ref.putFile(file);
      final snapshot = await task!.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      print(url);
      return url;
    } catch (e) {
      print(e.toString());
      print("error");
      return "null";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Stack(children: [
        Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.width * 0.01),
            child: Text(
              'Add Book Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.01,
                MediaQuery.of(context).size.height * 0.03,
                MediaQuery.of(context).size.width * 0.01,
                MediaQuery.of(context).size.height * 0.02),
            //child: Image.asset('assets/images/profile1.png'),

            child: ElevatedButton.icon(
              onPressed: () {
                takephoto(ImageSource.gallery);
              },
              icon: Icon(Icons.photo),
              label: Text("Pick"),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  backgroundColor: MaterialStateProperty.all(Color(0xFFeceaf6)),
            ),
          )),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.03),
            child: TextField(
              controller: title1,
              decoration: InputDecoration(
                hintText: 'Add Book Title',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.03),
            child: TextField(
              controller: author1,
              decoration: InputDecoration(
                hintText: 'Add Author Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.03),
            child: TextField(
              controller: category1,
              decoration: InputDecoration(
                hintText: 'Category',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          /*ElevatedButton(onPressed: () {},
                  child: Text('Submit'),
              ),*/
          Padding(
            padding: EdgeInsets.fromLTRB(100, 30, 150, 50),
          ),
          MaterialButton(
            color: Color(0xff5ab79d),
            onPressed: () async {
              if (_images == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    elevation: 0,
                    content: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        "Please Select an image",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      ),
                    )));
              } else {
                final author = author1.text.trim();
                final title = title1.text.trim();
                final category = category1.text.trim();
                print(author);

                if (author.isEmpty || title.isEmpty || category.isEmpty) {
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
                          "Details not filled",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, color: Colors.white),
                        ),
                      )));
                } else {
                  setState(() {
                    isloading = true;
                  });
                  final name = Path.basename(_images!.path);
                  url = await uploadFile(_images!, name);
                  createBook(
                      title: title,
                      author: author,
                      category: category,
                      url: url,
                      email: widget.email);
                  setState(() {
                    isloading = false;
                  });

                  /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                              fontStyle: FontStyle.italic, color: Colors.white),
                        ),
                      )));*/
                  await updatecoin(widget.email);
                  await player.play(AssetSource('sound.mp3'));
                  showDialog(context: context, builder: (BuildContext context)=>Container(
                    width: 300,
                    child: AlertDialog(
                      title: Text("Congratulations"),
                      content: Text("You have earned 25 coins!"),
                      actions: [
                        MaterialButton(child:Text("OK"),onPressed: (){
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, a1, a2) => HomeScreen()));
                        })
                      ],
                    ),
                  ));

                }
              }
            },
            child: Text('Submit',style: TextStyle(fontSize: 20,color: Colors.white),),

          ),
        ]),
        Opacity(
          opacity: isloading == true? 1 : 0,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*0.3,horizontal: MediaQuery.of(context).size.width*0.4),
              child: LoadingBouncingGrid.square(
                backgroundColor: Colors.blue,
              )),
        )
      ])),
    );
  }

  Future createBook(
      {required String title,
      required String author,
      required String category,
      String? url,
      String? email}) async {
    final docBook = FirebaseFirestore.instance.collection('books').doc();
    final json = {
      'id':docBook.id,
      'status':'available',
      'title': title,
      'author': author,
      'category': category,
      'url': url,
      'email': email
    };
    try {
      await docBook.set(json);
    } catch (e) {
      print(e);
    }
  }

  void takephoto(ImageSource imgsauce) async {
    final picked = await picker.pickImage(source: imgsauce);
    if (picked == null) return;
    final path1 = picked.path;
    setState(() {
      _images = File(path1);
    });
  }

  Future updatecoin(String? email) async{
    int coin=await getcoin(email);
    int ncoin=coin+25;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .update({'coin': ncoin});
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
