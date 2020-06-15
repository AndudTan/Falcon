class Rocket {
  final String rocketName;

  Rocket({this.rocketName});

  Rocket.fromJson(Map<dynamic, dynamic> parsedJson)
      : rocketName = parsedJson['rocket_name'];
}
