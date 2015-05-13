//
//  PubFunctions.h
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 2/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PubFunctions : UITableViewController

+ (void)setExtraCellLineHidden: (UITableView *)tableView;
+ (CALayer *)AddBorderLayer:(UIColor *)borderColor withWidth:(float)width onY:(float)pointY;
+ (void)setupLoginViewUIDisplay:(UIViewController *)vc;
+ (void *)intialTextField:(UITextField *)textField;
+ (NSDictionary *)filterFaceFeaturesData:(NSDictionary *)originalData;
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
+ (NSString *)transformFeatureKeyToChinese:(NSString *)keyStr;

@end
