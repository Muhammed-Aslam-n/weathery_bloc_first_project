import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_calculator_using_bloc/model/weather_result_model.dart';
import 'package:weather_calculator_using_bloc/services/exception/exceptions.dart';

import 'api_constants/api_constants.dart';

class WeatherApiService {
  Dio? _dio;

  WeatherApiService() {
    _dio = Dio();
  }

  Future<WeatherResultModel>getWeatherData({location}) async {
    debugPrint("fetching WeatherData");
    debugPrint("Giving Request is ");
    debugPrint((ApiConstants.baseUrl!+location+"&appid="+ApiConstants.weatherApiKey!));
    try{
      Response getWeatherDataResponse = await _dio!.get(ApiConstants.baseUrl!+location+"&appid="+ApiConstants.weatherApiKey!);
      WeatherResultModel weatherResultModel = WeatherResultModel.fromJson(getWeatherDataResponse.data);
      return weatherResultModel;
    }on DioError catch ( dioError){
      debugPrint('CaughtDioErrorInApiClass');
      throw BadRequestException(message: dioError.response!.data['message'].toString());
    }
  }
}
