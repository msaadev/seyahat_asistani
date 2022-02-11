import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SplashView extends StatelessWidget {
  const SplashView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(45, 45))),
    );
  }
}