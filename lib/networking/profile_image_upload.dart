import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/profile.dart';
import '../screens/uploader.dart';

late SharedPreferences preferences;

final _auth = FirebaseAuth.instance;
UploadTask? task;
String? url;

class FireBaseApi {
  static UploadTask? uploadFile(String destination, File files) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(files);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}

Future pickFile() async {
  final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  if (result == null) return;
  final path = result.files.single.path!;
  file = File(path);
  uploadFile();
}

Future uploadFile() async {
  if (file == null) return;
  final fileName = file!.path;
  final destination = 'image';
  task = FireBaseApi.uploadFile(destination, file!);
  if (task == null) return;
  final snapshot = await task!.whenComplete(() {});
  url = await snapshot.ref.getDownloadURL();
  uri = url;
}