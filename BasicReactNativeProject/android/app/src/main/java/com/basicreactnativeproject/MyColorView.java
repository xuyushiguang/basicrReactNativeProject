package com.basicreactnativeproject;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.drawable.Drawable;
import android.text.TextPaint;
import android.util.AttributeSet;
import android.view.View;

import org.w3c.dom.Text;

/**
 * TODO: document your custom view class.
 */
public class MyColorView extends View {

    public String text;

    public void setText(String text) {
        this.text = text;
    }

    public MyColorView(Context context) {
        super(context);

    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);


    }


}