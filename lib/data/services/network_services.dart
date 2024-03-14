import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/keys.dart';

class NetworkService {
  static final _client = Dio();

  static Future<Response?> getCurrentWeatherData(String lat, String lon) async {
    try {
      Response response = await _client.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Response?> getCurrentWeatherDataByCity(String city) async {
    try {
      Response response = await _client.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Response?> getWeatherForecastData(String lat, String lon) async {
    try {
      Response response = await _client.get(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Response?> getWeatherForecastDataByCity(String city) async {
    try {
      Response response = await _client.get(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric',
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
