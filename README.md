# 一登SDK - 一切只为简单登录

[![Version](https://img.shields.io/cocoapods/v/SuperID.svg?style=flat)](http://cocoapods.org/pods/SuperID)
[![License](https://img.shields.io/cocoapods/l/SuperID.svg?style=flat)](http://cocoapods.org/pods/SuperID)
[![Platform](https://img.shields.io/cocoapods/p/SuperID.svg?style=flat)](http://cocoapods.org/pods/SuperID)

一登 SDK 为应用提供了便捷的刷脸登录模式。通过一登账号体系，移动终端用户可快速登录开发者应用。同时，一登SDK提供了人脸属性高级功能，让移动开发者可以基于人脸属性，为应用做更精准的数据推送。

- 获取用户状态：刷脸获取用户颜值情绪等当前状态信息
- 进行精准推荐：基于用户属性和状态进行精准内容推荐
- 激发分享欲望：精选内容加上状态标签让用户乐于分享

## 接入流程

1. 在[官网首页](http://superid.me)点击【注册】完成一登开发者注册；
2. 登录一登开发者中心，点击【SDK下载】，在一登Github上下载对应的SDK版本（或通过```CocoaPods```安装）、Demo源码和技术文档；
3. 登录一登开发者中心，点击【创建新应用】，填写信息；
4. 添加应用成功后，获取```APP_ID```、```APP_SECRET```；
5. 阅读[技术文档](http://superid.me/document/iOS_f.html)进行集成；
6. 测试。


### 使用CocoaPods安装

推荐使用CocoaPods安装一登SDK

```
platform :ios, '7.0'
pod "SuperID"
```

执行```pod install```将会安装最新版本的一登SDK

## 版本更新说明

> 更新时请务必替换SDK所有的资源文件，特别资源文件bundle。

### V1.3.2 20150617

- 为iPhone5以上设备添加键盘按钮，提高操作便捷性


### V1.3.1 20150612

- 增加了闭眼动作识别和图像过滤
- 增加了发布渠道的字段设置
- 增加了仿真机调试时的数据过滤


### V1.2.8 20150603

- 修复了iOS7.0.4问题
- 增加了重刷人脸时双击界面直接启动加亮模式
- 简化了SDK注册流程（去除了授权提醒AlertView）


### V1.2.7 20150522

- 支持Xcode模拟器编译，包括iPhone6和6+
- 优化了登录流程、提高人脸检测和比对准确性
- 修复了首次注册用户自动填充头像信息功能
- 完善了登录和绑定接口。当传入手机号码参数时，可作为三方账号的人脸二级加密用法。

### V1.2.5 20150513

- 升级人脸属性接口
- 规范头像尺寸
- 更新人脸检测器
- 新增人工审核重新绑定人脸逻辑


### V1.2.4 20150413

- 国际号码按钮UI调整
- SDK内部优化

### V1.2.2 20150326

- 新增夜间加亮模式，支持黑暗环境下正常使用刷脸登录。
- 修改了 bundle 资源的部分文字
- 修改了SDK初始化注册 API,返回为 void。
- 修改DebugMode API为类方法
- 人脸属性高级接口中，在深度整合的 API 中，修正初始化化人脸属性接口API, 改为 configure 开头。
