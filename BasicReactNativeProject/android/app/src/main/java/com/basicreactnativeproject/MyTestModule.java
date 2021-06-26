package com.basicreactnativeproject;

import androidx.annotation.NonNull;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import javax.annotation.Nonnull;

public class MyTestModule extends ReactContextBaseJavaModule {

    public MyTestModule(@Nonnull ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @NonNull
    @Override
    public String getName() {
        return "MyTestModule";
    }

    @ReactMethod
    public void addTest(String name, Callback didBack){
        didBack.invoke("name="+name);
    }

    @ReactMethod
    public  void testPromise(String name, Promise promise){
        if (name.isEmpty()){
            promise.reject("error","name.isEmpty");
        }else {
            promise.resolve(name+"a1111");
        }
    }

}
