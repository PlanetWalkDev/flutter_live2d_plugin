
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPlugin2 {
  static const MethodChannel _channel = const MethodChannel('flutter_plugin2');
  static const _live2dChannel = const MethodChannel('plugins.felix.angelov/textview');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  //测试方法
  static Future<void> test() async {
    await _live2dChannel.invokeMethod('shakeEvent');
  }

}
class Live2dContact{
  static int id_1=1001;
  static int id_2=1002;

}