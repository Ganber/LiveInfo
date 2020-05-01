import 'package:flutter/material.dart';
import 'package:liveinfo/services/weather.dart';

class WeatherCard extends StatefulWidget {
  WeatherCard(this.locationWeather);

  final locationWeather;

  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  String rainChance;
  String iconURL;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        rainChance = '15';
        iconURL = 'https://img.icons8.com/office/30/000000/sun.png';
        return;
      }
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weatherIcon = weatherData['weather'][0]['icon'];
      iconURL = '$openWeatherIconURL/$weatherIcon@2x.png';
      weatherMessage = weatherData['weather'][0]['description'];
      cityName = weatherData['name'];
      rainChance = '15';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      child: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 10,
          child: ListTile(
            leading: Image.network(iconURL),
            title: Text('$temperature°C in $cityName'),
            subtitle: Text(weatherMessage),
            trailing: Text('☂ $rainChance% today'),
            onTap: () async {
              var weatherData = await weather.getLocationWeather();
              updateUI(weatherData);
            },
          ),
        ),
      ),
    );
  }
}
