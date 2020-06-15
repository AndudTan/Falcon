import 'dart:async';

import 'models/launch.dart';
import 'services/launch_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var launchService = LaunchService();
    return FutureProvider(
      create: (context) => launchService.fetchLaunch(),
      child: MaterialApp(
        home: Home(),
        theme: ThemeData(
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Timer timer;
  Launch launch;
  String countdown;

  @override
  void initState() {
    countdown = '';
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (launch != null) {
        var diff = launch.launchUTC.difference((DateTime.now().toUtc()));
        setState(() {
          countdown = durationToString(diff);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    launch = Provider.of<Launch>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Falcon',
          style: GoogleFonts.ubuntu(),
        ),
        centerTitle: true,
      ),
      body: (launch != null)
          ? Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('TIME TO LAUNCH',
                            style: GoogleFonts.oxygen(
                                color: Colors.amberAccent, letterSpacing: 2.0)),
                        Text(countdown,
                            style: GoogleFonts.courierPrime(fontSize: 60.0)),
                        Text(launch.rocket.rocketName),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  String durationToString(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
