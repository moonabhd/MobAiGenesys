import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For HTTP requests

class PlayerModel {
  String id;
  String name;
  String position;
  String team;
  double points; // Change this to double to accommodate the calculated points
  double value;
  String imageUrl;
  Map<String, dynamic> stats;
  double top;
  double right;
  double left;

  PlayerModel({
    required this.id,
    required this.name,
    required this.position,
    required this.team,
    required this.points,
    required this.value,
    required this.imageUrl,
    required this.stats,
    required this.top,
    required this.right,
    required this.left,
  });

  // CopyWith method
  PlayerModel copyWith({
    String? id,
    String? name,
    String? position,
    String? team,
    double? points,
    double? value,
    String? imageUrl,
    Map<String, dynamic>? stats,
    double? top,
    double? right,
    double? left,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      team: team ?? this.team,
      points: points ?? this.points,
      value: value ?? this.value,
      imageUrl: imageUrl ?? this.imageUrl,
      stats: stats ?? this.stats,
      top: top ?? this.top,
      right: right ?? this.right,
      left: left ?? this.left,
    );
  }

  // Factory constructor to create a PlayerModel from a JSON object
  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'] ??
          "1", // Assuming API returns an 'id', fallback to "1" if not found
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      team: json['club_name'] ?? '',
      points: 0.0,
      value: json['price']?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] ?? '',
      stats: json['stats'] ?? {},
      top: json['top']?.toDouble() ?? 0.0,
      right: json['right']?.toDouble() ?? 0.0,
      left: json['left']?.toDouble() ?? 0.0,
    );
  }

  // Example: Calculate fantasy points based on some basic stats.
  double calculatePoints() {
    double calculatedPoints = 0;

    // Example logic for calculation:
    if (position == 'QB') {
      // Assuming points are calculated as (pass yards / 25) + (pass TD * 4)
      calculatedPoints = (stats['Pass Yards'] ?? 0) / 25 +
          (stats['Pass TD'] ?? 0) * 4 -
          (stats['Interceptions'] ?? 0) * 2;
    } else if (position == 'RB' || position == 'WR') {
      // Example for RB or WR: (rush yards / 10) + (rush TD * 6) + (receptions * 1)
      calculatedPoints = (stats['Rush Yards'] ?? 0) / 10 +
          (stats['Rush TD'] ?? 0) * 6 +
          (stats['Receptions'] ?? 0) * 1;
    }

    return calculatedPoints;
  }
}

// Function to fetch player data
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

List<PlayerModel> myTeam = [];
