import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clima_ma/utilities/constants.dart';
import 'package:clima_ma/services/location.dart';
import 'package:clima_ma/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherData});
  final weatherData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int? temperent;
  late String weatherIcon;
  late String Massageweather;
  late String City_name;
  WeatherModel weather_model = WeatherModel();
  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperent = 0;
        weatherIcon = 'Error';
        Massageweather = 'Unable to get weather data';
        City_name = "";
        return;
      }
      double temp = weatherData['main']['temp'];
      temperent = temp.toInt();
      Massageweather = weather_model.getMassage(temp);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather_model.getweatherIcon(condition);
      City_name = weatherData['name'];
      print(City_name);
    });


    // print(temp);
  }

  void showError(String message) async {
    final dialog = AlertDialog(
      content: Text(message),
    );
    await showDialog(context: context, builder: (_) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build data => ${widget.weatherData.toString()}");
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/cloudy.jpg'),
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
                      var weatherData =
                          await weather_model.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typeName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      print(typeName);
                      if (typeName != null) {
                        var weatherData =
                            await weather_model.getCityWeather(typeName);
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
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperent°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$Massageweather in $City_name",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
