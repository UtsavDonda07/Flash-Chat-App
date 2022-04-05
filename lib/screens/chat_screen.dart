import 'package:flash_chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();


  late String messageText;
  // FirebaseUser ;
  final loggedInUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    getCurrentUser();
    UpdateData();
    super.initState();
  }

  void UpdateData() {
    final docUser =
        FirebaseFirestore.instance.collection('messages').doc('Mydoc_name');
//update docuser
    docUser.update({
      'name': 'Swaminarayan',
    });
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

// void getMassages()async{
//   final messages =  await _firestore.collection('messages').doc();
//   for(var message in messages){
//     print(message.data);
//   }
// }
  void messageStream() async {
    await for (var snapshort in _firestore.collection('messages').snapshots()) {
      for (var message in snapshort.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // UpdateData();
                messageStream();
                //   // getMassages();
                //   _auth.signOut();
                // Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
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
                    child: TextField(
                      onChanged: (value) {
                        controller:
                        messageTextController;
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add(
                          {'text': messageText, 'sender': loggedInUser!.email});
                      //Implement send functionality.
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
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data?.docs;
          List<MessageBubble> messageWidgets = [];
          for (var message in messages!) {
            final messageText = message['text'];
            final messageSender = message['sender'];
            final messageBubble = MessageBubble(text: messageText, sender: messageSender);
            messageWidgets.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              padding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              children: messageWidgets,
            ),
          );
        } else {
          return Column(
            children: [Text("Empty list")],
          );
        }
      },
    );
  }
}


class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text,required this.sender});
final String sender;
final String text;
  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(sender,style: TextStyle(fontSize: 10,color: Colors.black38),),
          Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            elevation: 5,
            // borderRadius: BorderRadius.only(topLeft: , ),
            borderRadius: BorderRadius.circular(50),

            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
    ),
        ],
      );
    ;
  }
}
