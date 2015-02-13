//
//  faceFeatureListView.m
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 4/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import "faceFeatureListView.h"
#import "CONFIG.h"
#import "PubFunctions.h"


@interface faceFeatureListView(){
    
    NSArray *BundingArray;
}

@end
@implementation faceFeatureListView



-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = Superid_Demo_Artboard;
    self.tableView.backgroundColor = Superid_Demo_Artboard;
    self.navigationItem.title=@"人脸信息识别";
    self.faceFeatureDitionary = [[NSUserDefaults standardUserDefaults]objectForKey:@"FaceFeature"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator=NO;
    if (isIphone4) {
        
        self.tableView.scrollEnabled = YES;
        
    }else{
        
        self.tableView.scrollEnabled = NO;
    }
    
    [PubFunctions setExtraCellLineHidden:self.tableView];
    
    BundingArray = [[NSMutableArray alloc]initWithObjects:@"性别",@"年龄",@"情绪",@"颜值",@"眼镜", @"太阳镜",@"微笑值",@"胡须密度",@"嘴巴张开度",@"嘴巴闭合度",nil];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
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

    cell.textLabel.text = [BundingArray objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:
            
            cell.detailTextLabel.text = [self.faceFeatureDitionary objectForKey:GENDER];
            break;
        case 1:
            
            cell.detailTextLabel.text = [self.faceFeatureDitionary objectForKey:AGE];
            break;
        case 2:
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",[self.faceFeatureDitionary objectForKey:EMOTION],[self.faceFeatureDitionary objectForKey:EMOTIONVALUE]];
            break;
        case 3:
            
            cell.detailTextLabel.text = [self.faceFeatureDitionary objectForKey:BEAUTY];
            break;
        case 4:
            
            cell.detailTextLabel.text = [self.faceFeatureDitionary objectForKey:GLASS];
            break;
        case 5:
            
            cell.detailTextLabel.text = [self.faceFeatureDitionary objectForKey:SUNGLASS];
            break;
        case 6:
            
            cell.detailTextLabel.text = [self.faceFeatureDitionary objectForKey:SMILE];
            break;
        case 7:
            
            cell.detailTextLabel.text = [self.faceFeatureDitionary objectForKey:BEARD];
            break;
        case 8:
            
            cell.detailTextLabel.text = [self.faceFeatureDitionary objectForKey:MOUTHOPEN];
            break;
        case 9:
            
            cell.detailTextLabel.text = [self.faceFeatureDitionary objectForKey:EYECLOSE];
            break;
        
            
        default:
            break;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}





@end
