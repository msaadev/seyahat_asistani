import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:seyahat_asistani/view/drowsiness_detection/view/camera_view.dart';

class FaceDetectorView extends StatefulWidget {
  const FaceDetectorView({Key? key}) : super(key: key);

  @override
  _FaceDetectorViewState createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  FaceDetector faceDetector =
      GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
  ));
  bool isBusy = false;
  //CustomPaint customPaint;
  double? leftEyeOpenProb;
  double? rightEyeOpenProb;

  @override
  void dispose() {
    //faceDetector.close();
    super.dispose();
  }

  Future<void> processImage(inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final faces = await faceDetector.processImage(inputImage);
    if (faces.length > 0 &&
        faces[0].leftEyeOpenProbability != null &&
        faces[0].rightEyeOpenProbability != null) {
      if (mounted) {
        setState(() {
          leftEyeOpenProb = faces[0].leftEyeOpenProbability;
          rightEyeOpenProb = faces[0].rightEyeOpenProbability;
          isBusy = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
        title: "Face Detector",
        //customPaint: customPaint,
        onImage: (inputImage) {
          processImage(inputImage);
        },
        initialDirection: CameraLensDirection.front,
        leftEye: leftEyeOpenProb,
        rightEye: rightEyeOpenProb);
  }
}
