# jnidemo
一个完整的ndk demo
一，android中libs目录下armeabi和armeabi-v7a的区别

armeabi默认选项，

支持基于ARM* v5TE 的设备

支持软浮点运算（不支持硬件辅助的浮点计算）

支持所有ARM* 设备

armeabi-v7a

支持基于 ARM* v7 的设备

支持硬件 FPU 指令

支持硬件浮点运算

不同手机由于cpu的不同，使用不同的驱动。

ABI:指应用基于哪种指令集来进行编译，ABI总共有四种，分别是armeabi、armeabi-v7a、mips、x86，它们都是表示cpu的类型。

二，so动态库的编译方式

1，MK文件

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

APP_PLATFORM := android-19

APP_STL      := gnustl_shared

#so动态库名称

LOCAL_MODULE    := hello

LOCAL_LDLIBS += -llog

LOCAL_ALLOW_UNDEFINED_SYMBOLS := true

#include path 如果文件比较多就可以通过添加路径的方式

#LOCAL_CFLAGS := -I$(LOCAL_PATH)/third-party

LOCAL_SRC_FILES :=  hello.cpp

LOCAL_SRC_FILES +=  .cpp

#添加本地库

#LOCAL_LDLIBS += -llog -pthread -L$(LOCAL_PATH)/third-party -event

include $(BUILD_SHARED_LIBRARY)  #如果编译静态库，需要Application.mk

2，如何使用

1，创建一个Java类JNITest

packagecom.jnidemo;

/**

* Created by 徐敏 on 2017/9/18.

*/

public class JNITest {

static{

System.loadLibrary("hello");

}

//在Native层返回一个Student对象

public nativeStudentnativeGetStudentInfo();

//给Nativie层调用的一个函数

publicStringgetStringFromJava(){

return"getStringFromJava";

}

}

2，打开android studio Terminal控制台，cd到工程java目录，执行jni命令：

javah  -jni com.jnidemo.JNITest

5，生成的头文件copy到Jni目录中

6，创建一个com_jnidemo_JNITest.cpp文件：

#include

#include

#include

extern"C"

JNIEXPORTjobjectJNICALLJava_com_jnidemo_JNITest_nativeGetStudentInfo(JNIEnv* env,jobjectobl){

//关于包描述符，这儿可以是 com/jnidemo/Student 或者是 Lcom/feixun/jni/Student;

//  这两种类型 都可以获得class引用

jclassstucls = env->FindClass("com/jnidemo/Student");//或得Student类引用

jclassjnicls = env->GetObjectClass(obl);//或得Student类引用

jmethodIDgetStringMid=env->GetMethodID(jnicls,"getStringFromJava","()Ljava/lang/String;");

jstringresult=(jstring)env->CallObjectMethod(obl,getStringMid);

//获得得该类型的构造函数  函数名为 返回类型必须为 void 即 V

jmethodIDconstrocMID = env->GetMethodID(stucls,"","(ILjava/lang/String;)V");

jstringstr = env->NewStringUTF(" come from Native ");

jobjectstu_ojb = env->NewObject(stucls,constrocMID,11,result);//构造一个对象，调用该类的构造函数，并且传递参数

returnstu_ojb;

}

8，MK文件中添加这个cpp文件：

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

APP_PLATFORM := android-19

APP_STL      := gnustl_shared

LOCAL_MODULE    := hello

LOCAL_LDLIBS += -llog

LOCAL_ALLOW_UNDEFINED_SYMBOLS := true

LOCAL_SRC_FILES :=  com_jnidemo_JNITest.cpp

include $(BUILD_SHARED_LIBRARY)  #如果编译静态库，需要Application.mk



9，编译  ：nkd-build
