import 'package:flutter/material.dart';
import 'package:flutter_clima/screens/city_screen.dart';
import 'package:flutter_clima/utilities/constants.dart';
import 'package:flutter_clima/services/weather.dart';

class LocationScreen extends StatefulWidget {

  const LocationScreen({super.key, this.locationWeather});

  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  late int tempreture;
  late String screenBackground;
  late String cityName;
  late String weatherMessage;

  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {

    setState(() {

      if( weatherData == null) {
        tempreture = 0;
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        screenBackground = weatherModel.getWeatherBackground(900);
        return;
      }

      double temp = weatherData['main']['temp'];
      tempreture = temp.toInt();
      cityName = weatherData['name'];
      var condition = weatherData['weather'][0]['id'];
      screenBackground = weatherModel.getWeatherBackground(condition);
      weatherMessage = weatherModel.getMessage(tempreture);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(screenBackground),
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    }, 
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen(screenBackground: screenBackground)));
                      
                      if(typedName != null) {
                        var weatherData = await weatherModel.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    }, 
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  '$tempreture°',
                  textAlign: TextAlign.center,
                  style: kTempTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
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