import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension CustomBoxDecoration on Widget {
  Widget decorate(
      {Color color,
      double radius,
      double width,
      double height,
      double padding}) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      padding:
          padding == null ? const EdgeInsets.all(0) : EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color ?? Get.theme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 12)),
        boxShadow: [
          BoxShadow(
            color: Get.theme.shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: this,
    );
  }
}
