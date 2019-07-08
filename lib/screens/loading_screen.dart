import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  Location location = Location();
  @override
  void initState() {
    super.initState();
    location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    String myMargin = '15';
    double myMarginAsDouble;

    try {
      myMarginAsDouble = double.parse(myMargin);
    }
    catch (e) {
      print(e);
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(myMarginAsDouble ?? 15.0),
        color: Colors.red,
      ),
    );
  }
}
