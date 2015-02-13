//
//  CONFIG.h
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 2/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#ifndef SuperIDSDKDemo_CONFIG_h
#define SuperIDSDKDemo_CONFIG_h

// exception macros
#define NOT_IMPLEMENTED_EXCEPTION   @"NOT_IMPLEMENTED_EXCEPTION"

#pragma mark 设备判断
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)

#pragma mark 打印日志

//DEBUG模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//Debug模式下打印Frame
#if DEBUG
#define LogFrame(frame) NSLog(@"frame[X=%.1f,Y=%.1f,W=%.1f,H=%.1f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height)
#else
#define LogFrame(frame) nil
#endif

//Debug模式下打印Point
#if DEBUG
#define LogPoint(point) NSLog(@"Point[X=%.1f,Y=%.1f]",point.x,point.y)
#else
#define LogPoint(point) nil
#endif

#pragma mark 图片

//读取资源图片
#define IMG(name) [UIImage imageNamed:name]

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//读取沙盒图片地址
#define SANDBOXIMAGEPATH(filename) [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:filename];

//读取沙盒图片
#define SANDBOXIMAGE(filename) [UIImage imageWithContentsOfFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:filename]];

//读取Tmp地址
#define TEMPFILEPATH(filename) [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:filename];

//读取Tmp文件
#define TEMPFILE(filename) [UIImage imageWithContentsOfFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:filename]];

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

#pragma mark 定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

#define Superid_Demo_Artboard  HEXRGB(0xF2F2F2)

#define superID_Demo_Font_Title  HEXRGB(0x232323)

#define  superID_Demo_Font_Text  HEXRGB(0x323232)

#define  superID_Demo_Font_Contant  HEXRGB(0x626262)

#define  superID_Demo_Font_Tips  HEXRGB(0x979797)

#define  superID_Demo_Font_White  HEXRGB(0xFFFFFF)

#define  superID_Demo_Theme  HEXRGB(0xFF4343)

#define  common_Btn_Disabled  HEXRGB(0xFFD0D0)

#define  common_Btn_Enabled  HEXRGB(0xFF4343)

#define  common_Btn_Pressed  HEXRGB(0xBA3030)

#define  superID_Demo_Border  HEXRGB(0xCCCCCC)

#define  superID_Demo_Progress  HEXRGB(0x0999d0)

#define  superID_Demo_FaceFeature_BG1 HEXRGB(0xE6507B)

#define  superID_Demo_FaceFeature_BG2  HEXRGB(0xF26D5F)

#define  superID_Demo_FaceFeature_BG3  HEXRGB(0xFFA200)

#define  superID_Demo_FaceFeature_BG4 HEXRGB(0x35B87F)

#define  superID_Demo_FaceFeature_BG5  HEXRGB(0x5BB4DA)

#define  superID_Demo_FaceFeature_BG6  HEXRGB(0x66CCCC)

#define  superID_Demo_FaceFeatureAvatarBG  HEXRGB(0x0999D0)

//define Notification key:

#define GETFACEFEATURE              @"getFaceFeatureDone"
#define GETFACEFEATUREDONE          @"getFaceFeatureDone"


//define the face feature keywords:

#define GENDER                      @"gender"
#define AGE                         @"age"
#define BEAUTY                      @"beauty"
#define GLASS                       @"glass"
#define SUNGLASS                    @"sunGlass"
#define SMILE                       @"smile"
#define BEARD                       @"beard"
#define MOUTHOPEN                   @"mouthOpen"
#define EYECLOSE                    @"eyeClose"
#define EMOTION                     @"emotion"
#define EMOTIONVALUE                @"emotionValue"


//Get View origin:
#define VIEW_TX(view) (view.frame.origin.x)
#define VIEW_TY(view) (view.frame.origin.y)

//Get View size:
#define VIEW_W(view)  (view.frame.size.width)
#define VIEW_H(view)  (view.frame.size.height)

//Get view's corner origin:
#define VIEW_BX(view) (view.frame.origin.x + view.frame.size.width)
#define VIEW_BY(view) (view.frame.origin.y + view.frame.size.height)

// font definition:
#define SuperID_Size_Font_Bar       [UIFont systemFontOfSize:17]
#define SuperID_Size_Font_Title     [UIFont systemFontOfSize:16]
#define SuperID_Size_Font_Text      [UIFont systemFontOfSize:13]
#define SuperID_Size_Font_Tips      [UIFont systemFontOfSize:12]
#define SuperID_Size_Font_Contant   [UIFont systemFontOfSize:15]

//Screen Height and width
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

//读取沙盒图片
#define SANDBOXIMAGE(filename) [UIImage imageWithContentsOfFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:filename]];

#define   isIphone4  [UIScreen mainScreen].bounds.size.height < 500

#pragma mark 颜色类
//rgb颜色转换（16进制->10进制）
#define HEXRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

//  主要单例
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]
#define MainScreen                          [UIScreen mainScreen]

//  主要控件
#define TabNavItem                          self.tabBarController.navigationItem
#define NavItem                             self.navigationItem

#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define NavBarHeight                        self.navigationController.navigationBar.bounds.size.height
#define TabBarHeight                        self.tabBarController.tabBar.bounds.size.height
#define TouchHeightDefault                  44.0f
#define TouchHeightSmall                    32.0f

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#endif
