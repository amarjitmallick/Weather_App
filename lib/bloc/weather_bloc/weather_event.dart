part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class LocationRequested extends WeatherEvent {}

class WeatherDataRequested extends WeatherEvent {
  final String cityName;

  WeatherDataRequested({required this.cityName});
}
