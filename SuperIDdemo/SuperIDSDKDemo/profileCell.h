//
//  profileCell.h
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 3/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAImageView.h"

@interface profileCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet PAImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;

@end
