// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trail_blog/views/create_blog.dart';

final blogRef = FirebaseFirestore.instance.collection('Blog');

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  /*void initState() {
    getBlog();
    super.initState();
  }

  getBlog() {
    blogRef.getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((DocumentSnapshot doc) {
        print(doc.data);
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Liria ",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.5,
      ),
      body:
      
       StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Blog").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //   if (!snapshot.hasData) {
        //     return const Text("No data available");
        //   }
        //   //var documents;
        //   return ListView(
        //     children: snapshot.data.documents.map((document) {
        //       return Text(document['title']);
        //     }),
        //   );
         return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var temp = snapshot.data?.docs[index];
                return Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(50)),
                  //alignment: Alignment.topLeft,
                  
                  child: Card(
                    
                    child: Container(
                      //decoration: BoxDecoration(borderRadius:BorderRadius.circular(500)),
                      alignment: Alignment.topLeft,
                      width:MediaQuery.of(context).size.width * 0.75,
                      padding: EdgeInsets.all(20),
                      
                      child: Column(
                        
                        children: <Widget> [
                          Align(
                            alignment:Alignment(-1,0),
                            child: Text(
                            temp!['Title'],
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20),
                            textDirection: TextDirection.ltr,
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            height: 25,
                            thickness: 2,
                            indent: 5,
                            endIndent: 5,
                          ),
                         Align(
                           alignment: Alignment(-1,0),
                           child:Text(
                            temp['Author'],
                            textAlign: TextAlign.left,
                            style: TextStyle(fontStyle: FontStyle.italic,fontSize: 10),
                            ) ,
                         ),
                          Align(
                            alignment: Alignment(-1, 0),
                            child: Text(
                            temp['Desc'],
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                            ),
                          ),
                          
                        ],
                      ),
                      
                    ),
                    
                    //Text(temp!['Title']),
                  ),
                  
                );
              },
            );
        },
      ),
      //Container(),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => CreateBlog())));
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
