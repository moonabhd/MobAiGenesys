import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/screens/players_market_screen.dart';

import 'package:fantasy_football/widgets/player.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, PlayerModel> teamPlayers = {};
  Map<String, PlayerModel> examplePlayers =
      {}; // Separate state for example players
  double remainingBudget = 100.0; // Example remaining budget

  // Example list of 4 positions
  List<String> examplePlayerPositions = ['GK', 'CB1', 'CB2', 'LB'];

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    final double _fieldH = 0.6773399 * _height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(32, 32, 34, 100),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(32, 32, 34, 100),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: 26.0),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 20.0),
            // Smaller Budget Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: 80, // Smaller width
                child: ElevatedButton(
                  onPressed: () {
                    // Handle budget button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(61, 147, 19, 100),
                    padding: EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 12.0), // Smaller padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    '\$${remainingBudget.toStringAsFixed(1)}M',
                    style: TextStyle(
                      fontSize: 12, // Smaller font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Stack(
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/staduim.jpg',
                    fit: BoxFit.fill,
                  ),
                  height: _fieldH,
                  width: _width,
                ),
                _buildPlayerPosition('GK', 0.07272727 * _fieldH, 0.0, 0.0),
                _buildPlayerPosition(
                    'RB', 0.21818182 * _fieldH, 0.70666667 * _width, 0.0),
                _buildPlayerPosition(
                    'CB1', 0.23636364 * _fieldH, 0.29333333 * _width, 0.0),
                _buildPlayerPosition(
                    'CB2', 0.23636364 * _fieldH, 0.0, 0.29333333 * _width),
                _buildPlayerPosition(
                    'LB', 0.21818182 * _fieldH, 0.0, 0.70666667 * _width),
                _buildPlayerPosition(
                    'LMF', 0.47272727 * _fieldH, 0.0, 0.70666667 * _width),
                _buildPlayerPosition(
                    'AMF', 0.45454545 * _fieldH, 0.01333333 * _width, 0.0),
                _buildPlayerPosition(
                    'RMF', 0.47272727 * _fieldH, 0.70666667 * _width, 0.0),
                _buildPlayerPosition('CF', 0.69090909 * _fieldH,
                    0.29333333 * _width, 0.29333333 * _width),
                _buildPlayerPosition(
                    'RWF', 0.69090909 * _fieldH, 0.44 * _width, 0.0),
                _buildPlayerPosition('LWF', 0.69090909 * _fieldH,
                    0.17333333 * _width, 0.65333333 * _width),
              ],
            ),
            SizedBox(height: 20.0),
            // Display the 4 example players as selectable positions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: examplePlayerPositions.map((position) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 20, // Smaller size
                            backgroundImage: AssetImage(
                              examplePlayers[position]?.imageUrl ??
                                  'assets/images/player.png',
                            ),
                          ),
                          SizedBox(height: 4.0),
                          // Clickable Player Name or "Select Player"
                          GestureDetector(
                            onTap: () => _selectExamplePlayer(position),
                            child: Text(
                              examplePlayers[position]?.name ?? 'Select Player',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Text(
                            examplePlayers[position]?.position ?? position,
                            style: TextStyle(
                              fontSize: 10,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            myTeam.clear();
            teamPlayers.clear();
            examplePlayers.clear(); // Clear example player selections too
          });
        },
        child: Icon(Icons.refresh),
        backgroundColor: Color.fromRGBO(61, 147, 19, 100),
      ),
    );
  }

  Widget _buildPlayerPosition(
      String position, double top, double right, double left) {
    final player = teamPlayers[position];
    return PlayerWidget(
      image: player?.imageUrl ?? _getDefaultImage(position),
      name: player?.name ?? 'Select Player',
      position: position,
      top: top,
      right: right,
      left: left,
      onTap: () => _selectPlayer(position, top, right, left),
    );
  }

  String _getDefaultImage(String position) {
    return 'assets/images/player.png';
  }

  void _selectPlayer(String position,
      [double top = 0, double right = 0, double left = 0]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayersMarketScreen(
          filterPosition: position,
          onPlayerSelected: (PlayerModel player) {
            setState(() {
              teamPlayers[position] = player.copyWith(
                top: top,
                right: right,
                left: left,
              );
              remainingBudget -=
                  player.value; // Deduct player value from budget
            });
          },
        ),
      ),
    );
  }

  void _selectExamplePlayer(String position) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayersMarketScreen(
          filterPosition: position,
          onPlayerSelected: (PlayerModel player) {
            setState(() {
              examplePlayers[position] =
                  player; // Store selected player for example position
            });
          },
        ),
      ),
    );
  }
}
