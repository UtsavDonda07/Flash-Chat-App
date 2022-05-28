import 'package:flash_chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_screen.dart';

late String SelectedReciver;
late String name;
late String url;
void ReciverUser(String user, String n, String image) {
  SelectedReciver = user;
  name = n;
  url = image;
}

final loggedInUser = FirebaseAuth.instance.currentUser;
final _firestore = FirebaseFirestore.instance;
final currentuser = loggedInUser?.email;
late final String UserName;

class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final fieldText = TextEditingController();

  late String messageText;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void clearText() {
    fieldText.clear();
  }

  void getCurrentUser() async {
    try {
      // FirebaseUser loggedInUser = await FirebaseAuth.instance.currentUser();
      final user = await _auth.currentUser;
      if (user != null) {
        // loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void messageStream() async {
    await for (var snapshort
        in _firestore.collection('messages').orderBy('CreatedAt').snapshots()) {
      for (var message in snapshort.docs) {
        print(message.data());
      }
    }
  }

  void reciverstatus() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: CircleAvatar(
                  child: Image(image: NetworkImage(url!=null?url : "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png"), fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$name ',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            child: Icon(Icons.menu),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('About me'),
              ),
           ],
          ),
          
        ],
        // title: Center(child: Text('$SelectedReciver ')),
        backgroundColor: Color(0xff222e35),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          controller:
                          fieldText;
                          messageText = value;
                          //Do something with the user input.
                        },
                        decoration: kMessageTextFieldDecoration,
                        controller: fieldText,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        clearText();
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedInUser!.email,
                          'reciver': SelectedReciver,
                          'communicate': "${currentuser}-${SelectedReciver}",
                          'CreatedAt': DateTime.now().millisecondsSinceEpoch
                        });
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/ChatBackground.jpg"),
                  fit: BoxFit.fill)),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .where("communicate", whereIn: [
            "${currentuser}-${SelectedReciver}",
            "${SelectedReciver}-${currentuser}"
          ])
          .orderBy('CreatedAt')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data?.docs.reversed;
          List<MessageBubble> messageWidgets = [];
          for (var message in messages!) {
            final messageText = message['text'];
            final messageSender = message['sender'];
            final time = message['CreatedAt'];
            final currentUser = loggedInUser?.email;
            if (currentUser == messageSender) {}
            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              CreatedAt: time,
              isMe: currentUser == messageSender,
            );

            messageWidgets.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              children: messageWidgets,
            ),
          );
        } else {
          return Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {required this.text,
      required this.sender,
      required this.isMe,
      required this.CreatedAt});
  final String sender;
  final String text;
  final bool isMe;
  var CreatedAt;

  DateTime date = new DateTime.fromMillisecondsSinceEpoch(1486252500000);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          "   $sender",
          style: isMe
              ? TextStyle(fontSize: 10, color: Colors.black38)
              : TextStyle(fontSize: 10, color: Color(0xff005c4b)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            elevation: 5,
            // borderRadius: BorderRadius.only(topLeft: , ),
            borderRadius: BorderRadius.circular(10),

            color: isMe ?  Color(0xff005c4b) : Color(0xff202c33),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$text',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  // Text(
                  //   '$date',
                  //   style: TextStyle(fontSize: 10,color: Colors.black),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
    ;
  }
}
