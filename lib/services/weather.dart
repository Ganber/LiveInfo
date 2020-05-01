import 'package:liveinfo/services/location.dart';
import 'package:liveinfo/services/networking.dart';

const apiKey = '1d7d332d1636ced903c116927f8efebc';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const openWeatherIconURL = 'http://openweathermap.org/img/wn';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  void getRainChance() {}
}
