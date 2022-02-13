import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
part 'select_mode_viewmodel.g.dart';

class SelectModeViewModel = _SelectModeViewModelBase with _$SelectModeViewModel;

abstract class _SelectModeViewModelBase with Store {
  @observable
  bool isCar = false;

  @action
  void change(bool v) => isCar = v;

  _SelectModeViewModelBase(BuildContext context) {
    getData(context: context);
  }

  @observable
  ObservableSet<Marker> markers = ObservableSet();

  @observable
  Position? currentPosition;

  late GoogleMapController mapController;
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
  Future<void> getData({
    required BuildContext context,
  }) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    if (allData != null) {
      for (int i = 0; i < allData.length; i++) {
        var item = allData[i];
        print(allData[i]['latitude'].toString());
        markers.add(Marker(
          onTap: () {},
          markerId: MarkerId(allData[i]['pinId'].toString()),
          position: LatLng(double.parse(allData[i]['latitude'].toString()),
              double.parse(allData[i]['longitude'].toString())),
          infoWindow: InfoWindow(title: allData[i]['description'].toString()),
          icon: BitmapDescriptor.defaultMarker,
        ));
        //print(getDistance(double.parse(allData[i]["latitude"].toString()), double.parse(allData[i]["longitude"].toString()), currentPosition.latitude, currentPosition.longitude));
      }
    }
  }

  @action
  onCameraMove(CameraPosition cameraPosition) {
    lastMapPosition = cameraPosition.target;
  }
}
