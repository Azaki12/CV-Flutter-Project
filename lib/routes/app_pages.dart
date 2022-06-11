import 'package:get/get.dart' show GetPage;
import 'package:tests2/detection.dart';
import 'package:tests2/home/bindings/face_detection_binding.dart';

import '../home/bindings/home_binding.dart';
import '../home/view/home_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.face,
      page: () => const FaceDetectionPage(),
      binding: FaceDetectionBinding(),
    ),
  ];
}
