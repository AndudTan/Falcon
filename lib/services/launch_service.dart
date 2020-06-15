import 'package:Falcon/models/launch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LaunchService {
  Future<Launch> fetchLaunch() async {
    var response =
        await http.get('https://api.spacexdata.com/v3/launches/upcoming');

    var json = convert.jsonDecode(response.body);

    var launch = Launch.fromJson(json[0]);

    return launch;
  }
}
