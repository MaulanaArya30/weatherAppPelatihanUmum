import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherapp_pelatihanumum2023/screens/searchpage.dart';
import 'package:weatherapp_pelatihanumum2023/services/weathermodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel weather = WeatherModel();
  late int temps;
  late String city;
  late int wind;
  late int hum;
  late String condition;

  void initState() {
    super.initState();
    updateUI(null);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temps = 0;
        city = 'Choose City';
        wind = 0;
        hum = 0;
        condition = 'None';
        return;
      }
      var temp = weatherData['main']['temp'];
      temps = temp.toInt();
      var windspeed = weatherData['wind']['speed'];
      wind = windspeed.toInt();
      var humidity = weatherData['main']['humidity'];
      hum = humidity.toInt();
      condition = weatherData['weather'][0]['main'];
      city = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xFF4A91FF), Color(0xFF47BFDF)],
              ),
            ),
            child: SvgPicture.asset('assets/vector.svg'),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(36, 50, 36, 36),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/location.svg'),
                      SizedBox(width: 20),
                      Text(
                        city,
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  Container(
                    height: 160,
                    width: 160,
                    child: SvgPicture.asset('assets/$condition.svg'),
                  ),
                  SizedBox(height: 32),
                  WeatherInfo(
                    date: 'Today, 21 March',
                    temp: '$temps',
                    weather: condition,
                    wind: wind,
                    hum: hum,
                  ),
                  SizedBox(height: 28),
                  InkWell(
                    onTap: () async {
                      var cityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(),
                          ));
                      if (cityName != null) {
                        var weatherData =
                            await weather.getCityWeather(cityName);
                        updateUI(weatherData);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Choose City',
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF444D71),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({
    super.key,
    required this.date,
    required this.temp,
    required this.weather,
    required this.wind,
    required this.hum,
  });

  final String date;
  final String temp;
  final String weather;
  final int wind;
  final int hum;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 320,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Overpass',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          SizedBox(height: 10),
          Text(
            ' $temp°',
            style: TextStyle(
              color: Colors.white,
              fontSize: 100,
              fontFamily: 'Overpass',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          SizedBox(height: 10),
          Text(
            weather,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Overpass',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          SizedBox(height: 10),
          WeatherDetail(
            icon: SvgPicture.asset('assets/wind.svg'),
            title: 'Wind',
            space: 2,
            detail: '$wind km/h',
          ),
          WeatherDetail(
            icon: SvgPicture.asset('assets/hummidity.svg'),
            title: 'Hum',
            space: 5.5,
            detail: '$hum%',
          ),
        ],
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  WeatherDetail({
    super.key,
    required this.icon,
    required this.detail,
    required this.title,
    this.space,
  });

  final SvgPicture icon;
  final String detail;
  final String title;
  final double? space;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(width: space),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 20,
            width: 1,
            color: Colors.white,
          ),
          Text(
            '$detail',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
