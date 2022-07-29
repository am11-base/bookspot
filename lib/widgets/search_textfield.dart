import 'package:bookspot/navdrawer.dart';
import 'package:bookspot/viewbooks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

import '../add_books.dart';

class Search_Textfield_BookSpot extends StatefulWidget {
  final String? email;

  const Search_Textfield_BookSpot(this.email, {Key? key}) : super(key: key);

  @override
  State<Search_Textfield_BookSpot> createState() =>
      _Search_Textfield_BookSpotState();
}

class _Search_Textfield_BookSpotState extends State<Search_Textfield_BookSpot> {
  final controller_search=TextEditingController();
  String? field;
  void initState() {
    super.initState();

    // Start listening to changes.
    controller_search.addListener(printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    controller_search.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      drawer: DrawerMain(widget.email),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                //obscureText: true,
                controller: controller_search,
                decoration: InputDecoration(
                  hintText: 'Search For Book Name',
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            //  FutureBuilder(builder: builder)
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('books')
                    .where("status", isEqualTo: "available")
                    .where("email", isNotEqualTo: widget.email)
                    .get(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    print(snapshot.data.docs.length);
                    String search=controller_search.text.trim();
                    /* snapshot.data.docs.forEach((element){
               print(element.get('title'));
             });*/
                    // print(snapshot.data.docs[2]['title']);
                    if (snapshot.data.docs.length == 0) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.4,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: Center(
                          child: Text(
                            "No Book Found",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          ),
                        ),
                      );
                    } else {
                      List<Map<String,String>> bookMap=[];
                      int k=0;
                      if(search.isEmpty){
                        for(int i=0;i<snapshot.data.docs.length;i++)
                        {
                          if((snapshot.data.docs[i]["title"]).contains(search)==true)
                          {
                            String title=snapshot.data.docs[i]["title"];
                            String category=snapshot.data.docs[i]["category"];
                            String email=snapshot.data.docs[i]["email"];
                            String id=snapshot.data.docs[i]["id"];
                            String status=snapshot.data.docs[i]["status"];
                            String author=snapshot.data.docs[i]["author"];
                            String url=snapshot.data.docs[i]["url"];

                            bookMap.insert(k,{'title':title,'category':category,'email':email,'id':id,'status':status,'author':author,'url':url});
                            k++;
                          }
                        }
                      return (ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: bookMap.length,
                          itemBuilder: (_, int position) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * 0.01,
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.03),
                              child: (Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Color(0xFFf3ffe9),
                                surfaceTintColor: Colors.black,
                                shadowColor: Colors.grey,
                                elevation: 4,
                                child: InkWell(
                                  onTap: () {
                                    print("clicked");
                                    print(bookMap[position]
                                        ['category']);
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (_, a1, a2) =>
                                                ViewBooks(
                                                    bookMap[position],
                                                    widget.email)));
                                  },
                                  child: Container(
                                    // width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                                bookMap[position]
                                                    ['title']!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                //    fontFamily: 'Pacifico'
                                                )),
                                          ),
                                          Text(
                                              "Author : ${bookMap[position]['author']}",textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                              //    fontFamily: 'Pacifico'
                                              )),
                                          Text(
                                              "Category : ${bookMap[position]['category']}",textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  //fontFamily: 'Pacifico'
                                                ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                            );
                          }));}
                        else
                          {
                            List<Map<String,String>> bookMap=[];
                            int k=0;
                            for(int i=0;i<snapshot.data.docs.length;i++)
                              {
                                if((snapshot.data.docs[i]["title"]).contains(search)==true)
                                  {
                                    String title=snapshot.data.docs[i]["title"];
                                    String category=snapshot.data.docs[i]["category"];
                                    String email=snapshot.data.docs[i]["email"];
                                    String id=snapshot.data.docs[i]["id"];
                                    String status=snapshot.data.docs[i]["status"];
                                    String author=snapshot.data.docs[i]["author"];
                                    String url=snapshot.data.docs[i]["url"];

                                    bookMap.insert(k,{'title':title,'category':category,'email':email,'id':id,'status':status,'author':author,'url':url});
                                    k++;
                                  }
                              }
                           // print(bookMap[0]);
                            print(bookMap.length);
                            int searchlength=bookMap.length;
                            if(searchlength==0)
                              {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: MediaQuery.of(context).size.height * 0.4,
                                      horizontal:
                                      MediaQuery.of(context).size.width * 0.1),
                                  child: Center(
                                    child: Text(
                                      "No Book Found",
                                      style:
                                      TextStyle(fontSize: 18, color: Colors.black87),
                                    ),
                                  ),
                                );
                              }
                            else
                              {

                            return(ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: searchlength,
                                itemBuilder: (_, int position) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                        MediaQuery.of(context).size.height * 0.01,
                                        horizontal:
                                        MediaQuery.of(context).size.width * 0.03),
                                    child: (Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      color: Color(0xFFf3ffe9),
                                      surfaceTintColor: Colors.black,
                                      shadowColor: Colors.grey,
                                      elevation: 4,
                                      child: InkWell(
                                        onTap: () {
                                          print("clicked");
                                          print(bookMap[position]
                                          ['category']);
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder: (_, a1, a2) =>
                                                      ViewBooks(
                                                          bookMap[position],
                                                          widget.email)));
                                        },
                                        child: Container(
                                          // width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height *
                                              0.2,
                                          width:
                                          MediaQuery.of(context).size.width * 0.5,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.01,
                                                horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.05),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    bookMap[position]
                                                    ['title']!
                                                ,textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        //fontFamily: 'Pacifico'
                                                      )),
                                                Text(
                                                    "Author: ${bookMap[position]['author']}",textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                    //    fontFamily: 'Pacifico'
                                                    )),
                                                Text(
                                                    "Category: ${bookMap[position]['category']}",textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        //fontFamily: 'Pacifico'
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                                  );
                                }
                                ));}
                          }
                    }
                  } else
                    return LoadingBouncingGrid.square(
                      backgroundColor: Colors.blue,
                    );

                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Color(0xFF3d3c42),
        child: Icon(Icons.add),
        onPressed: () {
          print(widget.email);
          Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, a1, a2) => AddBooks(widget.email)));
        },
      ),
    );
  }

  void printLatestValue() {

    String field=controller_search.text.trim();
    setState(() {
    });


  }
}
