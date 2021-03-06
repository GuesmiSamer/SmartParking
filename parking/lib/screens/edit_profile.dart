// @dart=2.9

import 'dart:io';
import 'package:parking/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File file;

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background2.jpg'),
            fit: BoxFit.cover,
          
          ),
        ),
        child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 300.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              file == null
                  ? InkWell(
                      onTap: () {
                        chooseImage();
                      },
                      child: Icon(
                        Icons.image,
                        size: 48,
                      ),
                    )
                  : Image.file(file),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Enter name",
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    updateProfile(context);
                  },
                  child: Text("Update profile"))
            ],
          ),
        ),
      ),
      ),
   
    );
  }

  chooseImage() async {
    XFile xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    print("file " + xfile.path);
    file = File(xfile.path);
    setState(() {});
  }

  updateProfile(BuildContext context) async {
    Map<String, dynamic> map = Map();
    if (file != null) {
      String url = await uploadImage();
      map['profileImage'] = url;
    }
    map['firstName'] = _textEditingController.text;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update(map);
     Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profile")
        .child(
            FirebaseAuth.instance.currentUser.uid + "_" + basename(file.path))
        .putFile(file);

    return taskSnapshot.ref.getDownloadURL();
  }
}