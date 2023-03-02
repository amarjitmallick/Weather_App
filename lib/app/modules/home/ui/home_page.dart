import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/app/modules/home/data/home_store.dart';
import 'package:weather_app/app/modules/home/ui/forecast_page.dart';
import 'package:weather_app/app/utils/theme.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeStore = Modular.get<HomeStore>();
  TextEditingController searchController = TextEditingController();

  _getLocationData() async {
    try {
      Position position = await _homeStore.determinePosition();
      _homeStore.fetchCurrentWeatherData(position.latitude.toString(), position.longitude.toString());
      _homeStore.fetchWeatherForecastData(position.latitude.toString(), position.longitude.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocationData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homeStore.scaffoldKey,
      backgroundColor: Themes.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Themes.white,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
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
                              const Text(
                                'Today',
                                style: Themes.bold22White,
                              ),
                              Text(
                                DateFormat('dd MMM, yyyy').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    _homeStore.weather!.dt! * 1000,
                                  ),
                                ),
                                style: Themes.bold22White,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                      'http://openweathermap.org/img/wn/${_homeStore.weather!.weather![0].icon!}@2x.png'),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Observer(builder: (context) {
                                      return _homeStore.showTempInCelsius
                                          ? Text(
                                              '${double.parse(_homeStore.weather!.main!.temp!.toString()).toInt()} °C',
                                              style: Themes.bold36White,
                                            )
                                          : Text(
                                              '${double.parse(((_homeStore.weather!.main!.temp! * 1.8) + 32).toString()).toInt()} °F',
                                              style: Themes.bold36White,
                                            );
                                    }),
                                  ),
                                ],
                              ),
                              Text(
                                _homeStore.weather!.weather![0].description!,
                                style: Themes.bold22White,
                              ),
                              Text(
                                _homeStore.weather!.name!,
                                style: Themes.bold22White,
                              ),
                              Observer(builder: (context) {
                                return _homeStore.showTempInCelsius
                                    ? Text(
                                        'Feels like ${double.parse(_homeStore.weather!.main!.feelsLike!.toString()).toInt()} °C',
                                        style: Themes.bold22White,
                                      )
                                    : Text(
                                        'Feels like ${double.parse(((_homeStore.weather!.main!.feelsLike! * 1.8) + 32).toString()).toInt()} °F',
                                        style: Themes.bold22White,
                                      );
                              }),
                              Text(
                                'Sunset at ${DateFormat('h:mm a').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    _homeStore.weather!.sys!.sunset! * 1000,
                                  ),
                                )}',
                                style: Themes.bold22White,
                              ),
                            ],
                          )
                        : const Text('No Data Available');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search location',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Themes.dailyBlue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Themes.gray.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              debugPrint(searchController.text);
              _homeStore.fetchCurrentWeatherDataByCity(searchController.text);
              _homeStore.fetchWeatherForecastDataByCity(searchController.text);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              backgroundColor: Themes.dailyBlue,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            child: const Text(
              'Get Weather Data',
              style: Themes.bold18White,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Show temperature in Celsius'),
                Switch(
                  value: _homeStore.showTempInCelsius,
                  onChanged: (val) {
                    setState(() {
                      _homeStore.showTempInCelsius = val;
                    });
                  },
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const ForecastDetailsPage();
              }));
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              backgroundColor: Themes.dailyBlue,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            child: const Text(
              'Show Weather Forecast Data',
              style: Themes.bold18White,
            ),
          ),
        ],
      ),
    );
  }
}
