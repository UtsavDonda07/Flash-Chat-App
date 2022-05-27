import 'package:flash_chat_app/constants.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_app/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

import 'home_screen.dart';

final _firestore = FirebaseFirestore.instance;

class RegistrationScreen extends StatefulWidget {
  static String id = "resistration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;
  late String name;
  late String MobileNo;
  final _auth = FirebaseAuth.instance;
  bool isVisible = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LoadingOverlay(
        isLoading: isVisible,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Flexible(
              //   child: Hero(
              //     tag: "logo",
              //     child: Container(
              //       height: 200.0,
              //       child: Lottie.asset('assets/hello.json',height: 300),
              //     ),
              //   ),
              // ),

              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                },

                decoration: kTextfieldDecoratiuon.copyWith(
                  hintText: "Enter your Profile Name.",
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  MobileNo=value;
                },
                decoration: kTextfieldDecoratiuon.copyWith(
                  hintText: "Enter mobile no.",
                ),
                maxLength: 10,
                  keyboardType: TextInputType.number,

              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextfieldDecoratiuon.copyWith(
                  hintText: "Enter your Email.",
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kTextfieldDecoratiuon.copyWith(),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colour: Color(0xff34D8DC),
                text: "Register",
                onPressed: () async {
                  setState(() {
                    isVisible = true;
                  });

                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    _firestore
                        .collection('resisteredUsers')               // for take list of resistered User diff. list
                        .add({
                      'name' :name,
                      'users': email,
                      'url':"https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png",
                      'mobileNo':MobileNo
                        });

                    if (newUser != null) {
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                    setState(() {
                      isVisible = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
