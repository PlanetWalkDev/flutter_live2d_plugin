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

#import <AVFoundation/AVFoundation.h>
#import <string>
#import "L2DBaseModel.h"
#import "ModelSetting.h"
#import "LModelConfig.h"
class LAppModel : public live2d::framework::L2DBaseModel {

private:
    
    // モデルの設定
    ModelSetting *modelSetting;
	std::string modelHomeDir;
    
    // 音声用のサウンド
	AVAudioPlayer *voice;
    
    // 是否正在说话
    bool isSpeaking;
    int modelViewTag;
			
public:
    LAppModel();
    ~LAppModel(void);
    //模型所在视图Tag
    void setModelViewTag(int tag);
	// model.jsonの読み込み
    void load(const char path[],LModelConfig *modelConfig);
	// その他の読み込み
	void preloadMotionGroup(const char name[]);
	
	// 更新
    void update();
    void draw();
	
	// モーション
    int startMotion(const char name[], int no, int priority);
	int startRandomMotion(const char name[], int priority);
    //说话动作
    void speakMotion(bool isSpeaking);
	// 表情
	void setExpression(const char name[]);
	void setRandomExpression();
	
    // 当たり判定
	bool hitTest(const char pid[], float testX, float testY);
	 
	// 音声
	void startVoice(const char fileName[]);
	
	// 表示
	void feedIn();
	
private:
	// デバッグ用当たり判定の表示
	void drawHitRect();
};
