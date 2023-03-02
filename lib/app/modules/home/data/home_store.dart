import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_app/app/models/weather_model.dart';
import 'package:weather_app/app/services/network_services.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @observable
  bool fetchingData = false;

  @observable
  WeatherModel? weather;

  @action
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

  @action
  Future<void> fetchCurrentWeatherData(String lat, String lon) async {
    fetchingData = true;
    Response response = await NetworkService.getCurrentWeatherData(lat, lon);
    if (response.statusCode == 200) {
      debugPrint(response.data.toString());
      weather = WeatherModel.fromJson(response.data);
    } else {
      scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(response.data['message']),
        ),
      );
    }
    fetchingData = false;
  }
}
