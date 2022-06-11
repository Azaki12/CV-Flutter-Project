import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'decoration_circles.dart';

class GlobalBG extends StatelessWidget {
  final Widget body;
  const GlobalBG({Key key, @required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: -Get.width * 0.2,
          child: DecorationCircles(
            width: Get.width * 0.6,
            height: Get.width * 0.6,
          ),
        ),
        Positioned(
          top: -Get.height * 0.06,
          right: -Get.width * 0.1,
          child: DecorationCircles(
            width: Get.width * 0.4,
            height: Get.width * 0.4,
          ),
        ),
        Positioned(
          top: Get.height * 0.5,
          left: -Get.width * 0.2,
          child: DecorationCircles(
            width: Get.width * 0.4,
            height: Get.width * 0.4,
          ),
        ),
        Positioned(
          bottom: 10,
          right: -Get.width * 0.35,
          child: DecorationCircles(
            width: Get.width * 0.6,
            height: Get.width * 0.6,
          ),
        ),
        Material(
          color: Colors.transparent,
          child: SafeArea(child: body),
        ),
      ],
    );
  }
}
