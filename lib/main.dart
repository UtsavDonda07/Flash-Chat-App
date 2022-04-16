import 'package:flash_chat_app/screens/home.dart';
import 'package:flash_chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_app/screens/resistration_screen.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes:{
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        HomeScreen.id:(context)=>HomeScreen(),
       ChatScreen.id:(context)=>ChatScreen(),
      },
    );
  }
}
