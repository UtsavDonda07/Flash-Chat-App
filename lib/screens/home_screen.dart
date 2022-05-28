import 'dart:math';
import 'package:flash_chat_app/constants.dart';
import 'package:flash_chat_app/main.dart';
import 'package:flash_chat_app/networking/auto_login.dart';
import 'package:flash_chat_app/screens/profile.dart';
import 'package:flash_chat_app/screens/setting.dart';
import 'package:flash_chat_app/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'chat_screen.dart';
import 'login_screen.dart';

late final String users;

final loggedInUser = FirebaseAuth.instance.currentUser;

final _firestore = FirebaseFirestore.instance;

final currentUser = loggedInUser?.email;
String status = "offline";

class HomeScreen extends StatefulWidget {
  static String id = "home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  late final String UserName;
  late final String url;
late final String no;
  @override
  void initState() {
    setState((){});
    status = "online";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111b21),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),


            Card(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                              // logedInMail: currentUser.toString(),
                              // imageUrl: url,
                              // mno: no,
                            )),
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.black54,
                    size: 25.0,
                  ),
                  title: Text(
                    ' Profile',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),

            Card(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting()),
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: 25.0,
                  ),
                  title: Text(
                    ' Setting',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),

            Card(
              child: FlatButton(
                onPressed: () async {
                  _auth.signOut();
                  preferences.clear();
                  AuthController.logout();
                  Navigator.pushNamed(context, WelcomeScreen.id);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Color(0xff60e1c8),
                    size: 25.0,
                  ),
                  title: Text(
                    ' Logout',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: null,
        backgroundColor: Color(0xff222e35),
        title: Center(child: Text("Hello")),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            UserStream(),
          ],
        ),
      ),
    );
  }
}

class UserStream extends StatelessWidget {
  const UserStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('resisteredUsers').orderBy('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final resisteredUsers = snapshot.data?.docs;
          List<MessageBubble> allUsersList = [];
          for (var user in resisteredUsers!) {
            final allUsers = user['users'];


             var no = user['mobileNo'];
            final name = user['name'];
            url = user['url']?? "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png";
            // if (url == "")
            //   url="https://cdn-icons-png.flaticon.com/512/64/64572.png";

            final currentUser = loggedInUser?.email;
            final messageBubble =
                MessageBubble(users: allUsers, image: url, name: name);
            allUsersList.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              children: allUsersList,
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.users, required this.image, required this.name});
  final String users;
  final String image;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          maxRadius: 50,
          child: Image.network(image, fit: BoxFit.cover),
        ),
        title: Text(name),
        onTap: () {
          Navigator.pushNamed(context, ChatScreen.id, arguments: users);
          ReciverUser(users, name, image);
        },
      ),
    );
  }
}
// Text(users[0].toString().toUpperCase())
