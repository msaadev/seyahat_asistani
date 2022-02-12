import 'package:flutter/material.dart';
import 'package:seyahat_asistani/core/services/database_service.dart';
import '../../../core/init/cache/cache_manager.dart';
import '../view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel viewModel;
  dynamic weatherData;

  getWeather() async {
    var data = await viewModel.getCurrentWeather();

    setState(() {
      weatherData = data;
    });
    
  }

  @override
  void initState() {
    viewModel = HomeViewModel();
    getWeather();
    print("Cache Manager ---------------");
    print(CacheManager.instance.getUser?.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text(weatherData.toString())),
      ),
    );
  }
}
