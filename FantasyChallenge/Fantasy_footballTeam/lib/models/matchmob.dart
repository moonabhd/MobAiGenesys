class MatchModel {
  final String homeTeam;
  final int homeScore;
  final List<String> homeAssists;
  final List<String> homeScorers;
  final List<String> homeYellowCards;
  final List<String> homeRedCards;
  
  final String awayTeam;
  final int awayScore;
  final List<String> awayAssists;
  final List<String> awayScorers;
  final List<String> awayYellowCards;
  final List<String> awayRedCards;

  MatchModel({
    required this.homeTeam,
    required this.homeScore,
    required this.homeAssists,
    required this.homeScorers,
    required this.homeYellowCards,
    required this.homeRedCards,
    required this.awayTeam,
    required this.awayScore,
    required this.awayAssists,
    required this.awayScorers,
    required this.awayYellowCards,
    required this.awayRedCards,
  });

  // Convert a JSON object into a MatchModel object
  factory MatchModel.fromJson(Map<String, dynamic> json) {
    var team1 = json['team1'];
    var team2 = json['team2'];

    return MatchModel(
      homeTeam: team1['name'],
      homeScore: team1['score'],
      homeAssists: List<String>.from(team1['assists'] ?? []),
      homeScorers: List<String>.from(team1['scorers'] ?? []),
      homeYellowCards: List<String>.from(team1['yellow_cards'] ?? []),
      homeRedCards: List<String>.from(team1['red_cards'] ?? []),
      
      awayTeam: team2['name'],
      awayScore: team2['score'],
      awayAssists: List<String>.from(team2['assists'] ?? []),
      awayScorers: List<String>.from(team2['scorers'] ?? []),
      awayYellowCards: List<String>.from(team2['yellow_cards'] ?? []),
      awayRedCards: List<String>.from(team2['red_cards'] ?? []),
    );
  }

  // Convert a MatchModel object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'homeTeam': homeTeam,
      'homeScore': homeScore,
      'homeAssists': homeAssists,
      'homeScorers': homeScorers,
      'homeYellowCards': homeYellowCards,
      'homeRedCards': homeRedCards,
      
      'awayTeam': awayTeam,
      'awayScore': awayScore,
      'awayAssists': awayAssists,
      'awayScorers': awayScorers,
      'awayYellowCards': awayYellowCards,
      'awayRedCards': awayRedCards,
    };
  }
}
