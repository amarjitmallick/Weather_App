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

  late final _$fetchCurrentWeatherDataAsyncAction =
      AsyncAction('_HomeStore.fetchCurrentWeatherData', context: context);

  @override
  Future<void> fetchCurrentWeatherData(String lat, String lon) {
    return _$fetchCurrentWeatherDataAsyncAction
        .run(() => super.fetchCurrentWeatherData(lat, lon));
  }

  @override
  String toString() {
    return '''
fetchingData: ${fetchingData},
weather: ${weather}
    ''';
  }
}
