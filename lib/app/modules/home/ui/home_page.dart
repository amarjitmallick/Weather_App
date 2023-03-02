import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/app/modules/home/data/home_store.dart';
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

  _getLocationData() async {
    try {
      Position position = await _homeStore.determinePosition();
      _homeStore.fetchCurrentWeatherData(position.latitude.toString(), position.longitude.toString());
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
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  const Icon(
                                    Icons.sunny,
                                    color: Themes.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      _homeStore.weather!.main!.temp!.toString(),
                                      style: Themes.bold36White,
                                    ),
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
                              Text(
                                'Feels like ${_homeStore.weather!.main!.feelsLike!.toString()}',
                                style: Themes.bold22White,
                              ),
                              Text(
                                'Sunset at ${DateFormat('hh:mm').format(
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
        ],
      ),
    );
  }
}
