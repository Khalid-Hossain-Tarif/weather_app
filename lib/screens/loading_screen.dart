import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey  = '93e8432cdcd77669c24fb8bd197a5972';
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

  void getLocation() async{
      Location location = Location();
      await location.getCurrentLocation();
      NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}=${location.longitude}&appid=$apiKey');
      var weatherData = await networkHelper.getData();

      Navigator.push(context, MaterialPageRoute(builder: (context){
        return LocationScreen(
          locationWeather: weatherData,
        );
      }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWanderingCubes(
          color: Colors.white,
          size: 50.0,
          //controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
        ),
      ),
    );
  }
}
