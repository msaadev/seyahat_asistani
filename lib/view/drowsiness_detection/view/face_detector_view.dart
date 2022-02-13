import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:seyahat_asistani/view/drowsiness_detection/view/camera_view.dart';

import '../view_model/face_detector_model.dart';

class FaceDetectorView extends StatefulWidget {
  const FaceDetectorView({Key? key}) : super(key: key);

  @override
  _FaceDetectorViewState createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  late final FaceDetectorModel viewModel;

  FaceDetector faceDetector =
      GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
  ));
  bool isBusy = false;
  //CustomPaint customPaint;
  double? leftEyeOpenProb;
  double? rightEyeOpenProb;

  List eyeDetectLeft = [];
  List eyeDetectRight = [];

  int leftEyeCount = 0;
  int rightEyeCount = 0;

  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    viewModel = FaceDetectorModel();
    viewModel.getCurrentLocation();
  }

  @override
  void dispose() {
    faceDetector.close();
    super.dispose();
  }

  Future _speak(String text) async {
    if (text != null) {
      if (text.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(text);
      }
    }
  }

  Future<void> processImage(inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final faces = await faceDetector.processImage(inputImage);
    if (faces.length > 0 &&
        faces[0].leftEyeOpenProbability != null &&
        faces[0].rightEyeOpenProbability != null) {
      if (mounted) {
        setState(() async {
          leftEyeOpenProb = faces[0].leftEyeOpenProbability;
          rightEyeOpenProb = faces[0].rightEyeOpenProbability;
          if (eyeDetectLeft.length < 20) {
            eyeDetectLeft.add(leftEyeOpenProb);
            eyeDetectRight.add(rightEyeOpenProb);
          }
          if (eyeDetectLeft.length == 20) {
            for (int i = 0; i < 20; i++) {
              if (eyeDetectLeft[i] < 0.2) {
                leftEyeCount++;
              }
              if (eyeDetectRight[i] < 0.2) {
                rightEyeCount++;
              }
            }
            if (leftEyeCount > 15 && rightEyeCount > 15) {
              await _speak("UYAAAAAAAAAAAAAAAAN UYAN UYAN UYAN");

              eyeDetectLeft.clear();
              eyeDetectRight.clear();
              leftEyeCount = 0;
              rightEyeCount = 0;
            } else {
              eyeDetectLeft.clear();
              eyeDetectRight.clear();
              leftEyeCount = 0;
              rightEyeCount = 0;
            }
          }
          isBusy = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FloatingActionButton(
              onPressed: () {
                viewModel.mapController.animateCamera(
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
              child: Icon(Icons.my_location),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () async {
                viewModel.onAddMarkerButtonPressed();
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
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
                        initialCameraPosition: CameraPosition(
                          target: viewModel.lastMapPosition,
                          zoom: 8.0,
                        ),
                        mapType: viewModel.currentMapType,
                        markers: viewModel.markers,
                        onCameraMove: viewModel.onCameraMove,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        zoomControlsEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          viewModel.mapController = controller;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CameraView(
                  title: "Face Detector",
                  //customPaint: customPaint,
                  onImage: (inputImage) {
                    processImage(inputImage);
                  },
                  initialDirection: CameraLensDirection.front,
                  leftEye: leftEyeOpenProb,
                  rightEye: rightEyeOpenProb),
              Container(
                child: Column(children: [Text("")]),
              )
            ],
          ),
        ],
      ),
    );
  }
}
