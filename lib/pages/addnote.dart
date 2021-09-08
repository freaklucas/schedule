import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  @override
  _AddnoteState createState() => _AddnoteState();
}

class _AddnoteState extends State<AddNote> {
  String title;
  String des;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(
          12.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 24.0,
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue[800]),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 8.0,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: add,
                  child: Text(
                    "Salvar",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: "lato",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.green[500],
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 8.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration.collapsed(
                      hintText: "Título",
                    ),
                    style: TextStyle(
                        fontSize: 38.0,
                        fontFamily: "lato",
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    onChanged: (_val) {
                      title = _val;
                    },
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                      decoration: InputDecoration.collapsed(
                        hintText: "Descrição",
                      ),
                      style: TextStyle(
                          fontSize: 19.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      onChanged: (_val) {
                        des = _val;
                      },
                      maxLines: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    ));
  }

  void add() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('notes');
  
  var data = {
    'title': title,
    'description': des,
  };

  ref.add(data);

  Navigator.pop(context);

  }
}
