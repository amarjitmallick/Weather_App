// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$fetchingDataAtom =
      Atom(name: '_HomeStore.fetchingData', context: context);

  @override
  bool get fetchingData {
    _$fetchingDataAtom.reportRead();
    return super.fetchingData;
  }

  @override
  set fetchingData(bool value) {
    _$fetchingDataAtom.reportWrite(value, super.fetchingData, () {
      super.fetchingData = value;
    });
  }

  late final _$showTempInCelsiusAtom =
      Atom(name: '_HomeStore.showTempInCelsius', context: context);

  @override
  bool get showTempInCelsius {
    _$showTempInCelsiusAtom.reportRead();
    return super.showTempInCelsius;
  }

  @override
  set showTempInCelsius(bool value) {
    _$showTempInCelsiusAtom.reportWrite(value, super.showTempInCelsius, () {
      super.showTempInCelsius = value;
    });
  }

  late final _$weatherAtom = Atom(name: '_HomeStore.weather', context: context);

  @override
  WeatherModel? get weather {
    _$weatherAtom.reportRead();
    return super.weather;
  }

  @override
  set weather(WeatherModel? value) {
    _$weatherAtom.reportWrite(value, super.weather, () {
      super.weather = value;
    });
  }

  late final _$weatherForecastAtom =
      Atom(name: '_HomeStore.weatherForecast', context: context);

  @override
  WeatherForecastModel? get weatherForecast {
    _$weatherForecastAtom.reportRead();
    return super.weatherForecast;
  }

  @override
  set weatherForecast(WeatherForecastModel? value) {
    _$weatherForecastAtom.reportWrite(value, super.weatherForecast, () {
      super.weatherForecast = value;
    });
  }

  late final _$determinePositionAsyncAction =
      AsyncAction('_HomeStore.determinePosition', context: context);

  @override
  Future<Position> determinePosition() {
    return _$determinePositionAsyncAction.run(() => super.determinePosition());
  }

  late final _$fetchCurrentWeatherDataAsyncAction =
      AsyncAction('_HomeStore.fetchCurrentWeatherData', context: context);

  @override
  Future<void> fetchCurrentWeatherData(String lat, String lon) {
    return _$fetchCurrentWeatherDataAsyncAction
        .run(() => super.fetchCurrentWeatherData(lat, lon));
  }

  late final _$fetchCurrentWeatherDataByCityAsyncAction =
      AsyncAction('_HomeStore.fetchCurrentWeatherDataByCity', context: context);

  @override
  Future<void> fetchCurrentWeatherDataByCity(String name) {
    return _$fetchCurrentWeatherDataByCityAsyncAction
        .run(() => super.fetchCurrentWeatherDataByCity(name));
  }

  late final _$fetchWeatherForecastDataAsyncAction =
      AsyncAction('_HomeStore.fetchWeatherForecastData', context: context);

  @override
  Future<void> fetchWeatherForecastData(String lat, String lon) {
    return _$fetchWeatherForecastDataAsyncAction
        .run(() => super.fetchWeatherForecastData(lat, lon));
  }

  late final _$fetchWeatherForecastDataByCityAsyncAction = AsyncAction(
      '_HomeStore.fetchWeatherForecastDataByCity',
      context: context);

  @override
  Future<void> fetchWeatherForecastDataByCity(String name) {
    return _$fetchWeatherForecastDataByCityAsyncAction
        .run(() => super.fetchWeatherForecastDataByCity(name));
  }

  @override
  String toString() {
    return '''
fetchingData: ${fetchingData},
showTempInCelsius: ${showTempInCelsius},
weather: ${weather},
weatherForecast: ${weatherForecast}
    ''';
  }
}
