import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OCRPage extends StatefulWidget {
  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  @override
  void initState() {
    super.initState();
    _read();
  }

  int OCR_CAM = FlutterMobileVision.CAMERA_BACK;
  final bool _autoFocusOcr = true;
  final bool _showTextOcr = true;
  final bool _torchOcr = false;
  String word = "TEXT";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Align(
            child: LayoutBuilder(
              builder: (context, _) {
                return SpinKitDoubleBounce(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.red : Colors.green,
                      ),
                    );
                  },
                );
              },
            ),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }

  Future<Null> _read() async {
    List<OcrText> words = [];
    try {
      words = await FlutterMobileVision.read(
        camera: OCR_CAM,
        autoFocus: _autoFocusOcr,
        showText: _showTextOcr,
        flash: _torchOcr,
      );

      setState(() {
        word = words[0].value;
      });
      print(word);
    } on Exception {
      words.add(OcrText('Unable to recognize the word'));
    }
  }
}
