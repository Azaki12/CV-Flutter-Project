import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opencv/core/core.dart';
import 'package:opencv/opencv.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic res;
  Image image = Image.asset('assets/temp.png');
  Image imageNew = Image.asset('assets/temp.png');
  File file;
  bool preloaded = false;
  bool loaded = false;
  XFile imageX;
  List<String> urls = [
    "https://i.pinimg.com/564x/54/e2/ae/54e2aeefa75d031813ec56f6b3efc9ad.jpg",
    "https://raw.githubusercontent.com/opencv/opencv/master/samples/data/sudoku.png",
    "https://raw.githubusercontent.com/opencv/opencv/master/samples/data/left.jpg",
    "https://raw.githubusercontent.com/opencv/opencv/master/samples/data/left01.jpg",
    "https://raw.githubusercontent.com/opencv/opencv/master/samples/data/right01.jpg",
    "https://raw.githubusercontent.com/opencv/opencv/master/samples/data/smarties.png",
  ];
  int urlIndex = 0;
  String dropdownValue = 'None';

  @override
  void initState() {
    super.initState();
    loadImage();
    initPlatformState();
  }

  Future loadImage() async {
    final ImagePicker _picker = ImagePicker();
    imageX = await _picker.pickImage(source: ImageSource.gallery);
    // print(imageX.readAsBytes());
    // print('----------------------------');
    file = await DefaultCacheManager().getSingleFile(urls[urlIndex]);
    // print(file.readAsBytes());
    if (urlIndex >= urls.length - 1) {
      urlIndex = 0;
    } else
      urlIndex++;
    setState(() {
      image = Image.file(file);
      preloaded = true;
    });
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

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> runAFunction(String functionName) async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
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

      setState(() {
        imageNew = Image.memory(res);
        loaded = true;
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('CV Project'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              loadImage();
            },
            child: const Icon(Icons.refresh),
          ),
          body: ListView(
            children: <Widget>[
              const Text("Before"),
              preloaded
                  ? Image.file(File(imageX.path))
                  : const Text(
                      "There might be an error in loading your asset."),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      color: Colors.grey,
                      height: 2,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'None',
                      'blur',
                      'GaussianBlur',
                      'medianBlur',
                      'boxFilter',
                      'sqrBoxFilter',
                      'filter2D',
                      'threshold',
                      'sobel',
                      'laplacian',
                      'resize',
                      'applyColorMap',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  RaisedButton(
                    onPressed: () {
                      print(file.path);
                      runAFunction(dropdownValue);
                    },
                    child: const Text('Run'),
                  ),
                ],
              ),
              const Text("After"),
              loaded ? imageNew : Container()
            ],
          )),
    );
  }
}
