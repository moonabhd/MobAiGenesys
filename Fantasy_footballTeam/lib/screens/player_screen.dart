import 'package:fantasy_football/main.dart';
import 'package:fantasy_football/models/player.dart';

import 'package:flutter/material.dart';

class PlayersScreen extends StatefulWidget {
  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  List<PlayerModel> availablePlayers = [
    PlayerModel(
      id: '3',
      name: 'Patrick Mahomes',
      position: 'QB',
      team: 'KC',
      points: 280,
      value: 10.0,
      stats: {
        'passYards': 4800,
        'passTD': 45,
        'interceptions': 10,
      },
    ),
    PlayerModel(
      id: '4',
      name: 'Travis Kelce',
      position: 'TE',
      team: 'KC',
      points: 210,
      value: 8.5,
      stats: {
        'receptions': 105,
        'recYards': 1300,
        'recTD': 12,
      },
    ),
  ];

  String _searchQuery = '';
  String _positionFilter = 'All';

  List<PlayerModel> get filteredPlayers {
    return availablePlayers.where((player) {
      final matchesSearch = player.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          player.team.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesPosition = _positionFilter == 'All' || player.position == _positionFilter;
      return matchesSearch && matchesPosition;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search Players',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ['All', 'QB', 'RB', 'WR', 'TE', 'K', 'DEF'].map((position) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: FilterChip(
                  label: Text(position),
                  selected: _positionFilter == position,
                  onSelected: (selected) {
                    setState(() {
                      _positionFilter = selected ? position : 'All';
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredPlayers.length,
            itemBuilder: (context, index) {
              final player = filteredPlayers[index];
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
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Add player to team logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${player.name} added to your team'),
                        ),
                      );
                    },
                    child: Text('Add'),
                  ),
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