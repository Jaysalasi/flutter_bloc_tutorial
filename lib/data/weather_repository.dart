import 'dart:math';

import 'package:weather_app_bloc/data/model/weather.dart';

abstract class WeatherRepository {
  // throws network exception
  Future<Weather> fetchWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> fetchWeather(String cityName) {
    // simulate network delay
    return Future.delayed(Duration(seconds: 1), () {
      final random = Random();

      // simulate some network exception
      if (random.nextBool()) {
        throw NetworkException();
      }

      // return "fetched" weather
      return Weather(
        cityName: cityName,
        // temperature between 20 and 35.99
        temperatureCelcius: 20 + random.nextInt(15) + random.nextDouble(),
      );
    });
  }
}

class NetworkException implements Exception {}
