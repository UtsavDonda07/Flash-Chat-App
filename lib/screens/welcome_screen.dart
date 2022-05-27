import 'package:flash_chat_app/components/rounded_button.dart';
import 'package:flash_chat_app/networking/signInWithGoogle.dart';
import 'package:flash_chat_app/screens/home_screen.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_app/screens/resistration_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../components/notification.dart';


class WelcomeScreen extends StatefulWidget {
  static String id ="welcome_screen";


  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[

              Container(
                height: 200,
                width: 300,
                child: Lottie.asset('assets/hello.json'),
              ),

              ],
            ),

            RoundedButton(colour:Color(0xff7fe7ba) ,text: "Log In",onPressed: (){
            Navigator.pushNamed(context, LoginScreen.id);
            },),
            RoundedButton(colour: Color(0xff34D8DC),text: "Register",onPressed: (){

            Navigator.pushNamed(context, RegistrationScreen.id);
            },),

            ElevatedButton(
                onPressed: ()=>NotificationApi.showNotification(
              title:"Utsav Donda",
              body:
                "message is here!",
              payload: "utsav.abs",

            ),
                child: Text("Sign in Google")),

          ],
        ),
      ),
    );
  }
}
