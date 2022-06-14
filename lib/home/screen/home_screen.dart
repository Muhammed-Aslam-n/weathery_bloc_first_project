import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_calculator_using_bloc/bloc/weather/weather_bloc.dart';
import 'package:weather_calculator_using_bloc/constants/ui_constants.dart';
import 'package:weather_calculator_using_bloc/services/exception/exceptions.dart';
import 'package:weather_calculator_using_bloc/widgets/appbar.dart';
import 'package:weather_calculator_using_bloc/widgets/no_internet_widget.dart';
import 'package:weather_calculator_using_bloc/widgets/no_result_found_widget.dart';

import '../../services/api_service/api_service.dart';
import '../../services/connectivity_service/connectivity_service.dart';

class WeatherAppHome extends StatelessWidget {
  WeatherAppHome({Key? key}) : super(key: key);
  final TextEditingController locationGlobal = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(
        RepositoryProvider.of<WeatherApiService>(context),
        RepositoryProvider.of<ConnectivityService>(context),
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
              title: "Weathery",
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black54,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            body: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherNoConnectionState) {
                  return noInternetWidget();
                }
                if (state is WeatherExceptionState) {
                  if (state.appException is BadRequestException) {
                    return Column(
                      children: [
                        _requestWidget(context),
                        const SizedBox(
                          height: 20,
                        ),
                        noResultFoundWidget(),
                      ],
                    );
                  }
                }

                if (state is WeatherInitialState) {
                  return _requestWidget(context);
                }
                if (state is WeatherLoadedState) {
                  return Column(
                    children: [
                      _requestWidget(context),
                      const SizedBox(
                        height: 20,
                      ),
                      ..._weatherResultWidget(state),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }
                if (state is WeatherLoadingState) {
                  return Column(
                    children: [
                      _requestWidget(context),
                      const SizedBox(
                        height: 50,
                      ),
                      const CircularProgressIndicator(
                        color: Colors.redAccent,
                        strokeWidth: 0.3,
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }

  _requestWidget(context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              // height: 37,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: locationGlobal,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red.shade200,
                      ),
                    ),
                    focusedBorder: searchBarOutline,
                    errorBorder: searchBarOutline,
                    focusedErrorBorder: searchBarOutline,
                    hintText: "Search Weather",
                    hintStyle: const TextStyle(fontSize: 12),
                    border: searchBarOutline,
                  ),
                  validator: (location) {
                    if (location!.isEmpty) {
                      return "Enter a Location";
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<WeatherBloc>(context)
                      .add(LoadWeatherEvent(location: locationGlobal.text));
                }
              },
              child: const Text("Find"),
              style: ElevatedButton.styleFrom(primary: Colors.red.shade200),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ],
    );
  }

  _weatherResultWidget(WeatherLoadedState state) {
    List<Widget> weatherResultWidget = [];
    Widget climateIcon = const Icon(
      Icons.sunny,
      size: 105,
      color: Colors.orange,
    );
    Widget tempText = Text(
      "${state.weather!.main!.temp}",
      style: const TextStyle(color: Colors.black, fontSize: 22),
    );
    Widget locationText = Text(
      "${state.weather!.name}",
      style: const TextStyle(color: Colors.black38, fontSize: 20),
    );
    Widget additionalInfoText = const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          "Additional Information",
          style: TextStyle(color: Colors.black87, fontSize: 19),
        ),
      ),
    );
    Widget additionInfoSection = Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Expanded(child: Text("Wind")),
              Expanded(child: Text("${state.weather!.wind!.speed}")),
              const SizedBox(
                width: 10,
              ),
              const Expanded(child: Text("Humidity")),
              Expanded(child: Text("${state.weather!.main!.humidity}")),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Expanded(child: Text("Pressure")),
              Expanded(child: Text("${state.weather!.main!.pressure}")),
              const SizedBox(
                width: 10,
              ),
              const Expanded(child: Text("Feels Like")),
              Expanded(child: Text("${state.weather!.main!.feelsLike}")),
            ],
          )
        ],
      ),
    );
    weatherResultWidget.add(
      const SizedBox(
        height: 25,
      ),
    );
    weatherResultWidget.add(climateIcon);
    weatherResultWidget.add(
      const SizedBox(
        height: 15,
      ),
    );
    weatherResultWidget.add(tempText);
    weatherResultWidget.add(
      const SizedBox(
        height: 25,
      ),
    );
    weatherResultWidget.add(locationText);
    weatherResultWidget.add(
      const SizedBox(
        height: 45,
      ),
    );
    weatherResultWidget.add(additionalInfoText);

    weatherResultWidget.add(additionInfoSection);
    return weatherResultWidget;
  }
}
