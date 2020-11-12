//
//  PPLive2dView.m
//  flutter_plugin2
//
//  Created by mac on 2020/11/5.
//

#import "PPLive2dView.h"
#import "LAppLive2DManager.h"
#import "LAppDefine.h"
#import "LModelConfig.h"
@implementation PPLive2dView
{
    LAppLive2DManager *_live2DMgr;
    int modelViewTag;
}
- (void)drawRect:(CGRect)rect {
    _live2DMgr = new LAppLive2DManager();
    LAppView *lview = _live2DMgr->createView(rect);
    _live2DMgr->addModel([@"HaruFullPack/haru.model.json" UTF8String], [@"123123" UTF8String],NULL);
    _live2DMgr->setModelViewTag(modelViewTag);
    [self addSubview:lview];
}

-(BOOL)startRandomMotion:(NSString *)name priority:(int)priority{
    _live2DMgr->startRandomMotion([name UTF8String], priority);
    return true;
}

-(BOOL)startMotion:(NSString *)name no:(int)no priority:(int)priority{
    _live2DMgr->startMotion([name UTF8String], no, priority);
    return true;
}

-(BOOL)startExpression:(NSString *)name{
    _live2DMgr->setExpression([name UTF8String]);
    return true;
}

-(void)shakeEvent{
    _live2DMgr->shakeEvent();
}

- (void)speakMotion:(BOOL)isSpeaking{
    _live2DMgr->speakMotion(isSpeaking);
}

- (void)setModelJsonPath:(NSString *)modelPath{
//    _live2DMgr->loadModel([modelPath UTF8String]);
    LModelConfig *modelConfig = [[LModelConfig alloc] init];
    modelConfig.center_x = 0;
    modelConfig.y = 0;
    modelConfig.weight = 2;
    _live2DMgr->addModel([modelPath UTF8String], [@"111111" UTF8String],modelConfig);
    _live2DMgr->setModelViewTag(modelViewTag);
}

//设置模型所在视图Tag
- (void)setModelViewTag:(int)viewTag{
    modelViewTag = viewTag;
}
@end
