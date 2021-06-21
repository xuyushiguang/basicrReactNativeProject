package com.basicreactnativeproject;

import android.util.Log;

import androidx.annotation.NonNull;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.ViewManager;
import com.facebook.react.uimanager.annotations.ReactProp;
import  com.basicreactnativeproject.MyColorView;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class MyColorViewManager extends SimpleViewManager<MyColorView>{


    ReactApplicationContext mCallerContext;

    public MyColorViewManager(){
//        mCallerContext = reactContext;
    }


    @NonNull
    @Override
    public String getName() {
        return "MyColorView";
    }

    @NonNull
    @Override
    protected MyColorView createViewInstance(@NonNull ThemedReactContext reactContext) {
        return new MyColorView(reactContext);
    }

    @ReactProp(name = "text")
    public void setText(MyColorView view,String text){
        Log.d("12","======"+text);
        view.setText(text);
    }

}
