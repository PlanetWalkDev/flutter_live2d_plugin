#import "FlutterPlugin2Plugin.h"
#import "FLNativeView.h"
#import "PPLive2dView.h"
@implementation FlutterPlugin2Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_plugin2"
            binaryMessenger:[registrar messenger]];
  FlutterPlugin2Plugin* instance = [[FlutterPlugin2Plugin alloc] init];
    FLNativeViewFactory* factory =
        [[FLNativeViewFactory alloc] initWithMessenger:registrar.messenger];
    [registrar registerViewFactory:factory withId:@"platform-live2dView"];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  
}

@end
