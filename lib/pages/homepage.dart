import 'dart:math';

import 'package:agenda/pages/viewnote.dart';
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

  String get formattedTime => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => AddNote(),
              ),
            )
                .then((value) {
              print("chamando estado setstate");
              setState(() {});
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.white70,
          ),
          backgroundColor: Colors.grey[700]),
      appBar: AppBar(
        title: Text(
          "Notas",
          style: TextStyle(
              fontSize: 32.0,
              fontFamily: "lato",
              fontWeight: FontWeight.bold,
              color: Colors.white60),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xff070706),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length == 0) {
              return Center(
                child: Text(
                  "N??o foi salvo",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Random random = new Random();
                Color bg = myColors[random.nextInt(4)];
                Map data = snapshot.data.docs[index].data();

                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => ViewNote(
                          data,
                          formattedTime,
                          snapshot.data.docs[index].reference,
                        ),
                      ),
                    )
                        .then(
                      (value) {
                        setState(() {});
                      },
                    );
                  },
                  child: Card(
                    color: bg,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data['title']}",
                            style: TextStyle(
                                fontSize: 34.0,
                                fontFamily: "lato",
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Carregando..."),
            );
          }
        },
      ),
    );
  }
}
