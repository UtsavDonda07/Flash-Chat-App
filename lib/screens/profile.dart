import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../networking/profile_image_upload.dart';
import 'home_screen.dart';
import 'home_screen.dart';
import 'home_screen.dart';
import 'home_screen.dart';
import 'home_screen.dart';

String? uri;
// late String profileImage;
// late String mobileno;
// late String emailId;

class Profile extends StatefulWidget {
  Profile();
  // Profile({required String logedInMail,required String imageUrl,required String mno }){
  //
  //   profileImage=imageUrl;
  //   mobileno=mno;
  //   emailId=logedInMail;
  //
  // }

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  getmail() {
    setState(() {});
    return currentuser;
  }

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        backgroundColor: Color(0xff222e35),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
            width: 200.0,
          ),
          CircleAvatar(
            radius: 100.0,
            //backgroundColor: Colors.tealAccent,
            backgroundImage: NetworkImage(uri ??
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8Dui-CG5_VcIxTHxks0tTiME_1rIvYeIfMA&usqp=CAU"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      onPressed: () async {
                        pickFile();
                        print(uri);
                        var uid = await _auth.currentUser?.uid;
                        final docUser = FirebaseFirestore.instance
                            .collection('resisteredUsers')
                            .doc(uid);

                        docUser.update({'url': uri});
                        // _firestore.collection('resisteredUsers').doc(uid).update({
                        //   'url': uri,
                        // });
                setState((){});
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xff1ad97d),
                        child: Center(
                            child: Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                        )),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Utsav Donda',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                onPressed: () {},
                child: Icon(
                  Icons.edit,
                  color: Colors.white54,
                  size: 25.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              Icons.call,
              color: Colors.green,
              size: 25.0,
            ),
            title: Text(
              ' +91 9313833967',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.mail,
              color: Colors.blue,
              size: 25.0,
            ),
            title: Text(
              getmail(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
