import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tests2/home/controller/home_controller.dart';
import 'package:tests2/home/view/drawer_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerView(),
      body: SafeArea(
        child: Center(
          child: GetBuilder<HomeController>(
            builder: (controller) => ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                controller.imageX == null
                    ? const Icon(
                        Icons.image,
                        size: 100,
                      )
                    : Container(),
                controller.imageX == null
                    ? const Center(child: Text('Pick an Image'))
                    : Container(),
                controller.preloaded
                    ? SizedBox(
                        width: Get.width / 2,
                        height: Get.height / 2,
                        child: Image.file(
                          File(
                            controller.imageX.path,
                          ),
                        ),
                      )
                    : const Center(
                        child: Text(
                            "There might be an error in loading your asset."),
                      ),
                controller.loaded && controller.filter
                    ? SizedBox(
                        width: Get.width / 2,
                        height: Get.height / 2,
                        child: controller.imageNew,
                      )
                    : Container(),
                if (controller.loaded && controller.object)
                  SizedBox(
                    width: Get.width / 2,
                    height: Get.height / 2,
                    child: Stack(
                      children: controller.stackChildren,
                    ),
                  )
                else
                  Container(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.loadImage();
        },
        child: const Icon(Icons.image),
      ),
    );
  }
}
