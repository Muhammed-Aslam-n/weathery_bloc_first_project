part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitialState extends WeatherState {
  @override
  List<Object> get props => [];
}
class WeatherLoadingState extends WeatherState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherLoadedState extends WeatherState{
  final WeatherResultModel? weather;

  const WeatherLoadedState(this.weather);
  @override
  // TODO: implement props
  List<Object?> get props => [weather];
}

class WeatherNoConnectionState extends WeatherState{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}

class WeatherExceptionState extends WeatherState{
  final AppException appException;
  const WeatherExceptionState(this.appException);
  @override
  // TODO: implement props
  List<Object?> get props => [appException];
}