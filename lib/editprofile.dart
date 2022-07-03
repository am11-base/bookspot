import 'package:bookspot/home_screen.dart';
import 'package:bookspot/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

import 'database.dart';

class EditProfile extends StatefulWidget {
  final String? email;
  final String? imgurl;
  const EditProfile(this.email, this.imgurl, {Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  File? picked1;
  UploadTask? task;
  String? url;
  bool isloading=false;
  final ImagePicker picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;
  final controller_name = TextEditingController();
  final controller_pswd = TextEditingController();
  final controller_phone = TextEditingController();

  Future<String> uploadFile(File file, String filename) async {
    //File file1=File(file);
    try {
      final ref = storage.ref().child('pics/$filename');
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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Edit Profile')),
        body: SingleChildScrollView(
          child: Stack(
            children:[ Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.05,
                        horizontal: MediaQuery.of(context).size.width * 0.4),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: picked1 == null
                              ? NetworkImage('${widget.imgurl!}') as ImageProvider
                              : FileImage(picked1!),
                          radius: 50,
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: InkWell(
                            onTap: () {
                              print('hello');
                              showModalBottomSheet(
                                  context: context,
                                  builder: (builder) => bottomsheet());
                            },
                            child: Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.black87,
                            ),
                          ),
                        )
                      ],
                    )),
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
                    controller: controller_pswd,
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
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02,
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  child: RaisedButton(
                    onPressed: () async {
                      if (picked1 != null) {
                        setState(() {
                          isloading=true;
                        });
                        final name = Path.basename(picked1!.path);
                        url = await uploadFile(picked1!, name);
                      } else
                        url = widget.imgurl;
                      final name1 = controller_name.text.trim();
                      final password = controller_pswd.text.trim();
                      final phoneno_s = controller_phone.text;
                      int phoneno = int.parse(phoneno_s);
                      final regexp =
                          RegExp(r'(^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$)');
                      dynamic noflag = regexp.hasMatch(phoneno_s);
                      if (noflag == true) {
                        var a = DatabaseServices().updateUser(
                            name: name1,
                            email: widget.email!,
                            password: password,
                            phone: phoneno,
                            pic: url!);
                        setState(() {
                          isloading=false;
                        });
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
                                pageBuilder: (_, a1, a2) => HomeScreen()));
                      } else {
                        String msg;
                        msg = "Invalid Number";

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
                    child: Text("Submit"),
                  ),
                )
              ],
            ),
              Opacity(
                opacity: isloading == true? 1 : 0,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*0.3,horizontal: MediaQuery.of(context).size.width*0.4),
                    child: CircularProgressIndicator(color: Colors.black87,)),
              )]
          ),
        ));
  }

  void takephoto(ImageSource imgsauce) async {
    final picked = await picker.pickImage(source: imgsauce,imageQuality: 70);
    if (picked == null) return;
    final path1 = picked.path;
    setState(() {
      picked1 = File(path1);
    });
  }

  Widget bottomsheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.03,
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                'Choose a Source',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    takephoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text("Camera"),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Colors.black87),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    takephoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.photo),
                  label: Text("Gallery"),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Colors.black87),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
