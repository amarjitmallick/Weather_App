import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/app/modules/home/data/home_store.dart';
import 'package:weather_app/app/utils/theme.dart';

class ForecastDetailsPage extends StatefulWidget {
  const ForecastDetailsPage({Key? key}) : super(key: key);

  @override
  State<ForecastDetailsPage> createState() => _ForecastDetailsPageState();
}

class _ForecastDetailsPageState extends State<ForecastDetailsPage> {
  final _homeStore = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Themes.white,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _homeStore.weatherForecast!.weatherDataList!.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Themes.dailyBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Observer(
              builder: (context) {
                return _homeStore.fetchingData
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Themes.white,
                        ),
                      )
                    : _homeStore.weather != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                DateFormat('dd MMM, yyyy h:mm a').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    _homeStore.weatherForecast!.weatherDataList![index].dt! * 1000,
                                  ),
                                ),
                                style: Themes.bold22White,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                      'http://openweathermap.org/img/wn/${_homeStore.weatherForecast!.weatherDataList![index].weather![0].icon!}@2x.png'),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Observer(builder: (context) {
                                      return _homeStore.showTempInCelsius
                                          ? Text(
                                              '${double.parse(_homeStore.weatherForecast!.weatherDataList![index].main!.temp!.toString()).toInt()} °C',
                                              style: Themes.bold36White,
                                            )
                                          : Text(
                                              '${double.parse(((_homeStore.weatherForecast!.weatherDataList![index].main!.temp! * 1.8) + 32).toString()).toInt()} °F',
                                              style: Themes.bold36White,
                                            );
                                    }),
                                  ),
                                ],
                              ),
                              Text(
                                _homeStore.weatherForecast!.weatherDataList![index].weather![0].description!,
                                style: Themes.bold22White,
                              ),
                              Text(
                                _homeStore.weatherForecast!.city!.name!,
                                style: Themes.bold22White,
                              ),
                              Observer(builder: (context) {
                                return _homeStore.showTempInCelsius
                                    ? Text(
                                        'Feel like ${double.parse(_homeStore.weatherForecast!.weatherDataList![index].main!.feelsLike!.toString()).toInt()} °C',
                                        style: Themes.bold22White,
                                      )
                                    : Text(
                                        'Feel like ${double.parse(((_homeStore.weatherForecast!.weatherDataList![index].main!.feelsLike! * 1.8) + 32).toString()).toInt()} °F',
                                        style: Themes.bold22White,
                                      );
                              }),
                              Text(
                                'Sunset at ${DateFormat('h:mm a').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    _homeStore.weatherForecast!.city!.sunset! * 1000,
                                  ),
                                )}',
                                style: Themes.bold22White,
                              ),
                            ],
                          )
                        : const Text('No Data Available');
              },
            ),
          );
        },
      ),
    );
  }
}
