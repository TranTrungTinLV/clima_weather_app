import 'package:flutter/material.dart';
import 'package:clima_ma/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';
import 'package:clima_ma/services/networking.dart';
import 'package:clima_ma/services/weather.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    super.initState();
    getLocationData();
    print('this line of code is triggerred');
  }

  void getLocationData() async {

    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
          weatherData: weatherData,
      );
    }));
  }

  void geturl(Location location) async {
    // var longtitude = jsonDecode(data)['coord']['lon'];
    // print(longtitude);
    // var weatherDesciption = jsonDecode(data)['weather'][0]['main'];
    // print(weatherDesciption);

    // print('Responese status: ${response.statusCode}');
    // print('Responese body: ${response.body}');
    // print(response.request?.url);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
