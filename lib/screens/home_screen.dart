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
import 'package:shared_preferences/shared_preferences.dart';
import 'chat_screen.dart';
import 'login_screen.dart';

late final String users;

final loggedInUser = FirebaseAuth.instance.currentUser;

final _firestore = FirebaseFirestore.instance;
late final String UserName;
final currentUser = loggedInUser?.email;
class HomeScreen extends StatefulWidget {
  static String id = "home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {


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
            CircleAvatar(
              radius: 70.0,
              backgroundColor:  Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
              child: Image.asset('images/profile.png',height: 100,),
            ),

            // Text(loggedInUser.toString(),style: TextStyle(fontSize: 50),),
            SizedBox(
              height: 50,
            ),
        Text(loggedInUser!.email.toString(),style: TextStyle(fontSize: 30),),
            SizedBox(
              height: 50,
            ),
            Card(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Profile(loggedInUser?.email)),
                  );
                },

                child:ListTile(
                  leading: Icon(
                    Icons.person,
                    color:Colors.black54,
                    size:25.0,
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
                    MaterialPageRoute(builder: (context) =>  Setting()),
                  );
                },

                child:ListTile(
                  leading: Icon(
                    Icons.settings,
                    size:25.0,
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
                onPressed: () {
                  _auth.signOut();
                AuthController.logout();
                Navigator.pushNamed(context, LoginScreen.id);
                },

                child:ListTile(
                  leading: Icon(
                    Icons.logout,
                    color:Color(0xff60e1c8),
                    size:25.0,
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
        title: Center(child: Text(AuthController.myEmail)),
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
            final currentUser = loggedInUser?.email;

            final messageBubble = MessageBubble(users: allUsers);
            allUsersList.add(messageBubble);
          }
          // allUsersList = allUsersList.toSet().toList();
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              children: allUsersList,
            ),
          );
        } else {
          return Expanded(
            child: Column(
              children: [Text("wait will a second")],
            ),
          );
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.users});
final String users;
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, ChatScreen.id,arguments: users);
            ReciverUser(users);
          },
          child: Column(
            children: [

Row(
  children: [

    Container(

      child:CircleAvatar(
        // backgroundColor: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        child: Text(users[0].toString().toUpperCase()),
      ),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadiusDirectional.circular(100),
      ),
    ),
    Expanded(
      child: Text(
        "   $users",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    ),
  ],
),

              SizedBox(
                child: Divider(
                  color: Color(0xff202c33),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    ;
  }
}
