package com.planet.flutter_plugin2;

import android.content.Context;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;

import com.live2d.live2dsimple.LAppDefine;
import com.live2d.live2dsimple.LAppLive2DManager;
import com.live2d.live2dsimple.LAppModel;
import com.live2d.live2dsimple.LAppView;
import com.live2d.live2dsimple.LSImpleModel;
import com.live2d.live2dsimple.facedetector.facedetector.FaceDetectorProcessor;

import java.util.ArrayList;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;
import jp.live2d.utils.android.SoundManager;

public class Live2dView implements PlatformView, MethodChannel.MethodCallHandler {
    private final LAppLive2DManager live2DMgr;
    private TextView textView;
    private final MethodChannel methodChannel;
    private LinearLayout linearLayout;
    private Context context;
    final String MODEL_PATH = "live2d/haru/haru.moc";
    final String[] TEXTURE_PATHS = {
            "live2d/haru/haru.1024/texture_00.png",
            "live2d/haru/haru.1024/texture_01.png",
            "live2d/haru/haru.1024/texture_02.png"
    };
    ArrayList<LAppModel> models=new ArrayList<>();
    private static final String FACE_DETECTION = "Face Detection";
    private String selectedModel = FACE_DETECTION;
    private static final String TAG = "Live2dByFaceActivity";
    public Live2dView(final Context context,
                      BinaryMessenger messenger,
                      int id,
                      Map<String, Object> params,
                      View containerView) {
        SoundManager.init();
        this.context=context;
        textView = new TextView(context);
        linearLayout=new LinearLayout(context);
         live2DMgr = new LAppLive2DManager(context);
        initModel();
        LAppView view = live2DMgr.createView(context);
        textView = new TextView(context);
        linearLayout.addView(view, 0, new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT));
        methodChannel = new MethodChannel(messenger, "plugins.felix.angelov/textview_" + id);
        methodChannel.setMethodCallHandler(this);
    }

    private void initModel() {
        ArrayList<LSImpleModel> list=new ArrayList<>();
        LSImpleModel haru_a=new LSImpleModel();
        haru_a.setModelName(LAppDefine.MODEL_HARU_A);
        haru_a.setCenter_x(-0.5f);
        haru_a.setY(-0.1f);
        LSImpleModel haru_b=new LSImpleModel();
        haru_b.setModelName(LAppDefine.MODEL_HARU_B);
        haru_b.setCenter_x(0.5f);
        haru_b.setY(2.0f);
        list.add(haru_a);
        list.add(haru_b);
        live2DMgr.setModelNameList(list);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "setText":
                setText(call, result);
                break;
            case "shakeEvent":
                //live2DMgr.setDrag(1.0f,1.0f);
                //live2DMgr.getModel(0).setRandomExpression();
                //成功的回掉
                //result.success(null);
                if (live2DMgr.getModels().isEmpty()){
                    return;
                }
                live2DMgr.getModel(0).setRandomExpression();
                break;
            default:
                result.notImplemented();
        }
    }

    @Override
    public View getView() {

        return linearLayout;
    }

    @Override
    public void dispose() {

    }
    private void setText(MethodCall methodCall, MethodChannel.Result result) {
        String text = (String) methodCall.arguments;
        textView.setText(text);
        result.success(null);
    }
}
