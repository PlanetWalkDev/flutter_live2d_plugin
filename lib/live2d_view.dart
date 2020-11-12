import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void Live2dViewCreatedCallback(Live2dViewController controller);

class FlutterLive2dView extends StatefulWidget {
  const FlutterLive2dView({
    Key key,
    this.onLive2dViewCreated,this.live2dType}) : super(key: key);

  final Live2dViewCreatedCallback onLive2dViewCreated;
  final String live2dType;

  @override
  State<StatefulWidget> createState() => _FlutterLive2dViewState();
}
class LiveType{
  static final String face="faceType";
  static final String normal="normal";
}
class _FlutterLive2dViewState extends State<FlutterLive2dView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        // creationParams: widget.live2dType,
        viewType: 'plugins.flutter.io/textView',
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParamsCodec: StandardMessageCodec(),

      );
    } else if(defaultTargetPlatform == TargetPlatform.iOS) {
      // This is used in the platform side to register the view.
      final String viewType = 'platform-live2dView';
      // Pass parameters to the platform side.
      final Map<String, dynamic> creationParams = <String, dynamic>{};
      return UiKitView(
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return Text(
        '$defaultTargetPlatform is not yet supported by the text_view plugin');
  }

  void _onPlatformViewCreated(int id) {
    if (widget.onLive2dViewCreated == null) {
      return;
    }
    widget.onLive2dViewCreated(new Live2dViewController._(id));
  }
}

class Live2dViewController {
  Live2dViewController._(int id)
      : _channel = new MethodChannel('plugins.felix.angelov/textview_$id');

  final MethodChannel _channel;

  Future<void>  setText(String text) async {
    assert(text != null);
    return _channel.invokeMethod('setText', text);
  }
   Future<void> shakeEvent() async {
    return _channel.invokeMethod('shakeEvent');
  }

  ///设置模型json路径
  Future<void> live2dSetModelJsonPath(String modelJsonPath) async {
    final Map<String, String> args = <String, String>{
      "path": modelJsonPath,
    };
    return _channel.invokeMethod('l2d_setModelJsonPath',args);
  }

  ///设置背景路径
  Future<void> live2dSetBackgroundPath(String modelJsonPath) async {
    return _channel.invokeMethod('l2d_setBackgroundPath');
  }
  ///设置模型动作
  Future<void> live2dStartMotion(String name ,String no, String priority)async{
    final Map<String, String> args = <String, String>{
      "name": name,
      "no": no,
      "priority" : priority
    };
    return _channel.invokeMethod('l2d_StartMotion',args);
  }

  ///设置随机动作
  Future<bool> live2dStartRandomMotion(String name, String priority) async {
    final Map<String, String> args = <String, String>{
      "name": name,
      "priority" : priority
    };
    final bool success = await _channel.invokeMethod('l2d_StartRandomMotion',args);
    return success;
  }

  ///设置表情
  Future<bool> live2dStartExpression(String name)async{
    final Map<String, String> args = <String, String>{
      "name": name,
    };
    final bool success = await _channel.invokeMethod('l2d_StartExpression',args);
    return success;
  }

  Future<void> live2dSpeakMotion(bool isSpeaking) async {
    final Map<String, bool> args = <String, bool>{
      "isSpeaking": isSpeaking,
    };
    return _channel.invokeMethod('l2d_SpeakMotion',args);
  }

  ///设置随机表情
  Future<bool> live2dStartRandomExpression(String name)async{
    final bool success = await _channel.invokeMethod('l2d_StartRandomExpression');
    return success;
  }
}

