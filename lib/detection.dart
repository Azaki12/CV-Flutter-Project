import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_face_detection/learning_face_detection.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:tests2/home/controller/face_detection_controller.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class FaceDetectionPage extends GetView<FaceDetectionController> {
  const FaceDetectionPage({Key key}) : super(key: key);

  void loadModelWifi(input) async {
    final interpreter = await Interpreter.fromAsset('bot.tflite');
    var outputs = List.filled(1, 0).reshape([1, 1]);

    // inference
    interpreter.run(input, outputs);

    // print the output
    print(outputs);
  }

  /// old code (working for face detection)
  @override
  Widget build(BuildContext context) {
    return InputCameraView(
      title: 'Face Detection',
      onImage: controller.detectFaces,
      mode: InputCameraMode.gallery,
      canSwitchMode: false,
      resolutionPreset: ResolutionPreset.high,
      overlay: GetBuilder<FaceDetectionController>(
        builder: (controller) {
          Size originalSize = controller.size;
          Size size = Get.size;

          // if image source from gallery
          // image display size is scaled to 360x360 with retaining aspect ratio
          if (controller.notFromLive) {
            if (originalSize.aspectRatio > 1) {
              size = Size(360.0, 360.0 / originalSize.aspectRatio);
            } else {
              size = Size(360.0 * originalSize.aspectRatio, 360.0);
            }
          }

          return FaceOverlay(
            size: size,
            originalSize: originalSize,
            rotation: controller.rotation,
            faces: controller.data,
            boundStrokeColor: Colors.blue,
            boundFill: true,
            boundStroke: true,
            boundStrokeWidth: 3,
            paintLandmark: false,
            contourColor: Colors.green.withOpacity(0.8),
            landmarkColor: Colors.red.withOpacity(0.8),
          );
        },
      ),
    );
  }
}
