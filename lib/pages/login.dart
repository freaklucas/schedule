import 'package:agenda/controller/google_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/agenda.png",
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 12.0,
              ),
              child: Text("Crie suas anotações",
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: "lato",
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  signInWithGoogle(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Continue com o Google",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "lato",
                        ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Image.asset(
                      'assets/images/google.png',
                      height: 30.0,

                    )
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.yellow[800],
                  ),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  )
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            )
          ],
        ),
      ),
    );
  }
}
