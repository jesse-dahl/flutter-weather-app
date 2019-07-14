import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double latitude, longitude;
  
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {

    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return(LocationScreen(locationWeather: weatherData,));
    }));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitDoubleBounce(
              color: Colors.white,
              size: 100.0,
            ),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
    );
  }
}
