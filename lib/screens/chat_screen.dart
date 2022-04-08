import 'package:flash_chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// DateTime now = new DateTime(now.hour,now.minute);
// message sequence
//login suggetion
//welcome logo
//time in message
var timeH;
var timeM;
final loggedInUser = FirebaseAuth.instance.currentUser;

final _firestore = FirebaseFirestore.instance;
late final  String UserName;
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
    // messageStream();
    super.initState();
  }
  void clearText() {
    fieldText.clear();
  }
//   void UpdateData() {
//     final docUser =
//         FirebaseFirestore.instance.collection('messages').doc('Mydoc_name');
// //update docuser
//     docUser.update({
//       'name': 'Swaminarayan',
//     });
//   }

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
    await for (var snapshort in _firestore.collection('messages').orderBy('CreatedAt').snapshots()) {
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
                  _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Center(child: Text('Chat')),
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
                        fieldText;
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,



                      controller: fieldText, ),
                  ),
                  FlatButton(
                    onPressed: ()
                    {
                      var timeM=DateTime.now().minute;
                      timeH=DateTime.now().hour;
                      clearText();
                      _firestore.collection('messages').add(
                          {'text': messageText, 'sender': loggedInUser!.email , 'CreatedAt':DateTime.now().millisecondsSinceEpoch ,'timeH':timeH,'timeM':timeM});

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
      stream: _firestore.collection('messages').orderBy('CreatedAt').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data?.docs.reversed;
          List<MessageBubble> messageWidgets = [];
          for (var message in messages!) {
            final messageText = message['text'];
            final messageSender = message['sender'];
            final currentUser = loggedInUser?.email;
            if (currentUser == messageSender) {}
            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              // CreatedAt: DateTime.now().millisecondsSinceEpoch,
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
            child: Column(children: [Text("wait will a second")],),
          );
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender, required this.isMe});
  final String sender;
  final String text;
  final bool isMe;
   // var CreatedAt;
   // UserName=sender;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text("   $sender",
          style: isMe?TextStyle(fontSize: 10, color: Colors.black38):TextStyle(fontSize: 10, color: Colors.green),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            elevation: 5,
            // borderRadius: BorderRadius.only(topLeft: , ),
            borderRadius: BorderRadius.circular(10),

            color: isMe ? Colors.green : Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$text',
                    style: TextStyle(fontSize: 15,color: Colors.white),
                  ),
                  // Text(
                  //   '$timeH ${timeM}',
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
