import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:seyahat_asistani/core/init/cache/cache_manager.dart';
import 'package:seyahat_asistani/view/drowsiness_detection/view/face_detector_view.dart';
import '../view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel();
    print(CacheManager.instance.getUser!.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildWeather(),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FaceDetectorView(),
                  ),
                );
              },
              child: Text("Face Detection"))
        ],
      ),
    );
  }

  Observer buildWeather() {
    return Observer(builder: (_) {
      return Center(
          child: viewModel.isWeatherNotNull
              ? Text(viewModel.weather!.weatherDescription.toString())
              : CircularProgressIndicator());
    });
  }
}
