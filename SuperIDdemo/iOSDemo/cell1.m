//
//  cell1.m
//  SuperIDsdk_Demo
//
//  Created by XU JUNJIE on 20/12/14.
//  Copyright (c) 2014 ISNC. All rights reserved.
//

#import "cell1.h"
#import "CONFIG.h"

@implementation cell1

- (void)awakeFromNib {
    
    self.nameLable.font = SuperID_Size_Font_Title;
    self.nameLable.textColor = superID_Demo_Font_Title;
    self.iconImg.contentMode = UIViewContentModeScaleAspectFit;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
