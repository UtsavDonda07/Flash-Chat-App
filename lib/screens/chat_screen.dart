import 'package:flash_chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

late String SelectedReciver;
void ReciverUser(String user) {
  SelectedReciver = user;
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
    super.initState();
  }

  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,

        title: Center(child: Text('$SelectedReciver')),
        backgroundColor: Color(0xff60e1c8),
      ),
      body: SafeArea(
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
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color:Color(0xffb8d1ff),
                      ),
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
                  ),
                  FlatButton(
                    onPressed: () {
                      clearText();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser!.email,
                        'reciver': SelectedReciver,
                        'communicate': "${currentuser}-${SelectedReciver}",
                        'CreatedAt': DateTime.now()
                      });
                    },
                    child:CircleAvatar(
                      radius: 20,
                        child:Image.asset('images/send.png',height: 500,),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
              CreatedAt: time.toDate(),
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
  MessageBubble(
      {required this.text,
      required this.sender,
      required this.isMe,
      required this.CreatedAt});
  final String sender;
  final String text;
  final bool isMe;
  final DateTime CreatedAt;

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
              : TextStyle(fontSize: 10, color:Color(0xff60e1c8)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            elevation: 5,
            // borderRadius: BorderRadius.only(topLeft: , ),
            borderRadius: BorderRadius.circular(10),

            color: isMe ? Color(0xff60e1c8) : Color(0xff46dcd3),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                 // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$text',
                    style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.normal),
                  ),
                  Text(
                    DateFormat('KK:mm a').format(CreatedAt),
                    style: TextStyle(fontSize: 10, color: Colors.black38,fontWeight: FontWeight.bold),
                  ),
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
