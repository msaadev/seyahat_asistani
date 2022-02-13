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

 /*   void checkDistancesPeriodically() async {
    getCurrentLocation();
    //print(allData);
    if (currentPosition != null) {
      for (int i = 0; i < allData.length; i++) {
        print(getDistance(
            double.parse(allData[i]["latitude"].toString()),
            double.parse(allData[i]["longitude"].toString()),
            currentPosition!.latitude,
            currentPosition!.longitude));

        if (getDistance(
                double.parse(allData[i]["latitude"].toString()),
                double.parse(allData[i]["longitude"].toString()),
                currentPosition!.latitude,
                currentPosition!.longitude) <
            0.01) {
          print("markerss : ");
          print(allData[i]);
          await _speak(allData[i]['description']);
          if (await Vibration.hasCustomVibrationsSupport()) {
            await Vibration.vibrate(duration: 1000);
          } else {
            await Vibration.vibrate();
            await Future.delayed(Duration(milliseconds: 500));
            await Vibration.vibrate();
            
          }
          //closeMarkers.add(markers.)
        }
      }
    }
  } */

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

    double getDistance(double latitude, double longitude, double latitudeUser,
      double longitudeUser) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((latitudeUser - latitude) * p) / 2 +
        c(latitude * p) *
            c(latitudeUser * p) *
            (1 - c((longitudeUser - longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

  /* Future _speak(String text) async {
    if (text != null) {
      if (text.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(text);
      }
    }
  } */

 /*   Future<void> getData({
    required BuildContext context,
  }) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    if (allData != null) {
      for (int i = 0; i < allData.length; i++) {
        var item = allData[i];

        markers.add(Marker(
          onTap: () {
            AppConstants().showModal(
                context: context,
                child: ModalContent(
                  item: item,
                  onTap: (pinId) async {
                    await deletePost(pinId).then((value) =>
                        AppConstants.showSuccesToast('Başarılı',
                            subTitle: 'Pin kaldırma talebiniz alınmıştır'));
                  },
                ));
          },
          markerId: MarkerId(allData[i]['pinId'].toString()),
          position: LatLng(double.parse(allData[i]['latitude'].toString()),
              double.parse(allData[i]['longitude'].toString())),
          infoWindow: InfoWindow(title: allData[i]['description'].toString()),
          icon: BitmapDescriptor.defaultMarker,
        ));

        //print(getDistance(double.parse(allData[i]["latitude"].toString()), double.parse(allData[i]["longitude"].toString()), currentPosition.latitude, currentPosition.longitude));
      }
    }
  } */

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