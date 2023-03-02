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
            child: Observer(
              builder: (context) {
                return _homeStore.weather != null
                    ? Column(
                        children: [
                          const Text('Today'),
                          Row(
                            children: [
                              const Icon(Icons.sunny),
                              Text(_homeStore.weather!.main!.temp!.toString()),
                            ],
                          ),
                          Text(_homeStore.weather!.weather![0].description!),
                          Text(_homeStore.weather!.name!),
                          Text(
                            DateFormat().format(
                              DateTime.parse(
                                _homeStore.weather!.dt!.toString(),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text('Feels like ${_homeStore.weather!.main!.feelsLike!.toString()}'),
                              Text('Sunset at 6:30 PM'),
                            ],
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
