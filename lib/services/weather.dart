import 'package:clima_ma/services/location.dart';
import 'networking.dart';
const apiKey = '3b6e3b812b33a625554fcbd9781b324e';
const openWeatherURl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    Location location = Location();
    await location.getCurrentLocation();
    // var url = '$openWeatherURl?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper =
        NetworkHelper("$openWeatherURl?q=$cityName&appid=$apiKey&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    try {
      await location.getCurrentLocation();
      NetworkHelper networkHelper = NetworkHelper(
          "$openWeatherURl?lat=${location.latitude}&lon=${location.longtitude}&appid=$apiKey&units=metric");
      var weatherData = await networkHelper.getData();
      return weatherData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  String getweatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition < 804) {
      return '☁️';
    } else {
      return '🤷 ';
    }
  }

  String getMassage(double temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
