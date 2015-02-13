//
//  profileCell.m
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 3/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import "profileCell.h"
#import "CONFIG.h"

@implementation profileCell

-(void)awakeFromNib{
    
    self.selectionStyle = UITableViewCellEditingStyleNone;
    
    self.profileImg.backgroundColor = [UIColor grayColor];
    self.profileImg.layer.cornerRadius = VIEW_W(self.profileImg)/2;
    self.profileImg.clipsToBounds = YES;
    self.profileImg.layer.borderWidth=1.5;
    self.profileImg.layer.borderColor=[[UIColor clearColor]CGColor];
    self.profileImg.image = [UIImage imageNamed:@"superid_demo_avatar_img_default"];
    
    self.avatarImg = [[PAImageView alloc]initWithFrame:CGRectMake(0, 0, VIEW_W(self.profileImg), VIEW_H(self.profileImg)) backgroundProgressColor:[UIColor clearColor] progressColor:superID_Demo_Progress];
    self.avatarImg.CacheEnabled = YES;
    [self.profileImg addSubview:self.avatarImg];
}

@end
