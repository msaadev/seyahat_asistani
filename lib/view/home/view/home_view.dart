import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lib_msaadev/lib_msaadev.dart';
import 'package:seyahat_asistani/core/constants/app_constants.dart';
import 'package:seyahat_asistani/core/init/cache/cache_manager.dart';
import 'package:seyahat_asistani/core/init/navigation/navigation_service.dart';
import 'package:seyahat_asistani/view/add_pin/view/add_pin_view.dart';
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
              child: Text('Pin Ekle'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        onPressed: () {
          viewModel.mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  viewModel.currentPosition!.latitude,
                  viewModel.currentPosition!.longitude,
                ),
                zoom: 18.0,
              ),
            ),
          );
        },
        child: const Icon(Icons.my_location),
      ),
      body: Column(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Toplam Karbon Salınımı $carbonFingerprint Ton C02",
                      style: GoogleFonts.montserrat(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    )),
              ),
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 12,
              decoration: BoxDecoration(
                color: Colors.red[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          10.hSized,
          Observer(builder: (_) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GoogleMap(
                        initialCameraPosition: const CameraPosition(
                          target: AppConstants.ist,
                          zoom: 8.0,
                        ),
                        mapType: viewModel.currentMapType,
                        markers: {
                          Marker(
                              markerId: const MarkerId('finish'),
                              position:
                                  viewModel.finishMarker ?? const LatLng(0, 0))
                        },
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        zoomControlsEnabled: true,
                        onLongPress: (position) {
                          viewModel.addMarker(position);
                        },
                        onMapCreated: (GoogleMapController controller) {
                          viewModel.mapController = controller;
                        },
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.black,
                      )),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Observer buildWeather() {
    return Observer(builder: (_) {
      return Center(
          child: viewModel.isWeatherNotNull
              ? Text(viewModel.weather!.weatherDescription.toString())
              : const CircularProgressIndicator());
    });
  }

  Container statisticCard(BuildContext context, String header, String type) {
    String? cacheText;

    if (type == "Hava")
      cacheText = viewModel.isWeatherNotNull
          ? viewModel.weather!.weatherDescription
          : "";
    if (type == "Yürüme")
      cacheText = CacheManager.instance.getUser!.totalWalk + " KM";
    if (type == "Araba")
      cacheText = CacheManager.instance.getUser!.totalDrive + " KM";

    return Container(
      width: MediaQuery.of(context).size.width / 3.2,
      height: MediaQuery.of(context).size.height / 5,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topCenter,
                child: Text(header,
                    style: GoogleFonts.montserrat(
                        fontSize: 14, fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cacheText!,
              style: GoogleFonts.montserrat(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
