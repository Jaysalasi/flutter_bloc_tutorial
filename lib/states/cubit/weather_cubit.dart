import 'package:bloc/bloc.dart';
import 'package:weather_app_bloc/data/weather_repository.dart';
import 'package:weather_app_bloc/states/cubit/weather_state.dart';
import 'package:meta/meta.dart';

// part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherCubit(this._weatherRepository) : super(const WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      emit(WeatherError("Couldn't fetch weather. check network connection"));
    }
  }
}
