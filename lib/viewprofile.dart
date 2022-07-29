import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewProfile extends StatefulWidget {
  final String email;
  const ViewProfile(this.email, {Key? key}) : super(key: key);

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.email)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            String imageurl=snapshot.data['image'];
            if(imageurl.compareTo("null")==0)
              imageurl="https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png";
            return Scaffold(
              backgroundColor: Colors.grey,
              body: (AlertDialog(
                  content: Container(
                      height: MediaQuery.of(context).size.height*0.4,
                      width:MediaQuery.of(context).size.width,
                      child: Column(children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(children: [
                      CircleAvatar(
                          radius:70,
                          backgroundImage: FadeInImage.assetNetwork(
                                  placeholder: 'assets/Loading_2.gif',
                                  image: imageurl)
                              .image),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height *
                                    0.02),
                        child: Center(
                          child: Text(
                            '${snapshot.data['name']}',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              // fontFamily: "Pacifico",
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text('${snapshot.data['email']}',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              //fontFamily: "Pacifico",
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.02),
                            child: Center(
                              child: Text('${snapshot.data['phone']}',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    //fontFamily: "Pacifico",
                                  )),
                            ),
                          ),
                          IconButton(icon: Icon(
                            Icons.message, color: Colors.green,
                            size: 30,), onPressed: () {
                            message(snapshot.data["phone"]);

                          }),
                          IconButton(icon: Icon(
                            Icons.call, color: Colors.green,
                            size: 30,), onPressed: () {
                          call(snapshot.data["phone"]);

                          })
                        ],
                      ),
                    ]))
              ]))
              ,
                actions: [MaterialButton(child:Text("OK"),onPressed: (){
                  Navigator.pop(context);

                }),],
              )),
            );
          } else
            return Scaffold(body: Center(child: LoadingBouncingGrid.square(
              backgroundColor: Colors.blue,
            )));
        });
  }
  message(int no) async{

    Uri smsUri = Uri(scheme: 'sms', path:"${no}");

    try {
      print(smsUri.toString());
      if (await canLaunchUrl(
        smsUri,
      )) {
        await launchUrl(smsUri);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text('Some error occured'),
        ),
      );
    }

  }

  call(int no) async {
    try {
      if (await canLaunchUrl(Uri.parse("tel:${no}")
      )) {
        await launchUrl(Uri.parse("tel:${no}"));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text('Some error occured'),
        ),
      );
    }
  }
}
