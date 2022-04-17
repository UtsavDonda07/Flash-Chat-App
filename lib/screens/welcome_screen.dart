import 'package:flash_chat_app/components/rounded_button.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_app/screens/resistration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  static String id ="welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  late AnimationController controller;
 late Animation animation;
  @override
  void initState() {
    controller=AnimationController( duration: Duration(seconds: 2), vsync: this,);
    animation=ColorTween(begin: Colors.blueGrey,end: Colors.white).animate(controller);
      controller.forward();
      // animation.addStatusListener((status) {
      //   if(status==AnimationStatus.completed){
      //     controller.reverse(from:1.0);
      //   }
      //   else if(status==AnimationStatus.dismissed){
      //     controller.forward();
      //   }
      // });
      controller.addListener(() {
        setState(() {});
      });
    super.initState();
  }

@override
  void dispose() {
  controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
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
                child: Lottie.asset('assets/robot.json'),
              ),

              ],
            ),

            RoundedButton(colour:Color(0xff7fe7ba) ,text: "Log In",onPressed: (){
            Navigator.pushNamed(context, LoginScreen.id);
            },),
            RoundedButton(colour: Color(0xff34D8DC),text: "Register",onPressed: (){
            Navigator.pushNamed(context, RegistrationScreen.id);
            },),
          ],
        ),
      ),
    );
  }
}
