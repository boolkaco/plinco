class LevelModel {
  final int maxPlanet;
  final int minSpeedPlanet;
  final int maxSpeedPlanet;
  final int stars;
  final String backgroundUrl;
  final String previewUrl;

  LevelModel({
    required this.maxPlanet,
    required this.minSpeedPlanet,
    required this.maxSpeedPlanet,
    required this.backgroundUrl,
    required this.previewUrl,
    this.stars = 0,
  });

  LevelModel copyWith({int? stars}) {
    return LevelModel(
      maxPlanet: this.maxPlanet,
      minSpeedPlanet: this.minSpeedPlanet,
      maxSpeedPlanet: this.maxSpeedPlanet,
      backgroundUrl: this.backgroundUrl,
      previewUrl: this.previewUrl,
      stars: stars ?? this.stars,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maxPlanet': maxPlanet,
      'minSpeedPlanet': minSpeedPlanet,
      'maxSpeedPlanet': maxSpeedPlanet,
      'stars': stars,
      'backgroundUrl': backgroundUrl,
      'previewUrl': previewUrl,
    };
  }

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      maxPlanet: json['maxPlanet'],
      minSpeedPlanet: json['minSpeedPlanet'],
      maxSpeedPlanet: json['maxSpeedPlanet'],
      backgroundUrl: json['backgroundUrl'],
      previewUrl: json['previewUrl'],
      stars: json['stars'],
    );
  }
}
