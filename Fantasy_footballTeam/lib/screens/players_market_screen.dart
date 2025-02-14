import 'package:fantasy_football/models/player.dart';
import 'package:flutter/material.dart';

class PlayersMarketScreen extends StatefulWidget {
  final String? filterPosition;
  final Function(PlayerModel)? onPlayerSelected;

  PlayersMarketScreen({
    this.filterPosition,
    this.onPlayerSelected,
  });

  @override
  _PlayersMarketScreenState createState() => _PlayersMarketScreenState();
}

class _PlayersMarketScreenState extends State<PlayersMarketScreen> {
  String _searchQuery = '';
  String _positionFilter = 'All';
  
  final List<PlayerModel> availablePlayers = [
    PlayerModel(
      id: '1',
      name: 'Manuel Neuer',
      position: 'GK',
      team: 'BAY',
      points: 180,
      value: 8.5,
      stats: {'cleanSheets': 15, 'saves': 82},
    ),
    // Add more players...
  ];

  @override
  void initState() {
    super.initState();
    if (widget.filterPosition != null) {
      _positionFilter = widget.filterPosition!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Market'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildPositionFilter(),
          Expanded(
            child: _buildPlayersList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
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
    );
  }

  Widget _buildPositionFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ['All', 'GK', 'RB', 'CB', 'LB', 'CDM', 'CM', 'CAM', 'RW', 'ST', 'LW']
            .map((position) => Padding(
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
                ))
            .toList(),
      ),
    );
  }

  Widget _buildPlayersList() {
    final filteredPlayers = availablePlayers.where((player) {
      final matchesSearch =
          player.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          player.team.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesPosition =
          _positionFilter == 'All' || player.position == _positionFilter;
      return matchesSearch && matchesPosition;
    }).toList();

    return ListView.builder(
      itemCount: filteredPlayers.length,
      itemBuilder: (context, index) {
        final player = filteredPlayers[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(player.position),
            ),
            title: Text(player.name),
            subtitle: Text('${player.team} - ${player.points} pts'),
            trailing: Text('\$${player.value}M'),
            onTap: () {
              if (widget.onPlayerSelected != null) {
                widget.onPlayerSelected!(player);
                Navigator.pop(context);
              }
            },
          ),
        );
      },
    );
  }
}