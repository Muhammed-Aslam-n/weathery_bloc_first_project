import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_calculator_using_bloc/model/weather_result_model.dart';
import 'package:weather_calculator_using_bloc/services/exception/exceptions.dart';
import '../../services/api_service/api_service.dart';
import '../../services/connectivity_service/connectivity_service.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherApiService _weatherApiService;
  final ConnectivityService _connectivityService;

  WeatherBloc(this._weatherApiService, this._connectivityService)
      : super(WeatherInitialState()) {
    _connectivityService.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        add(NoInternetEvent());
      } else {
        add(InitialEvent());
      }
    });

    on<InitialEvent>((event, emit) => emit(WeatherInitialState()));
    on<NoInternetEvent>((event, emit) {
      emit(WeatherNoConnectionState());
    });


    on<LoadWeatherEvent>((event, emit) async {
      emit(WeatherLoadingState());
      dynamic weatherData;
      try {
        weatherData =
            await _weatherApiService.getWeatherData(location: event.location);
        emit(WeatherLoadedState(weatherData));
      } on Exception catch (ex) {
        emit(WeatherInitialState());
        if(ex is BadRequestException){
          debugPrint('CaughtDioErrorInBloc which is $ex');
          emit(WeatherExceptionState(ex));
        }
      }
    });

  }
}
