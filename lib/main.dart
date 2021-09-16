import 'package:flutter/material.dart';
import 'package:searchable_grid/Screens/crossword_widget.dart';
import 'package:searchable_grid/Screens/main_screen.dart';
import 'package:searchable_grid/Screens/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    //  home: CrossWords()
      home:  SplashScreen()

    );
  }
}


