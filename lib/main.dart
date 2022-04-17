import 'package:flutter/material.dart';
import 'package:manipalx/pages/AuthPage.dart';
import 'package:manipalx/pages/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ManipalX',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: _handleWindowDisplay(),
    );
  }
}

Widget _handleWindowDisplay() {
  return StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
            child: SizedBox(
          height: 150,
          width: 150,
          child: CircularProgressIndicator(),
        ));
      } else {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return AuthPage();
        }
      }
    },
  );
}
