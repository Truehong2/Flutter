import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:statelab/app/view/auth/login.dart';
import 'package:statelab/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class _MyAppState extends State {
  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/add': (context) => AddTodo(),
        '/home': (context) => HomePage(),
      },
      home: StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.black,
            );
          } else {
            if (snapshot.data == null) {
              return LoginPage();
            } else {
              return HomePage();
            }
          }
        },
      ),
    );
  }
}
