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

  PlayerModel copyWith({
    String? id,
    String? name,
    String? position,
    String? team,
    int? points,
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
}