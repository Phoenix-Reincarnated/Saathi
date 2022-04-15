import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';


class OCRPage extends StatefulWidget {
  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {

  int OCR_CAM = FlutterMobileVision.CAMERA_BACK;
  bool _autoFocusOcr = true;
  bool _showTextOcr = true;
  bool _torchOcr = false;
  String word = "TEXT";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Saathi'),
            centerTitle: true,
          ),
          body: GestureDetector(
            onTap: (){
              return;
            },
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: TextButton(
                     onPressed: _read,
                     child: const Text('Start Scanning',
                       style: TextStyle(fontSize: 16),
                     ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
      words.add( OcrText('Unable to recognize the word'));
    }
  }
}