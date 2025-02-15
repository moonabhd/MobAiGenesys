import 'package:fantasy_football/screens/First.dart';
import 'package:fantasy_football/screens/Match.dart';
import 'package:fantasy_football/screens/Nav.dart';
import 'package:fantasy_football/screens/home_screen.dart';
import 'package:fantasy_football/screens/login.dart';
import 'package:fantasy_football/screens/players_market_screen.dart';
import 'package:fantasy_football/screens/team_screen.dart';
import 'package:flutter/material.dart';

class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    TeamScreen(),
    PlayersMarketScreen(),
    MatchResults(),
  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Field View',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Team',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events), // Icon for MatchResults
            label: 'Matches',
          ),
     
        ],
      ),
    );
  }
}
