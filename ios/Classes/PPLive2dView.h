//
//  PPLive2dView.h
//  flutter_plugin2
//
//  Created by mac on 2020/11/5.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PPLive2dView : UIView
- (BOOL)startRandomMotion:(NSString *)name priority:(int)priority;
- (BOOL)startMotion:(NSString *)name no:(int)no priority:(int)priority;
- (BOOL)startExpression:(NSString *)name;
- (void)shakeEvent;
- (void)speakMotion:(BOOL)isSpeaking;
- (void)setModelJsonPath:(NSString *)modelPath;
//设置模型所在视图Tag
- (void)setModelViewTag:(int)viewTag centerX:(double)center_x y:(double)y;
@end

NS_ASSUME_NONNULL_END
