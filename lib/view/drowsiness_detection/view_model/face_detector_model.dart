import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lib_msaadev/lib_msaadev.dart';
import 'package:mobx/mobx.dart';

import '../../../core/models/travel_model.dart';

part 'face_detector_model.g.dart';

class FaceDetectorModel = _FaceDetectorModelBase with _$FaceDetectorModel;

abstract class _FaceDetectorModelBase with Store {
  @observable
  Position? currentPosition;

  late GoogleMapController mapController;
  @observable
  Set<Marker> markers = {};
  @observable
  Set<Marker> closeMarkers = {};
  @observable
  LatLng lastMapPosition = LatLng(37.3741, -122.0771);
  @observable
  MapType currentMapType = MapType.normal;

  @observable
  var allData;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('pins');

  @action
  onCameraMove(CameraPosition cameraPosition) {
    lastMapPosition = cameraPosition.target;
  }

  @action
  onAddMarkerButtonPressed() {
    markers.clear();
    markers.add(Marker(
      markerId: MarkerId(lastMapPosition.toString()),
      position: lastMapPosition,
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  @action
  getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentPosition = position;
      print(currentPosition);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
              tilt: 80,
              bearing: 30),
        ),
      );
    }).catchError((e) {
      print("error");
      print(e);
    });
  }

  ClipRRect statisticCard(BuildContext context, TravelModel travelModel) {
    String? cacheText;

    cacheText = travelModel.weather!.weatherDescription;
    String? imageUrl =
          travelModel.weather != null ? travelModel.weather!.weatherIcon : null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: Theme.of(context).primaryColor,
        child: Container(
          padding: 10.paddingAll,
          width: MediaQuery.of(context).size.width / 2.2,
          height: MediaQuery.of(context).size.height / 3.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Hava Durumu",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              imageUrl != null
                  ? Image(
                      height: MediaQuery.of(context).size.height / 6,
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
                    fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
