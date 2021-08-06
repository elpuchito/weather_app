import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/search/search.dart';
import 'package:flutter_weather/theme/theme.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:pedantic/pedantic.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: WeatherView(),
    );
  }
}

class WeatherView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: const Text('Bold.co prueba desarrollador flutter'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Center(
                child: BlocConsumer<WeatherCubit, WeatherState>(
                  listener: (context, state) {
                    if (state.status.isSuccess) {
                      context.read<ThemeCubit>().updateTheme(state.weather);
                    }
                  },
                  builder: (context, state) {
                    switch (state.status) {
                      case WeatherStatus.initial:
                        return const WeatherEmpty();
                      case WeatherStatus.loading:
                        return const WeatherLoading();
                      case WeatherStatus.success:
                        return WeatherPopulated(
                          weather: state.weather,
                          units: state.temperatureUnits,
                          onRefresh: () {
                            return context
                                .read<WeatherCubit>()
                                .refreshWeather();
                          },
                        );
                      case WeatherStatus.failure:
                      default:
                        return const WeatherError();
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'Forcast for the next 2 days',
                  style: theme.textTheme.headline4?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BlocConsumer<WeatherCubit, WeatherState>(
                    listener: (context, state) {
                      if (state.status.isSuccess) {
                        context.read<ThemeCubit>().updateTheme(state.weather);
                      }
                    },
                    builder: (context, state) {
                      switch (state.status) {
                        case WeatherStatus.initial:
                          return const WeatherEmpty();
                        case WeatherStatus.loading:
                          return const WeatherLoading();
                        case WeatherStatus.success:
                          return WeatherForTheNextDays(
                            weather: state.weather,
                            units: state.temperatureUnits,
                            onRefresh: () {
                              return context
                                  .read<WeatherCubit>()
                                  .refreshWeather();
                            },
                          );
                        case WeatherStatus.failure:
                        default:
                          return const WeatherError();
                      }
                    },
                  ),
                  BlocConsumer<WeatherCubit, WeatherState>(
                    listener: (context, state) {
                      if (state.status.isSuccess) {
                        context.read<ThemeCubit>().updateTheme(state.weather);
                      }
                    },
                    builder: (context, state) {
                      switch (state.status) {
                        case WeatherStatus.initial:
                          return const WeatherEmpty();
                        case WeatherStatus.loading:
                          return const WeatherLoading();
                        case WeatherStatus.success:
                          return WeatherForTomorrow(
                            weather: state.weather,
                            units: state.temperatureUnits,
                            onRefresh: () {
                              return context
                                  .read<WeatherCubit>()
                                  .refreshWeather();
                            },
                          );
                        case WeatherStatus.failure:
                        default:
                          return const WeatherError();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());
          unawaited(context.read<WeatherCubit>().fetchWeather(city));
        },
      ),
    );
  }
}
