//
//  MacroDefinition.h
//  LeYi
//
//  Created by Yourtion on 14-2-25.
//  Copyright (c) 2014年 Yourtion. All rights reserved.
//

#ifndef LeYi_MacroDefinition_h
#define LeYi_MacroDefinition_h

typedef enum _BasicViewControllerInfo {
    eBasicControllerInfo_Title,
    eBasicControllerInfo_ImageName,
    eBasicControllerInfo_BadgeString
}BasicViewControllerInfo;



#pragma mark - runtime macros
// check if runs on iPad
#define IS_IPAD_RUNTIME (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// version check
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] != NSOrderedDescending)

#define NTF_WILLSENDMESSAGETOJID                @"NTF_WILLSENDMESSAGETOJID"
#define WILLSENDMESSAGETOJID                    @"WILLSENDMESSAGETOJID"
#define WILLSENDMESSAGETOJID_CHATROOMMESSAGE    @"WILLSENDMESSAGETOJID_CHATROOMMESSAGE"
#define WILLSENDMESSAGETOJID_CHATDATA           @"WILLSENDMESSAGETOJID_CHATDATA"

#define NTF_FINISHED_LOAD_DATA_FROM_DB  @"NTF_FINISHED_LOAD_DATA_FROM_DB"

// used in settings.
typedef enum _playSoundMode {
    ePlaySoundMode_AutoDetect,
    ePlaySoundMode_Speaker,
    ePlaySoundMode_Handset
}PlaySoundMode;

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

//建议使用前两种宏定义,性能高于后者

#pragma mark 颜色类
//rgb颜色转换（16进制->10进制）
#define HEXRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark Size ,X,Y, View ,Frame

//获取View的坐标
#define VIEW_TX(view) (view.frame.origin.x)
#define VIEW_TY(view) (view.frame.origin.y)

//获取View的width,height
#define VIEW_W(view)  (view.frame.size.width)
#define VIEW_H(view)  (view.frame.size.height)

//获取frame的角落坐标
#define FRAME_TX(frame)  (frame.origin.x)
#define FRAME_TY(frame)  (frame.origin.y)

//获取View的角落width,height
#define FRAME_W(frame)  (frame.size.width)
#define FRAME_H(frame)  (frame.size.height)

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
