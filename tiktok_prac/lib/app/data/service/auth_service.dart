import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_practice/app/view/auth/login.dart';

import '../../view/post/porst.dart';

Future signInWithEmail(
    String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => PostScreen()),
      );
    }
  } catch (e) {
    print('Error signing in with email: $e');
  }
}

Future signUpWithEmailAndImage(
  String email,
  String password,
  String name,
  File imageFile,
  BuildContext context,
)   async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null){
        String userId = userCredential.user!.uid;

        String? imageUrl = await uploadProfileImage(userId, imageFile);

        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'uuid':userId,
          'name':name,
          'image_url': imageUrl,
        });
        await userCredential.user!.uploadDisplayName(name);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } catch (e){
      print('Error signing up with email and image: $e');
    }
  }

  Future uploadProfileImage(String userId, File imageFile) async{
    try {
      Reference storageRef = await FirebaseStorage.instance
      .ref()
      .child('profile_/images/$userId.jpg');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloardUrl = await snapshot.ref.getDownloadURL();
      return downloardUrl;
    } catch (e) {}
  }
)