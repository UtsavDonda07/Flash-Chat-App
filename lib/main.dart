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

late SharedPreferences preferences;
void main() async {
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

  String? email;
  String? password;

  @override
  static String start = WelcomeScreen.id;

  void initState() {
    init();
    screen();
    super.initState();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    // bool? m = preferences.getBool("mode");
    email = preferences.getString("email")!;
    password = preferences.getString("password")!;
    email = email;
    password = password;
  }

  void screen() {
    if (email != null && password != null) {

      login(email!,password!);
    } else {
      start = WelcomeScreen.id;
    }
  }

  void login(String email,String password) async {
    preferences.setString("email", email);
    preferences.setString("password", password);
    final loginUser = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    AuthController.login(email, password);
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
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
