//
//  MainCell.m
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 3/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import "MainCell.h"
#import "CONFIG.h"

@implementation MainCell

-(void)awakeFromNib{
    
    self.nameLable.font = SuperID_Size_Font_Title;
    self.nameLable.textColor = superID_Demo_Font_Title;
    self.iconImg.contentMode = UIViewContentModeScaleAspectFit;
    self.bundleLable.textColor = superID_Demo_Theme;
    self.bundleLable.font = SuperID_Size_Font_Text;
}

@end
