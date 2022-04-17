import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({Key? key}) : super(key: key);

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  GoogleSignIn _googleSignIn=GoogleSignIn();
  GoogleSignInAccount? _user;
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            FlatButton(
                onPressed: (){}
                ,
                child: Text("login"),
            ),
          ],
        ),
      ),
    );
  }
}
