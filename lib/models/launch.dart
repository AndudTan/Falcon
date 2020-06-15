import 'package:falconspacex/models/rocket.dart';

class Launch {
  final DateTime launchUTC;
  final Rocket rocket;

  Launch({this.launchUTC, this.rocket});

  Launch.fromJson(Map<dynamic, dynamic> parsedJson)
      : launchUTC = DateTime.parse(parsedJson['launch_date_utc']),
        rocket = Rocket.fromJson(parsedJson['rocket']);
}
