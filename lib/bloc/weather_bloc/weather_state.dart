part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherDataLoading extends WeatherState {}

final class WeatherDataFetchSuccess extends WeatherState {
  final WeatherModel weatherModel;

  WeatherDataFetchSuccess({required this.weatherModel});
}

final class WeatherDataFetchFailure extends WeatherState {
  final String message;

  WeatherDataFetchFailure(this.message);
}
