//
//  FLNativeView.m
//  flutter_plugin2
//
//  Created by mac on 2020/11/5.
//

#import "FLNativeView.h"
#import "PPLive2dView.h"
@implementation FLNativeViewFactory {
  NSObject<FlutterBinaryMessenger>* _messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
  return [[FLNativeView alloc] initWithFrame:frame
                              viewIdentifier:viewId
                                   arguments:args
                             binaryMessenger:_messenger];
}

@end

@implementation FLNativeView {
   PPLive2dView *_view;
}

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  if (self = [super init]) {
    _view = [[PPLive2dView alloc]init];
//    [_view setModelViewTag:viewId];
    FlutterMethodChannel* l2d_batteryChannel = [FlutterMethodChannel
                                                methodChannelWithName:[NSString stringWithFormat:@"plugins.felix.angelov/textview_%lld",viewId]
                                              binaryMessenger:messenger];
    [l2d_batteryChannel setMethodCallHandler:^(FlutterMethodCall* call,FlutterResult result) {
        [self L2D_MethodCallHandler:call result:result];
    }];
  }
  return self;
}

- (UIView*)view {
  return _view;
}

///l2d方法回调
- (void)L2D_MethodCallHandler:(FlutterMethodCall* )call result:(FlutterResult)result{
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
      result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }else if ([@"l2d_StartRandomMotion" isEqualToString:call.method]) {
        //设置随机动作
      [_view startRandomMotion:call.arguments[@"name"] priority:[call.arguments[@"priority"] intValue]];
    }else if ([@"l2d_StartExpression" isEqualToString:call.method]){
        //设置表情
        [_view startExpression:call.arguments[@"name"]];
    }else if ([@"l2d_StartMotion" isEqualToString:call.method]){
        //设置动作
        [_view startMotion:call.arguments[@"name"] no:[call.arguments[@"no"] intValue] priority:[call.arguments[@"priority"] intValue]];
    }else if ([@"shakeEvent" isEqualToString:call.method]){
        [_view shakeEvent];
    }else if ([@"l2d_SpeakMotion" isEqualToString:call.method]){
        [_view speakMotion:[call.arguments[@"isSpeaking"] boolValue]];
    }else if([@"l2d_setModelJsonPath" isEqualToString:call.method]){
        [_view setModelJsonPath:call.arguments[@"path"]];
    }else {
      result(FlutterMethodNotImplemented);
    }
}
@end
