import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherDataRequested>(
      (event, emit) async {
        emit(WeatherDataLoading());
        try {
          final weather = await weatherRepository.fetchCurrentWeatherDataByCity(event.cityName);
          emit(WeatherDataFetchSuccess(weatherModel: weather));
        } catch (e) {
          emit(WeatherDataFetchFailure(e.toString()));
        }
      },
    );

    on<LocationRequested>((event, emit) async {
      try {
        final position = await weatherRepository.determinePosition();
        final weather = await weatherRepository.fetchCurrentWeatherData(
            position.latitude.toString(), position.longitude.toString());
        emit(WeatherDataFetchSuccess(weatherModel: weather));
      } catch (e) {
        emit(WeatherDataFetchFailure(e.toString()));
      }
    });
  }
}
