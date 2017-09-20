package com.jnidemo;

/**
 * Created by 徐敏 on 2017/9/18.
 */

public class JNITest {
    static {
        System.loadLibrary("hello");
    }

    //在Native层返回一个Student对象
    public native Student nativeGetStudentInfo();

    //给Nativie层调用的一个函数
    public String getStringFromJava(){
        return "getStringFromJava";
    }
}
