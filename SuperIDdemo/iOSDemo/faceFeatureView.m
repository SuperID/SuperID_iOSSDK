//
//  faceFeatureView.m
//  SuperIDsdk_Demo
//
//  Created by XU JUNJIE on 21/12/14.
//  Copyright (c) 2014 ISNC. All rights reserved.
//

#import "faceFeatureView.h"
#import "CONFIG.h"
@interface faceFeatureView()<UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray *BundingArray;
    NSMutableDictionary *emotionDitionary;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
@implementation faceFeatureView


-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = Superid_Demo_Artboard;
    self.navigationItem.title=@"人脸信息识别";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.scrollEnabled = NO;
    
      BundingArray = [[NSMutableArray alloc]initWithObjects:@"性别",@"年龄",@"心情",@"美貌值",@"眼镜", @"太阳镜",@"微笑值",@"胡须密度",@"嘴巴张开度",@"眼镜闭合度",nil];
    
    emotionDitionary = [[NSMutableDictionary alloc]initWithObjects:@[@"愉快",@"愤怒",@"平静",@"惊讶",@"困惑",@"悲伤",@"恐惧"] forKeys:@[@"happy",@"angry",@"calm",@"surprised",@"confused",@"sad",@"disgust"]];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        
   return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    cell= [self.tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    
    cell.textLabel.text = [BundingArray objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        
        NSString *gender;
        NSNumber *ageNumber = [self.faceFeatureDitionary objectForKey:@"sex"];
        if ([ageNumber isEqualToNumber:@1]) {
            
            gender = @"男";
        }else{
            gender = @"女";
            
        }
        cell.detailTextLabel.text = gender;
        
    }
    if (indexPath.row == 1) {
        
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        NSMutableArray *faceFeature = [[NSMutableArray alloc]init];
        NSString *age = [numberFormatter stringFromNumber:[self.faceFeatureDitionary objectForKey:@"age"]];
        cell.detailTextLabel.text = age;
    }
    if (indexPath.row == 3) {
        
        NSNumber *beauty =[self.faceFeatureDitionary objectForKey:@"beauty"];
        float beatyValue = [beauty floatValue]*100;
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%.2f",beatyValue];
    }
    if (indexPath.row == 4) {
        
        NSNumber *glassNumber = [self.faceFeatureDitionary objectForKey:@"glasses"];
        NSString *glass;
        if ([glassNumber isEqualToNumber:@1]) {
            
            glass = @"有戴";
            
        }else{
            
            glass = @"没戴";
        }
        cell.detailTextLabel.text = glass;
    }
    if (indexPath.row == 5) {
        
        NSString *sunglass;
        NSNumber *sunglassValue = [self.faceFeatureDitionary objectForKey:@"sunglasses"];
        if ([sunglassValue  isEqualToNumber: @1]) {
            
            sunglass = @"有戴";
            
        }else{
            
            sunglass = @"没戴";
            
        }
        cell.detailTextLabel.text = sunglass;
    }
    if (indexPath.row == 6) {
        
        NSNumber *smile =[self.faceFeatureDitionary objectForKey:@"smile"];
        float smileValue = [smile floatValue];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f",smileValue];
    }
    if (indexPath.row == 7) {
        
        NSNumber *beard =[self.faceFeatureDitionary objectForKey:@"beard"];
        float beardValue = [beard floatValue]*100;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f%%",beardValue];
    }
    if (indexPath.row == 8) {
        
        NSNumber *mouthOpen =[self.faceFeatureDitionary objectForKey:@"mouth_open_wide"];
        float mouthValue = [mouthOpen floatValue]*100;
        NSLog(@"mouthopen = %.2f%%",mouthValue);
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f%%",mouthValue];
    }
    if (indexPath.row == 9) {
        
        NSNumber *eyeClose =[self.faceFeatureDitionary objectForKey:@"eye_closed"];
        float eyeCloseValue = [eyeClose floatValue]*100;
        NSLog(@"eye = %.2f%%",eyeCloseValue);
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f%%",eyeCloseValue];
    }
    if (indexPath.row == 2) {
        
        NSDictionary *emotion = [self.faceFeatureDitionary objectForKey:@"emotion"];
        NSArray *keys  =    [emotion allKeys];
        NSArray *values =   [emotion allValues];
        double maximumValues=0;
        NSString *keyString = [[NSString alloc]init];
        
        for (int i = 0; i<[values count]; i++) {
            
            NSNumber *value = [values objectAtIndex:i];
            double valueInt = [value doubleValue];
            if (valueInt>maximumValues) {
                
                maximumValues=valueInt;
                keyString = [keys objectAtIndex:i];
                NSLog(@"keyString = %@",keyString);
            }
        }
        
        NSString *emotionTag = [emotionDitionary objectForKey:keyString];
        emotionTag = [emotionTag stringByAppendingString:[NSString stringWithFormat:@"(%.2f%%)",maximumValues*100]];
        NSLog(@"emotionTag = %@",emotionTag);
        cell.detailTextLabel.text = emotionTag;
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


@end
