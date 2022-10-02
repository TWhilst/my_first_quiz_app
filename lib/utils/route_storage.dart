class RouteStorage {
  int? points;
  int? lives;
  int? answeredCorrectly;
  int? totalDone;

  RouteStorage({
    this.totalDone,
    this.answeredCorrectly,
    this.lives,
    this.points
  });

  Map<String, dynamic> json() {
    return {
      "totalDone" : totalDone,
      "answeredCorrectly" : answeredCorrectly,
      "lives" : lives,
      "points" : points,
    };

  }
}