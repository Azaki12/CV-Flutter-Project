import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tests2/widgets/custom_drawer_tile.dart';

class DrawerView extends GetView {
  const DrawerView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(height: kToolbarHeight),
        CustomDrawerTile(
          title: 'None',
          function: 'None',
        ),
        CustomDrawerTile(
          title: 'blur',
          function: 'blur',
        ),
        CustomDrawerTile(
          title: 'GaussianBlur',
          function: 'GaussianBlur',
        ),
        CustomDrawerTile(
          title: 'medianBlur',
          function: 'medianBlur',
        ),
        CustomDrawerTile(
          title: 'boxFilter',
          function: 'boxFilter',
        ),
        CustomDrawerTile(
          title: 'sqrBoxFilter',
          function: 'sqrBoxFilter',
        ),
        CustomDrawerTile(
          title: 'filter2D',
          function: 'filter2D',
        ),
        CustomDrawerTile(
          title: 'threshold',
          function: 'threshold',
        ),
        CustomDrawerTile(
          title: 'sobel',
          function: 'sobel',
        ),
        CustomDrawerTile(
          title: 'laplacian',
          function: 'laplacian',
        ),
        CustomDrawerTile(
          title: 'resize',
          function: 'resize',
        ),
        CustomDrawerTile(
          title: 'applyColorMap',
          function: 'applyColorMap',
        ),
        CustomDrawerTile(
          title: 'Object detection',
          function: 'Object detection',
        ),
        CustomDrawerTile(
          title: 'Face detection',
          function: 'Face detection',
        ),
      ],
    );
  }
}
