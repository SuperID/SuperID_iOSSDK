//
//  CONFIG.h
//  LeYi
//
//  Created by Yourtion on 14-2-25.
//  Copyright (c) 2014年 Yourtion. All rights reserved.
//
#import "MacroDefinition.h"

#ifndef LeYi_CONFIG_h
#define LeYi_CONFIG_h

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


//Get View origin:
#define VIEW_TX(view) (view.frame.origin.x)
#define VIEW_TY(view) (view.frame.origin.y)

//Get View size:
#define VIEW_W(view)  (view.frame.size.width)
#define VIEW_H(view)  (view.frame.size.height)

//Get view's corner origin:
#define VIEW_BX(view) (view.frame.origin.x + view.frame.size.width)
#define VIEW_BY(view) (view.frame.origin.y + view.frame.size.height)


//Get Frame origin:
#define FRAME_TX(frame)  (frame.origin.x)
#define FRAME_TY(frame)  (frame.origin.y)

//Get Frame size:
#define FRAME_W(frame)  (frame.size.width)
#define FRAME_H(frame)  (frame.size.height)

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

#endif
