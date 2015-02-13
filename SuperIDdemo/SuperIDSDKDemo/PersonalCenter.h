//
//  PersonalCenter.h
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 2/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenter : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableDictionary *appUserInfo;

@end
