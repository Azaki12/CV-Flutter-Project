import 'package:flutter/material.dart';

import '../core/utils/constants.dart';

class DecorationCircles extends StatelessWidget {
  final double width, height;
  const DecorationCircles({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Constants.veryLightBlue,
      ),
      child: Container(
        margin: const EdgeInsets.all(35),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }
}
