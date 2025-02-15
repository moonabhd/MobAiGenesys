import 'dart:convert';
import 'package:http/http.dart' as http;

class PlayerModel {
  final String id;
  final String name;
  final String position;
  final String team;
  final int points;
  final double value;
  final String imageUrl;
  final Map<String, dynamic> stats;
  final double top;
  final double right;
  final double left;

  PlayerModel({
    required this.id,
    required this.name,
    required this.position,
    required this.team,
    required this.points,
    this.value = 0.0,
    this.imageUrl = '',
    this.stats = const {},
    this.top = 0.0,
    this.right = 0.0,
    this.left = 0.0,
  });

  // Factory constructor to create a PlayerModel from a JSON object
  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      team: json['team'],
      points: json['points'],
      value: json['value'] ?? 0.0,
      imageUrl: json['imageUrl'] ?? '',
      stats: json['stats'] ?? {},
      top: json['top'] ?? 0.0,
      right: json['right'] ?? 0.0,
      left: json['left'] ?? 0.0,
    );
  }
}

Future<List<PlayerModel>> fetchPlayerList() async {
  // Replace with your actual API URL
  final url = Uri.parse('https://api.example.com/players');

  try {
    // Make the network request
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response
      List<dynamic> jsonList = json.decode(response.body);
      
      // Map JSON list to List<PlayerModel>
      return jsonList.map((json) => PlayerModel.fromJson(json)).toList();
    } else {
      // Handle non-200 responses (error)
      throw Exception('Failed to load players');
    }
  } catch (e) {
    print('Error fetching players: $e');
    return [];
  }
}
