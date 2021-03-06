import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});


  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  double temperature;
  int condition;
  String cityName;
  String weatherMessage;
  String weatherIcon;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherMessage = 'Unable to get weather data';
        weatherIcon = 'Error';
        cityName = '';
        return;
      }
      temperature = weatherData['main']['temp'];
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      weatherMessage = weatherModel.getMessage(temperature.toInt());
      weatherIcon = weatherModel.getWeatherIcon(condition);
    });

    print(temperature);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return(CityScreen());
                      }));
                      if (typedName != null) {
                        var weatherData = await weatherModel.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${temperature.round()}°',
                    style: kTempTextStyle,
                  ),
                  Text(
                    weatherIcon,
                    style: kConditionTextStyle,
                  ),
                ],
              ),
             
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                child: Column(
                  
                  children: <Widget>[
                    Text(
                      
                      "$weatherMessage in $cityName",
                      //textAlign: TextAlign.right,
                      style: kMessageTextStyle,
                    ),
                  ],
                ),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// double temperature = decodedData['main']['temp'];
// String cityName = decodedData['name'];