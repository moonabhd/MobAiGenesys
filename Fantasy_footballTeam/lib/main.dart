import 'package:fantasy_football/screens/main_navigation_screen.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/players_market_screen.dart';


void main() => runApp(FantasyFootballApp());

class FantasyFootballApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fantasy Football",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.green[50],
      ),
      home: MainNavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
