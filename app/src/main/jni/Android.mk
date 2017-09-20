LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

APP_PLATFORM := android-19

APP_STL      := gnustl_shared

LOCAL_MODULE    := hello
LOCAL_LDLIBS += -llog
LOCAL_ALLOW_UNDEFINED_SYMBOLS := true


LOCAL_SRC_FILES :=   com_jnidemo_JNITest.cpp



include $(BUILD_SHARED_LIBRARY)   #如果编译静态库，需要Application.mk
