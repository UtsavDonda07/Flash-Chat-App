import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget {
  Profile(@required this.logedInMail);
  final  logedInMail;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
getmail(){
  setState(() {});
  return currentuser;
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          backgroundColor: Color(0xff60e1c8),
          title: Center(child: ( Text("Profile"))),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
              width: 200.0,
            ),
            CircleAvatar(
              radius: 70.0,
              //backgroundColor: Colors.tealAccent,
              backgroundImage: AssetImage('images/profile.png'),
            ),
            Text(
              'Utsav Donda',
              style:TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight:FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 20,
              width: 200.0,
              child:Divider(
                color: Colors.teal,
              )
              ,
            ),

            Card(
                margin: EdgeInsets.symmetric(vertical:8.0 ,horizontal:10.0 ),
                shape:RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(30),
                ),
                child:ListTile(
                  leading:Icon(
                    Icons.call,
                    color: Colors.green,
                    size:25.0,
                  ),
                  title: Text(
                    ' +91 9313833967',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
            ),

            Card(
                margin: EdgeInsets.symmetric(vertical:8.0 ,horizontal:10.0 ),
                shape:RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(30),
                ),
                child:ListTile(
                  leading:Icon(
                    Icons.mail,
                    color: Colors.blue,
                    size:25.0,
                  ),
                  title: Text(
                   getmail(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
            ),


                ],
              ),

            );


  }
}
