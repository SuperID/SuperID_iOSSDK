//
//  faceFeatureListView.m
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 4/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import "faceFeatureListViewController.h"
#import "CONFIG.h"
#import "PubFunctions.h"


@interface faceFeatureListViewController()

@property (nonatomic, weak)NSArray *featureKeyArray;

@end
@implementation faceFeatureListViewController



-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = Superid_Demo_Artboard;
    self.tableView.backgroundColor = Superid_Demo_Artboard;
    self.navigationItem.title=@"人脸信息识别";
    self.faceFeatureDitionary = [[NSUserDefaults standardUserDefaults]objectForKey:@"FaceFeature"];
    self.featureKeyArray = [self.faceFeatureDitionary allKeys];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator=NO;
    if (isIphone4) {
        
        self.tableView.scrollEnabled = YES;
        
    }else{
        
        self.tableView.scrollEnabled = NO;
    }
    
    [PubFunctions setExtraCellLineHidden:self.tableView];
    
    NSLog(@"FaceFeatureDictionary = %@",self.faceFeatureDitionary);

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.faceFeatureDitionary.count;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_W(self.view),44)];
    customView.backgroundColor = Superid_Demo_Artboard;
    return customView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

        
    return 44;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    cell =  [self.tableView dequeueReusableCellWithIdentifier:@"faceFeatureCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [PubFunctions transformFeatureKeyToChinese:[self.featureKeyArray objectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [self.faceFeatureDitionary objectForKey:[self.featureKeyArray objectAtIndex:indexPath.row]];
//    switch (indexPath.row) {
//        case 0:
//            
//            if ([[self.faceFeatureDitionary objectForKey:@"Eyeglasses"]boolValue] == YES) {
//                
//                cell.detailTextLabel.text = @"有戴";
//                
//            }else{
//                
//                cell.detailTextLabel.text = @"没戴";
//            }
//            
//            break;
//        case 1:
//            
//            if ([[self.faceFeatureDitionary objectForKey:@"Male"]boolValue] == YES) {
//                
//                cell.detailTextLabel.text = @"男";
//                
//            }else{
//                
//                cell.detailTextLabel.text = @"女";
//            }
//            
//            break;
//        case 2:
//            
//            if ([[self.faceFeatureDitionary objectForKey:@"Smiling"]boolValue] == YES) {
//                
//                cell.detailTextLabel.text = @"有";
//                
//            }else{
//                
//                cell.detailTextLabel.text = @"无";
//            }
//            break;
//            
//        default:
//            break;
//    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}





@end
