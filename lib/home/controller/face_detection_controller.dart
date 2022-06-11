import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_face_detection/learning_face_detection.dart';
import 'package:learning_input_image/learning_input_image.dart';

class FaceDetectionController extends GetxController {
  InputImage _image;
  List<Face> _data = [];
  bool _isProcessing = false;

  InputImage get image => _image;

  List<Face> get data => _data;

  String get type => _image?.type;

  InputImageRotation get rotation => _image?.metadata?.rotation;

  Size get size => _image?.metadata?.size;

  bool get isNotProcessing => !_isProcessing;

  bool get isEmpty => data.isEmpty;

  bool get isFromLive => type == 'bytes';

  bool get notFromLive => !isFromLive;

  final FaceDetector detector = FaceDetector(
    mode: FaceDetectorMode.fast,
    detectLandmark: true,
    detectContour: true,
    enableClassification: true,
    enableTracking: true,
  );

  @override
  void onClose() {
    detector.dispose();
  }

  Future<void> detectFaces(InputImage image) async {
    if (isNotProcessing) {
      startProcessing();
      this.image = image;
      data = await detector.detect(image);
      stopProcessing();
    }
  }

  void startProcessing() {
    _isProcessing = true;
    update();
  }

  void stopProcessing() {
    _isProcessing = false;
    update();
  }

  set image(InputImage image) {
    _image = image;
    if (notFromLive) {
      _data = [];
    }
    update();
  }

  set data(List<Face> data) {
    _data = data;
    update();
  }
}
