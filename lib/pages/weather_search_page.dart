import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/states/bloc/weather_bloc.dart';

import '../data/model/weather.dart';

class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage({Key? key}) : super(key: key);

  @override
  State<WeatherSearchPage> createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Search"),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: BlocConsumer<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return buildInitialInput();
              } else if (state is WeatherLoading) {
                return buildLoading();
              } else if (state is WeatherLoaded) {
                return buildColumnWithData(state.weather);
              } else {
                // state is weather error
                return buildInitialInput();
              }
            },
            listener: (context, state) {
              if (state is WeatherError) {
                // ignore: deprecated_member_use
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          )),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildColumnWithData(Weather weather) {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${weather.temperatureCelcius.toString()} C",
          style: const TextStyle(
            fontSize: 75,
            fontWeight: FontWeight.bold,
          ),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: ((value) => submitCityName(context, value)),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "enter a city",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    final weatherBloc = context.read<WeatherBloc>();
    weatherBloc.add(GetWeather(cityName));
    // WeatherCubit.add(GetWeather(cityName));
  }
}
