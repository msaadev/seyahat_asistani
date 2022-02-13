import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../main.dart';

class CameraView extends StatefulWidget {
  const CameraView(
      {Key? key,
      required this.title,
      //required this.customPaint,
      required this.onImage,
      required this.initialDirection,
      required this.leftEye,
      required this.rightEye})
      : super(key: key);

  final String title;
  //final CustomPaint customPaint;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;
  final double? leftEye;
  final double? rightEye;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  int _cameraIndex = 0;

  getCameras() async {
    for (var i = 0; i < cameras.length; i++) {
      if (cameras[i].lensDirection == widget.initialDirection) {
        _cameraIndex = i;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCameras();

    _startLiveFeed();
  }

  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.low,
      enableAudio: false,
    );
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }

    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];

    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map((Plane plane) {
      return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width);
    }).toList();

    final inputImageData = InputImageData(
        size: imageSize,
        imageRotation: imageRotation,
        inputImageFormat: inputImageFormat,
        planeData: planeData);

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    widget.onImage(inputImage);
  }

  Future _stopLiveFeed() async {
    await _controller.stopImageStream();
    await _controller.dispose();
    //_controller = null;
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  Widget _liveFeedBody() {
    if (_controller.value.isInitialized == false) {
      return Container();
    }
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Stack(
        fit: StackFit.expand,
        children: [CameraPreview(_controller)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(child: _liveFeedBody()),
        ),
      ],
    );
  }
}
