import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opencv/core/core.dart';
import 'package:opencv/opencv.dart';
import 'package:tflite/tflite.dart';

class HomeController extends GetxController {
  dynamic res;
  Image image = Image.asset('assets/temp.png');
  Image imageNew = Image.asset('assets/temp.png');
  Image imageNew2 = Image.asset('assets/temp.png');
  File file;
  bool preloaded = false;
  bool loaded = false;
  XFile imageX;
  File _image;
  List _recognitions;
  double _imageHeight;
  double _imageWidth;
  bool _busy = false;
  bool object = false;
  bool filter = false;

  @override
  void onInit() {
    super.onInit();
    initPlatformState();
    _busy = true;

    loadModel().then((val) {
      _busy = false;
      update();
    });
  }

  Future loadImage() async {
    final ImagePicker _picker = ImagePicker();
    imageX = await _picker.pickImage(source: ImageSource.gallery);
    image = Image.file(File(imageX.path));
    preloaded = true;
    update();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    String platformVersion;
    try {
      platformVersion = await OpenCV.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> runAFunction(String functionName) async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    stackChildren = [];
    object = false;
    filter = true;
    try {
      Get.snackbar('Processing', 'wait for the output',
          backgroundColor: Colors.yellow);
      switch (functionName) {
        case 'blur':
          res = await ImgProc.blur(await imageX.readAsBytes(), [45, 45],
              [20, 30], Core.borderReflect);
          break;
        case 'GaussianBlur':
          res = await ImgProc.gaussianBlur(
              await imageX.readAsBytes(), [45, 45], 0);
          break;
        case 'medianBlur':
          res = await ImgProc.medianBlur(await imageX.readAsBytes(), 3);
          break;
        case 'boxFilter':
          res = await ImgProc.boxFilter(await imageX.readAsBytes(), 50, [3, 3],
              [-1, -1], true, Core.borderConstant);
          break;
        case 'sqrBoxFilter':
          res = await ImgProc.sqrBoxFilter(
              await imageX.readAsBytes(), -1, [3, 3]);
          break;
        case 'filter2D':
          res = await ImgProc.filter2D(await imageX.readAsBytes(), -1, [3, 3]);
          break;
        case 'threshold':
          res = await ImgProc.threshold(
              await imageX.readAsBytes(), 80, 255, ImgProc.threshBinary);
          break;
        case 'sobel':
          res = await ImgProc.sobel(await imageX.readAsBytes(), -1, 2, 2);
          break;
        case 'laplacian':
          res = await ImgProc.laplacian(await imageX.readAsBytes(), 10);
          break;
        case 'resize':
          res = await ImgProc.resize(
              await imageX.readAsBytes(), [500, 500], 0, 0, ImgProc.interArea);
          break;
        case 'applyColorMap':
          res = await ImgProc.applyColorMap(
              await imageX.readAsBytes(), ImgProc.colorMapHot);
          break;
        default:
          print("No function selected");
          break;
      }

      imageNew = Image.memory(res);
      loaded = true;
      Get.snackbar('Success', 'The Filtered image will load now',
          backgroundColor: Colors.green);
      update();
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
  }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageHeight == null || _imageWidth == null) return [];

    double factorX = screen.width / 2;
    double factorY = (_imageHeight / _imageWidth * screen.width) / 2;
    Color blue = const Color.fromRGBO(37, 213, 253, 1.0);
    return _recognitions.map((re) {
      return Center(
        child: Container(
          // left: re["rect"]["x"] * factorX,
          // top: re["rect"]["y"] * factorY,
          width: re["rect"]["w"] * factorX,
          height: re["rect"]["h"] * factorY,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(
                color: blue,
                width: 2,
              ),
            ),
            child: Text(
              "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
              style: TextStyle(
                background: Paint()..color = blue,
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> renderKeypoints(Size screen) {
    if (_recognitions == null) return [];
    if (_imageHeight == null || _imageWidth == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight / _imageWidth * screen.width;

    var lists = <Widget>[];
    for (var re in _recognitions) {
      var color = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0);
      var list = re["keypoints"].values.map<Widget>((k) {
        return Positioned(
          left: k["x"] * factorX - 6,
          top: k["y"] * factorY - 6,
          width: 100,
          height: 12,
          child: Text(
            "● ${k["part"]}",
            style: TextStyle(
              color: color,
              fontSize: 17.0,
            ),
          ),
        );
      }).toList();

      lists.addAll(list);
    }

    return lists;
  }

  List<Widget> stackChildren = [];

  Future predictImage(File image) async {
    stackChildren = [];
    _busy = true;
    object = true;
    filter = false;
    Get.snackbar('Processing', 'wait for the output',
        backgroundColor: Colors.yellow);

    if (image == null) return;

    await yolov2Tiny(image);

    FileImage(image)
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      _imageHeight = info.image.height.toDouble();
      _imageWidth = info.image.width.toDouble();
      update();
    }));

    Get.snackbar('Success', 'Loaded Image will appear now',
        backgroundColor: Colors.green);
    imageNew = Image.file(image);
    _busy = false;
    loaded = true;
    stackChildren.add(Center(
      child: Container(
        width: Get.width / 2,
        height: Get.height / 2,
        child: Image.file(
          image,
          width: Get.width / 2,
          height: Get.height / 2,
        ),
      ),
    ));
    stackChildren.addAll(renderBoxes(Get.size));

    update();
  }

  Future yolov2Tiny(File image) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.detectObjectOnImage(
      path: image.path,
      model: "assets/yolov4-tiny-416.tflite",
      threshold: 0.3,
      imageMean: 0.0,
      imageStd: 255.0,
      numResultsPerClass: 1,
    );

    _recognitions = recognitions;
    update();
    int endTime = DateTime.now().millisecondsSinceEpoch;
    if (kDebugMode) {
      print("Inference took ${endTime - startTime}ms");
    }
  }

  Future loadModel() async {
    Tflite.close();
    try {
      String res;
      res = await Tflite.loadModel(
        model: "assets/yolov2_tiny.tflite",
        labels: "assets/yolov2_tiny.txt",
        // useGpuDelegate: true,
      );
    } on PlatformException {
      if (kDebugMode) {
        print('Failed to load model.');
      }
    }
  }
}
