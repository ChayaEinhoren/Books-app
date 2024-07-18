import 'package:books_app/Screen/home_screen.dart';
import 'package:books_app/Screen/intro_screen.dart';
import 'package:books_app/Screen/log_in.dart';
import 'package:flutter/material.dart';
import 'package:books_app/model/model.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 runApp(MyApp());
} 

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: LoginScreen(
        //כדי שיה גישה לדף הבית לפונקצויונליות הבאה.
        toggleTheme: toggleTheme,
        isDarkMode: isDarkMode,
      ),
    );
  }
}

List<Book> cart = [];
