import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import 'addnote.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  
  CollectionReference ref = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser.uid)
    .collection('notes');
  
    List<Color> myColors = [
      Colors.yellow[200],
      Colors.red[200],
      Colors.green[200],
      Colors.deepPurple[200],
      Colors.purple[200],
      Colors.cyan[200],
      Colors.teal[200],
      Colors.tealAccent[200],
      Colors.pink[200],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context) .push(
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.grey[700]
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Random random = new Random();
                Color bg = myColors[random.nextInt(4)];
                Map data = snapshot.data.docs[index].data();
          
                return Card(
                  color: bg,
                  child: Column(
                    children: [
                      Text("${data['title']}",
                      ),            
                    ],
                  ),
                );
              },);
          }
          else {
            return Center(child: Text("Carregando..."),
            );
          }
        }),
    );
  }
}
