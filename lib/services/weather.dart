import 'package:flutter_clima/services/locations.dart';
import 'package:flutter_clima/services/networking.dart';
import 'package:flutter_clima/utilities/constants.dart';


class WeatherModel {
  
  Future<dynamic> getCityWeather(String cityName) async {
    String url = '$openWeatherURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async{
    Location location = Location();
    await location.getCurrentLocation();

    String url = '$openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
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
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getWeatherBackground(int condition) {
    if (condition < 600) {
      return 'images/condition/rain.jpeg';
    } else if (condition < 700) {
      return 'images/condition/snow.jpeg';
    } else if (condition < 800) {
      return 'images/condition/foggy.jpeg';
    } else if (condition == 800) {
      return 'images/condition/sunny.jpeg';
    } else if (condition <= 804) {
      return 'images/condition/cloud.jpeg';
    } else {
      return 'images/condition/sunny.jpeg';
    }
  }

  String getMessage(int temp) {
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