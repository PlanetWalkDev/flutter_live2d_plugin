package com.planet.flutter_plugin2;

import android.content.Context;
import android.view.View;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class CustomTextViewFactory extends PlatformViewFactory {
    private final BinaryMessenger messenger;
    private final View containerView;


    /**
     * @param createArgsCodec the codec used to decode the args parameter of {@link #create}.
     * @param
     */
    public CustomTextViewFactory(BinaryMessenger messenger, MessageCodec<Object> createArgsCodec, View containerView) {
        super(createArgsCodec);
        this.messenger = messenger;
        this.containerView = containerView;

    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        Map<String,Object> param = (Map<String,Object>)args;
//        String text = (String)param.get("text");
        return new Live2dView(context,messenger,viewId,param,containerView);
    }
}
