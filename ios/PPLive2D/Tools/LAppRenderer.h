/*
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 *
 *  Modify By DaidoujiChen https://github.com/DaidoujiChen
 *
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LAppModel.h"
class LAppLive2DManager;

@interface LAppRenderer : NSObject
@property (nonatomic) LAppModel *appModel;
- (id)init;
- (void)render;
- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer;

// Live2DManagerの参照を設定する
//设定Live2DManager的参照
- (void)setDelegate:(LAppLive2DManager *)delegate;

// 別スレッドでテクスチャをロードするような場合に使用する
//在不同线程加载纹理的情况下使用
- (void)setContextCurrent;

@end




