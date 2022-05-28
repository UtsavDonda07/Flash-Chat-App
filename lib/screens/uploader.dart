import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../networking/profile_image_upload.dart';

File? file;
class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {


  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? file?.path : "not selected";
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  pickFile();
                },
                child: Text("select file")),
            // Text(file?.path ?? "null"),
            ElevatedButton(
                onPressed: () {
                  uploadFile();
                  setState((){});
                },
                child: Text("upload file")),
            ElevatedButton(
                onPressed: () {
                  setState((){});
                },
                child: Text("refresh")),

           //  Image(
           //    image: NetworkImage(url??"https://firebasestorage.googleapis.com/v0/b/flash-chat-5dc61.appspot.com/o/1?alt=media&token=c0933fe7-eee9-4f24-9247-00611e0610da"),
           // height: 200,
           //  ),
          ],
        ),
      ),
    );
  }
}
