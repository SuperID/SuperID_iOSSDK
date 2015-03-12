//
//  faceFeatureListView.h
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 4/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface faceFeatureListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak,nonatomic) NSDictionary *faceFeatureDitionary;

@end
