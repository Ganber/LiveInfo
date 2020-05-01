import 'package:flutter/material.dart';
import 'package:liveinfo/screens/info_screen.dart';
import 'package:liveinfo/services/news.dart';
import 'package:liveinfo/services/stocks.dart';
import 'package:liveinfo/services/weather.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    try {
      var weatherData = await WeatherModel().getLocationWeather();
      var newsData = await News().getNewsData();
      var stocksData = await Stocks().getStocksData();

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return InfoScreen(weatherData, newsData, stocksData);
      }));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Loading(
          indicator: BallPulseIndicator(), size: 100.0, color: Colors.red),
    );
  }
}
