import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:weather/weather.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {

WeatherFactory weatherFactory = new WeatherFactory("fd77a48f72d62a777bd72c361e5625e6"); 

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
}

getCurrentWeather() async {

  double lat = 0;
  double long = 0;

  _determinePosition().then((Position position) async { 
    lat = position.latitude;
    long = position.longitude;
  }
  );

  Weather w = await weatherFactory.currentWeatherByLocation(lat, long);
  return w.weatherDescription;

}
  
}