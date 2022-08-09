import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/data/weather_repository.dart';
import 'package:weather_app_bloc/pages/weather_search_page.dart';
import 'package:weather_app_bloc/states/bloc/weather_bloc.dart';

// import 'states/cubit/weather_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) => WeatherBloc(FakeWeatherRepository()),
          child: const WeatherSearchPage()),
    );
  }
}
