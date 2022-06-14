import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_calculator_using_bloc/home/screen/home_screen.dart';
import 'package:weather_calculator_using_bloc/services/api_service/api_service.dart';
import 'package:weather_calculator_using_bloc/services/connectivity_service/connectivity_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => WeatherApiService(),
          ),
          RepositoryProvider(
            create: (context) => ConnectivityService(),
          ),
        ],
        child: WeatherAppHome(),
      ),
    );
  }
}
