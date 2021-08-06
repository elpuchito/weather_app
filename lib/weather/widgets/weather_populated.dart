import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart'
    show WeatherCondition;

class WeatherPopulated extends StatelessWidget {
  const WeatherPopulated({
    Key? key,
    required this.weather,
    required this.units,
    required this.onRefresh,
  }) : super(key: key);

  final Weather weather;
  final TemperatureUnits units;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        clipBehavior: Clip.none,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              _WeatherIcon(condition: weather.condition),
              Text(
                weather.location,
                style: theme.textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
              Text(
                weather.formattedTemperature(units),
                style: theme.textTheme.headline3?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '''Last Updated at ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}''',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherForTomorrow extends StatelessWidget {
  const WeatherForTomorrow({
    Key? key,
    required this.weather,
    required this.units,
    required this.onRefresh,
  }) : super(key: key);

  final Weather weather;
  final TemperatureUnits units;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        clipBehavior: Clip.none,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              _WeatherIcon(condition: weather.condition),
              Text(
                weather.location,
                style: theme.textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
              Text(
                weather.formattedTemperature2(units),
                style: theme.textTheme.headline3?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '''Last Updated at ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}''',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherForTheNextDays extends StatelessWidget {
  const WeatherForTheNextDays({
    Key? key,
    required this.weather,
    required this.units,
    required this.onRefresh,
  }) : super(key: key);

  final Weather weather;
  final TemperatureUnits units;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        clipBehavior: Clip.none,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              _WeatherIcon(condition: weather.condition),
              Text(
                weather.location,
                style: theme.textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
              Text(
                weather.formattedTemperature3(units),
                style: theme.textTheme.headline3?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '''Last Updated at ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}''',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({Key? key, required this.condition}) : super(key: key);

  static const _iconSize = 100.0;

  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return Text(
      condition.toEmoji,
      style: const TextStyle(fontSize: _iconSize),
    );
  }
}

extension on WeatherCondition {
  String get toEmoji {
    switch (this) {
      case WeatherCondition.clear:
        return '☀️';
      case WeatherCondition.rainy:
        return '🌧️';
      case WeatherCondition.cloudy:
        return '☁️';
      case WeatherCondition.snowy:
        return '🌨️';
      case WeatherCondition.unknown:
      default:
        return '❓';
    }
  }
}

extension on Weather {
  String formattedTemperature(TemperatureUnits units) {
    return '''${temperature.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}

extension on Weather {
  String formattedTemperature2(TemperatureUnits units) {
    return '''${(temperature.value - 7.5).toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}

extension on Weather {
  String formattedTemperature3(TemperatureUnits units) {
    return '''${(temperature.value - 11.8).toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}
