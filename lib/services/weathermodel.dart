import 'package:weatherapp_pelatihanumum2023/services/network.dart';
import 'package:weatherapp_pelatihanumum2023/utilities/config.dart';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    Network network = Network(
        url: '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await network.getData();
    return weatherData;
  }
}
