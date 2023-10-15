import 'package:flutter_svg/svg.dart';
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

  SvgPicture getWeatherIcon(int condition) {
    if (condition < 300) {
      return SvgPicture.asset('assets/thunder.svg'); //Thunder //Thunderstorm
    } else if (condition < 600) {
      return SvgPicture.asset('assets/rain.svg'); //Rain
    } else if (condition < 700) {
      return SvgPicture.asset('assets/snow.svg'); //Snow
    } else if (condition < 800) {
      return SvgPicture.asset('assets/fog.svg'); //Fog
    } else if (condition == 800) {
      return SvgPicture.asset('assets/sunny.svg'); //Sunny
    } else if (condition <= 804) {
      return SvgPicture.asset('assets/clouds.svg'); //Clouds
    } else {
      return SvgPicture.asset('assets/null.svg'); //Null
    }
  }
}
