import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_bloc/data/weather_repository.dart';

import '../../data/model/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBloc(this._weatherRepository) : super(const WeatherInitial()) {
    @override
    Stream<WeatherState> mapEventToState(
      WeatherEvent event,
    ) async* {
      if (event is GetWeather) {
        try {
          yield const WeatherLoading();
          final weather = await _weatherRepository.fetchWeather(event.cityName);
          yield WeatherLoaded(weather);
        } on NetworkException {
          yield const WeatherError(
              "Couldn't fetch weather. check network connection");
        }
      }
    }
    // on<WeatherEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }
}
