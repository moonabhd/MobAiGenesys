import 'package:fantasy_football/models/player.dart';
import 'package:flutter/material.dart';

class TeamScreen extends StatefulWidget {
  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  List<PlayerModel> myTeam = [
    PlayerModel(
      id: '1',
      name: 'Tom Brady',
      position: 'QB',
      team: 'TB',
      points: 250,
      value: 9.5,
      stats: {
        'passYards': 4500,
        'passTD': 40,
        'interceptions': 12,
      },
    ),
    PlayerModel(
      id: '2',
      name: 'Derrick Henry',
      position: 'RB',
      team: 'TEN',
      points: 220,
      value: 9.0,
      stats: {
        'rushYards': 1500,
        'rushTD': 15,
        'receptions': 20,
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.blue[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             // Text(
             //   'Total Points: ${myTeam.fold(0, (sum, player) => sum + player.points)}',
             //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
             // ),
              Text(
                'Players: ${myTeam.length}/15',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: myTeam.length,
            itemBuilder: (context, index) {
              final player = myTeam[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      player.position,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    player.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${player.team} - ${player.points} pts'),
                  trailing: Text('\$${player.value}M'),
                  children: [
                    _buildPlayerStats(player),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerStats(PlayerModel player) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: player.stats.entries.map((entry) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(entry.value.toString()),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
