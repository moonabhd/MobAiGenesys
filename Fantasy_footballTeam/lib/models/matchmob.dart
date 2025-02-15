class Match_model {
  final String homeTeam;
  final int homeScore;
  final int awayScore;
  final String awayTeam;

  Match_model({
    required this.homeTeam,
    required this.homeScore,
    required this.awayScore,
    required this.awayTeam,
  });

  // Convert a JSON object into a Match_model object
  factory Match_model.fromJson(Map<String, dynamic> json) {
    return Match_model(
      homeTeam: json['homeTeam'],
      homeScore: json['homeScore'],
      awayScore: json['awayScore'],
      awayTeam: json['awayTeam'],
    );
  }

  // Convert a Match_model object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'homeTeam': homeTeam,
      'homeScore': homeScore,
      'awayScore': awayScore,
      'awayTeam': awayTeam,
    };
  }
}
