import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:seyahat_asistani/core/models/travel_model.dart';

import '../../../core/constants/app_constants.dart';
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
            bearing: 30
          ),
        ),
      );
    }).catchError((e) {
      print("error");
      print(e);
    });
  }


    Container statisticCard(BuildContext context, TravelModel travelModel) {
    String? cacheText;

    cacheText = travelModel.weather!.weatherDescription;

    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        color: Colors.blueGrey[400],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topCenter,
                child: Text("Hava Durumu",
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.bold))),
          ),
          Text(
            cacheText!,
            style: GoogleFonts.montserrat(
                fontSize: 30, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  
}