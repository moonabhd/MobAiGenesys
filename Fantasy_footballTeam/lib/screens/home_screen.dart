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

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    final double _fieldH = 0.6773399 * _height;

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
        title: Text('DCS'),
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
            SizedBox(height: 15.0),
            Container(
              child: Image.asset(
                'assets/images/player1.png',
                height: (0.13546798 * _height),
                width: _width,
              ),
            ),
            SizedBox(height: 10.0),
            Stack(
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/field.png',
                    fit: BoxFit.fill,
                  ),
                  height: _fieldH,
                  width: _width,
                ),
                _buildPlayerPosition('GK', 0.07272727 * _fieldH, 0.0, 0.0),
                _buildPlayerPosition('RB', 0.21818182 * _fieldH, 0.70666667 * _width, 0.0),
                _buildPlayerPosition('CB1', 0.23636364 * _fieldH, 0.29333333 * _width, 0.0),
                _buildPlayerPosition('CB2', 0.23636364 * _fieldH, 0.0, 0.29333333 * _width),
                _buildPlayerPosition('LB', 0.21818182 * _fieldH, 0.0, 0.70666667 * _width),
                _buildPlayerPosition('LMF', 0.47272727 * _fieldH, 0.0, 0.70666667 * _width),
                _buildPlayerPosition('AMF', 0.45454545 * _fieldH, 0.01333333 * _width, 0.0),
                _buildPlayerPosition('RMF', 0.47272727 * _fieldH, 0.70666667 * _width, 0.0),
                _buildPlayerPosition('CF', 0.69090909 * _fieldH, 0.29333333 * _width, 0.29333333 * _width),
                _buildPlayerPosition('RWF', 0.69090909 * _fieldH, 0.44 * _width, 0.0),
                _buildPlayerPosition('LWF', 0.69090909 * _fieldH, 0.17333333 * _width, 0.65333333 * _width),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            teamPlayers.clear();
          });
        },
        child: Icon(Icons.refresh),
        backgroundColor: Colors.green[700],
      ),
    );
  }

  Widget _buildPlayerPosition(String position, double top, double right, double left) {
    final player = teamPlayers[position];
    return PlayerWidget(
      image: player?.imageUrl ?? _getDefaultImage(position),
      name: player?.name ?? 'Select $position',
      position: position,
      top: top,
      right: right,
      left: left,
      onTap: () => _selectPlayer(position, top, right, left),
    );
  }

  String _getDefaultImage(String position) {
    switch (position) {
      case 'GK':
        return 'assets/images/gk.png';
      case 'RB':
      case 'CB1':
      case 'CB2':
      case 'LB':
        return 'assets/images/defender.png';
      case 'LMF':
      case 'AMF':
      case 'RMF':
      case 'RWF':
      case 'LWF':
        return 'assets/images/wings.png';
      case 'CF':
        return 'assets/images/striker.png';
      default:
        return 'assets/images/player1.png';
    }
  }

  void _selectPlayer(String position, double top, double right, double left) {
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
            });
          },
        ),
      ),
    );
  }
}
