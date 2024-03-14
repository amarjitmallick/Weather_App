import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_forecast_model.dart';
import 'package:weather_app/data/services/network_services.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherRepository {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  }

  Future<WeatherModel> fetchCurrentWeatherData(String lat, String lon) async {
    try {
      Response? response = await NetworkService.getCurrentWeatherData(lat, lon);
      if (response == null || response.statusCode != 200) {
        throw "Something went wrong";
      }
      return WeatherModel.fromJson(response.data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<WeatherModel> fetchCurrentWeatherDataByCity(String cityName) async {
    try {
      Response? response = await NetworkService.getCurrentWeatherDataByCity(cityName);
      if (response == null || response.statusCode != 200) {
        throw "Something went wrong";
      }
      return WeatherModel.fromJson(response.data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<WeatherForecastModel> fetchWeatherForecastData(String lat, String lon) async {
    try {
      Response? response = await NetworkService.getWeatherForecastData(lat, lon);
      if (response == null || response.statusCode != 200) {
        throw "Something went wrong";
      }
      return WeatherForecastModel.fromJson(response.data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<WeatherForecastModel> fetchWeatherForecastDataByCity(String name) async {
    try {
      Response? response = await NetworkService.getWeatherForecastDataByCity(name);
      if (response == null || response.statusCode != 200) {
        throw "Something went wrong";
      }
      return WeatherForecastModel.fromJson(response.data);
    } catch (e) {
      throw e.toString();
    }
  }
}
