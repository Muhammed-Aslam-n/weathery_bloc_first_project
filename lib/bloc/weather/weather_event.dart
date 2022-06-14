part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class LoadWeatherEvent extends WeatherEvent {
  final String? location;

  const LoadWeatherEvent({this.location});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoInternetEvent extends WeatherEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialEvent extends WeatherEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

