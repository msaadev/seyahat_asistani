import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lib_msaadev/lib_msaadev.dart';
import 'package:weather/weather.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/init/cache/cache_manager.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../add_pin/view/add_pin_view.dart';
import '../view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel viewModel;

  double carbonFingerprint =
      double.parse(CacheManager.instance.getUser!.totalDrive) * 94;

  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if (viewModel.isPositionNotNull) {
                  NavigationService.instance.navigateToPageWidget(
                      page: AddPinView(
                          myPosition: LatLng(
                              viewModel.currentPosition!.latitude,
                              viewModel.currentPosition!.longitude)));
                }
              },
              child: const Text('Pin Ekle'))
        ],
      ),
      floatingActionButton: _buildFloatingButton(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            10.hSized,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Observer(
                  builder: (_) => statisticCard(context, "Hava Durumu", "Hava"),
                ),
                statisticCard(context, "Yürünen Yol", "Yürüme"),
                statisticCard(context, "Arabayla Gidilen Yol", "Araba"),
              ],
            ),
            Card(
              color: Colors.red.shade300,
              child: SizedBox(
                child: Center(
                  child: Text(
                    "Toplam Karbon Salınımı ${carbonFingerprint.toStringAsFixed(2)} Ton C02",
                    style: GoogleFonts.montserrat(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                height: 100,
              ),
            ),
            10.hSized,
            Expanded(
              child: _buildMap(),
            ),
          ],
        ),
      ),
    );
  }

  Observer _buildFloatingButton() {
    return Observer(builder: (_) {
      return viewModel.isFinishNotNull
          ? FloatingActionButton(
              heroTag: '1',
              onPressed: viewModel.navigateToSelectMode,
              child: const Icon(Icons.arrow_forward_ios_rounded),
            )
          : const SizedBox();
    });
  }

  Observer _buildMap() {
    return Observer(builder: (_) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: AppConstants.ist,
            zoom: 8.0,
          ),
          mapType: viewModel.currentMapType,
          markers: {
            Marker(
                markerId: const MarkerId('finish'),
                position: viewModel.finishMarker ?? const LatLng(0, 0))
          },
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          onTap: (position) {
            viewModel.addMarker(position);
          },
          onMapCreated: (GoogleMapController controller) {
            viewModel.mapController = controller;
          },
        ),
      );
    });
  }

  Observer buildWeather() {
    return Observer(builder: (_) {
      return Center(
          child: viewModel.isWeatherNotNull
              ? Text(viewModel.weather!.weatherDescription.toString())
              : const CircularProgressIndicator());
    });
  }

  Card statisticCard(BuildContext context, String header, String type) {
    String? cacheText;
    String? imageUrl;

    if (type == "Hava") {
      cacheText = viewModel.isWeatherNotNull
          ? viewModel.weather!.weatherDescription
          : "";
      imageUrl =
          viewModel.isWeatherNotNull ? viewModel.weather!.weatherIcon : null;
      debugPrint('denemeee ${imageUrl ?? 'hataaa'}');
    }
    if (type == "Yürüme") {
      cacheText = CacheManager.instance.getUser!.totalWalk + " KM";
    }
    if (type == "Araba") {
      cacheText = CacheManager.instance.getUser!.totalDrive + " KM";
    }

    return Card(
      color: Colors.grey[400],
      child: Container(
        padding: 10.paddingAll,
        width: MediaQuery.of(context).size.width / 3.5,
        height: MediaQuery.of(context).size.height / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(header,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 14, fontWeight: FontWeight.bold)),
            imageUrl != null
                ? Image(
                    image: NetworkImage(
                      'http://openweathermap.org/img/wn/${imageUrl}@2x.png',
                    ),
                    errorBuilder: (c, _, __) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox(),
            Text(
              cacheText!,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
