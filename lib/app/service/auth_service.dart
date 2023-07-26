import 'package:firebase_auth/firebase_auth.dart';

Future<void> loginWithEmailAndPassword(
    FirebaseAuth auth, String email, String password) async {
  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
  } catch (e) {
    print('Login Failed:$e');
  }
}
