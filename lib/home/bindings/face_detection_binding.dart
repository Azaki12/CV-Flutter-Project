import 'package:get/get.dart';
import 'package:tests2/home/controller/face_detection_controller.dart';

class FaceDetectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceDetectionController>(
      () => FaceDetectionController(),
    );
  }
}
