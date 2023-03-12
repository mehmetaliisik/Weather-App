import 'package:flutter/material.dart';
import 'package:flutter_clima/screens/location_screen.dart';
import 'package:flutter_clima/utilities/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_clima/services/weather.dart';
 
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
 
class _LoadingScreenState extends State<LoadingScreen> {
  
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {

    var weatherData = await WeatherModel().getLocationWeather();
    
    Navigator.push(context, MaterialPageRoute(builder:(context) => LocationScreen(locationWeather: weatherData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kBoxDecoration,
        child: const Center(
          child: SpinKitSpinningLines(
            color: Colors.white,
            size: 100.0,
          ),
        ),
      ),

    );
  }
}