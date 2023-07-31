import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future> getVideoList() async {
  var videos = await FirebaseFirestore.instance.collection('Videos').get();
  return videos.docs.map((doc) => Video.fromJson(doc.data())).toList();
}

Future> getMyVideoList() async {
  User? user = FirebaseAuth.instance.currentUser;
  String uid = user!.uid;
  final userDocRef = 
    FirebaseFirestore.instance.collection('users').doc(uid.toString());

  final userDocSnapshot = await userDocRef.get();
  if(userDocSnapshot.exists){
    final myVideoList = 
      userDocSnapshot.data()?['myVideoList'] as List? ?? [];
    return myVideoList.map((url) => url.toString()).toList();
  } else {
    return [];
  }
}