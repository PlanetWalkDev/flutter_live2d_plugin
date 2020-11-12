import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_plugin2/flutter_plugin2.dart';
import 'package:flutter_plugin2/live2d_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  Map<String,dynamic> _l2dChannelMap = <String,dynamic>{};
  static const platform = const MethodChannel('plugins.felix.angelov/textview');

  bool isSpeak = false;
  int index = 0;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterPlugin2.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          child: FlutterLive2dView(
            onLive2dViewCreated: (Live2dViewController controller){
              _l2dChannelMap['123224'] = controller;
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Live2dViewController controller = _l2dChannelMap['123224'];
//            controller.live2dStartMotion('tap_body', "1", "2");
//          controller.shakeEvent();
//            isSpeak = !isSpeak;
//          controller.live2dSpeakMotion(isSpeak);
            index = index + 1;
          controller.live2dSetModelJsonPath(["ShizukuFullPack/shizuku.model.json","WankoFullPack/wanko.model.json","HaruFullPack/haru_02.model.json"][index%3]);
          },
        ),
      ),
    );
  }

  void shakeEvent() {
    platform.invokeMethod("shakeEvent");
  }
}
