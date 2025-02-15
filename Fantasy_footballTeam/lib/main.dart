import 'package:fantasy_football/screens/First.dart';

import 'package:flutter/material.dart';


void main() => runApp(FantasyFootballApp());

class FantasyFootballApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fantasy Football",
      theme: ThemeData(
        
        scaffoldBackgroundColor: Color.fromRGBO(32, 32, 34, 1),//background color 
      ),
      home: FirstPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
