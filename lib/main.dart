import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mykeke/screens/loginscreen.dart';
import 'screens/home.dart';
import 'package:mykeke/screens/Signup.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "mykeke",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: LoginScreen.idScreen,
      routes:
      {
        Signup.idScreen: (context) => Signup(),
        LoginScreen.idScreen: (context) => LoginScreen(),
        MyHomepage.idScreen: (context) => MyHomepage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

