import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(LocationRequested());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Themes.white,
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherDataFetchFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          return state is WeatherDataLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
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
                      child: state is WeatherDataFetchSuccess
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
                                      state.weatherModel.dt! * 1000,
                                    ),
                                  ),
                                  style: Themes.bold22White,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                        'http://openweathermap.org/img/wn/${state.weatherModel.weather![0].icon!}@2x.png'),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        '${double.parse(state.weatherModel.main!.temp!.toString()).toInt()} °C',
                                        style: Themes.bold36White,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  state.weatherModel.weather![0].description!,
                                  style: Themes.bold22White,
                                ),
                                Text(
                                  state.weatherModel.name!,
                                  style: Themes.bold22White,
                                ),
                                Text(
                                  'Feels like ${double.parse(state.weatherModel.main!.feelsLike!.toString()).toInt()} °C',
                                  style: Themes.bold22White,
                                ),
                                Text(
                                  'Sunset at ${DateFormat('h:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      state.weatherModel.sys!.sunset! * 1000,
                                    ),
                                  )}',
                                  style: Themes.bold22White,
                                ),
                              ],
                            )
                          : const Center(
                              child: Text("No Data Available"),
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
                        BlocProvider.of<WeatherBloc>(context)
                            .add(WeatherDataRequested(cityName: searchController.text.trim()));
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
                  ],
                );
        },
      ),
    );
  }
}
