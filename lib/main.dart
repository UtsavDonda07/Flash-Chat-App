import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/screens/home_screen.dart';
import 'package:flash_chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_app/screens/resistration_screen.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'networking/auto_login.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Hello());
}

class Hello extends StatefulWidget {
  const Hello({Key? key}) : super(key: key);

  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  final _auth = FirebaseAuth.instance;


  @override

   static String start=WelcomeScreen.id;

   initState() {
     if( AuthController.getEmail() == "null" ){
       start=WelcomeScreen.id;
     }
     else{
       AutoLogedIn();
     }

    super.initState();
  }
AutoLogedIn()async{
  setState(() {});
print("..........................Auto logedIn ...........................");
  final loginUser = await _auth.signInWithEmailAndPassword(
      email:  AuthController.getEmail(),
      password: AuthController.getPassward());
  try {
    if (loginUser != null) {
      Navigator.pushNamed(context, HomeScreen.id);
    }

  } catch (e) {
    print(e);
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute:start,
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
