import 'package:agenda/pages/homepage.dart';
import 'package:agenda/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Pessoal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.grey[800],
        accentColor: Colors.purple,
        scaffoldBackgroundColor: Color(0xff070706),
      ),
      home:
      FirebaseAuth.instance.currentUser == null ? LoginPage() : HomePage(),
    );
  }
}
