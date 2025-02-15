import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/screens/players_market_screen.dart';
import 'package:flutter/material.dart';

class TeamScreen extends StatefulWidget {
  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildTeamProgress(),
          Expanded(
            child: ListView.builder(
              itemCount: myTeam.length,
              itemBuilder: (context, index) {
                final player = myTeam[index];

                // Update points for each player before passing it to the card widget
                player.points = player.calculatePoints();

                return _buildPlayerCard(player);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (myTeam.length < 15) {
            _navigateToTeamPage();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Team is full (15/15 players)'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(61, 147, 19, 100),
        tooltip: 'Add a new player to your team',
      ),
    );
  }

  void _navigateToTeamPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayersMarketScreen(),
      ),
    );
  }

  Widget _buildTeamProgress() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(61, 147, 19, 100),
            Color.fromRGBO(61, 147, 19, 100),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Fantasy Team',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '${myTeam.length}/15 Players',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: myTeam.length / 15,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCard(PlayerModel player) {
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5.0,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(player.imageUrl.isNotEmpty
              ? player.imageUrl
              : 'assets/images/player.png'),
          backgroundColor: Color.fromRGBO(61, 147, 19, 100),
          child: Text(
            player.position,
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          player.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text('${player.team} - ${player.points} pts'),
        trailing: Text(
          '\$${player.value}M',
          style: TextStyle(
            color: Color.fromRGBO(61, 147, 19, 100),
          ),
        ),
        children: [
          _buildPlayerStats(player),
          _buildAddToHomeButton(player),
        ],
      ),
    );
  }

  Widget _buildPlayerStats(PlayerModel player) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        shrinkWrap: true,
        children: player.stats.entries.map((entry) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(61, 147, 19, 100),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    entry.value.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAddToHomeButton(PlayerModel player) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle add player to home logic here
        },
        child: Text('Add to Home'),
        style: ElevatedButton.styleFrom(),
      ),
    );
  }
}
