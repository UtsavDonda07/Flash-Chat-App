import 'package:flash_chat_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';

late final String users;

final loggedInUser = FirebaseAuth.instance.currentUser;

final _firestore = FirebaseFirestore.instance;

late final String UserName;

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
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Navigator.pop(context);
              }),
        ],
        title: Center(child: Text('ChatApp')),
        backgroundColor: Colors.lightBlueAccent,
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
            // if (currentUser == allUsers) {}
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
            Navigator.pushNamed(context, ChatScreen.id,arguments: users);    //arguments: aapvani peticular message mate
            ReciverUser(users);
          },
          child: Column(
            children: [

Row(
  children: [

    Container(

      child: Image.network('https://th.bing.com/th/id/OIP.WlUDXSME4D1KBxKlZEtVuwHaKA?pid=ImgDet&rs=1',height: 50,width: 50,),
      decoration: BoxDecoration(
        color: Colors.white30,
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
                  color: Colors.blue,
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
