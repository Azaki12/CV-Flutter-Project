import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tests2/home/controller/home_controller.dart';

import '../routes/app_pages.dart';

class CustomDrawerTile extends StatelessWidget {
  final String title;
  final String icon;
  final String function;

  const CustomDrawerTile({Key key, this.icon, this.function, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Get.theme.shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: GetBuilder<HomeController>(
        autoRemove: false,
        builder: (controller) {
          return ListTile(
            title: Text(title),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () async {
              Get.back();
              if (function == 'Object detection') {
                controller.predictImage(File(controller.imageX.path));
              } else if (function == 'Face detection') {
                Get.toNamed(Routes.face);
              } else {
                await controller.runAFunction(function);
              }
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Get.theme.colorScheme.secondary,
            ),
          );
        },
      ),
    );
  }
}
