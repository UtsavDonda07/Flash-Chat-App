import 'package:flash_chat_app/Components/rounded_button.dart';
import 'package:flash_chat_app/constants.dart';
import 'package:flash_chat_app/networking/auto_login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: isVisible,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    height: 200.0,
                    child: Lottie.asset('assets/hello.json',height: 300),
                  ),
                ),
              ),

              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextfieldDecoratiuon.copyWith(
                  hintText: "Enter Your Email...",
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kTextfieldDecoratiuon,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colour: Color(0xff60e1c8),
                text: "Log In",
                onPressed: () async {
                  setState(() {
                    isVisible=true;
                  });

                  final loginUser = await _auth.signInWithEmailAndPassword(
                      email:  email,
                       password: password);
                  AuthController.login(email,password);
                  try {
                    if (loginUser != null) {
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                    setState(() {
                      isVisible=false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
           Text(AuthController.getEmail()),
        Text(AuthController.getPassward()),
            ],
          ),
        ),
      ),
    );
  }
}
