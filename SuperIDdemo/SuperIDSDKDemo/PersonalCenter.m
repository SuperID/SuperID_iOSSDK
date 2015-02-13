//
//  PersonalCenter.m
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 2/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import "PersonalCenter.h"
#import "CONFIG.h"
#import "profileCell.h"
#import "MainCell.h"
#import "logoutCell.h"
#import "PubFunctions.h"
#import "SuperIDSDK.h"
#import "MBProgressHUD.h"
#import "faceFeatureListView.h"
#import "HideModeFaceFeatureView.h"

//声明当前VC继承SuperIDSDK的委托

@interface PersonalCenter()<SuperIDSDKDelegate>{
    
    NSArray     *iconArray;
    NSArray     *nameArray;
    NSArray     *functionArray;
    SuperIDSDK  *SDK;
}

@end


//   当用户修改了app的个人资料以后，请调用此接口进行资料上传更新。
//    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];

//    更新用户的APP个人信息
//    [userInfo setObject:@"xxxxx" forKey:@"name"];
//    [userInfo setObject:@"xxxx@gmail.com" forKey:@"email"];
//    [userInfo setObject:@"xxxxxxxxx" forKey:@"avatar"];
//
//    [SDK updateAppUserInfoToSuperIDAccount:userInfo];/**



@implementation PersonalCenter


-(void)viewDidLoad{
    
    [super viewDidLoad];

    self.view.backgroundColor = Superid_Demo_Artboard;
    self.tableView.backgroundColor = Superid_Demo_Artboard;
    self.navigationItem.title=@"个人中心";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [PubFunctions setExtraCellLineHidden:self.tableView];
    
    iconArray = [[NSArray alloc]initWithObjects:@"superid_demo_binding_wechat_ico_disable",@"superid_demo_binding_superid_ico_disable",@"superid_demo_binding_weibo_ico_disable", nil];
    nameArray = [[NSArray alloc]initWithObjects:@"微信",@"一登",@"新浪微博", nil];
    functionArray = [[NSArray alloc]initWithObjects:@"人脸表情",@"人脸表情(隐藏版)", nil];
    
    
    if (!self.appUserInfo) {
        
        self.appUserInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"appUserInfo"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finshGetFaceFeatureNoPreviewMode:) name:GETFACEFEATURE object:nil];

}

-(void)viewWillAppear:(BOOL)animated{
    
    SDK = [SuperIDSDK sharedInstance];
    SDK.delegate = self;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
     
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
        
    }else if (section == 1){
        
        return 3;
        
    }else if (section == 2){
        
        return 2;
        
    }else{
        
        return 1;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_W(self.view),44)];
    customView.backgroundColor = Superid_Demo_Artboard;
    return customView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0;
        
    }else{
        
        return 16;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 140;
        
    }else{
        
        return 44;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        profileCell *cell =  [self.tableView dequeueReusableCellWithIdentifier:@"profileCell" forIndexPath:indexPath];
        
        if (self.appUserInfo) {
            
            [cell.avatarImg setImageURL:[self.appUserInfo objectForKey:@"avatar"]];
            
             cell.userName.text = [self.appUserInfo objectForKey:@"name"];
            
            if ([[self.appUserInfo objectForKey:@"phone"] isKindOfClass:[NSNumber class]]){
                
                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                cell.phoneLable.text =[numberFormatter stringFromNumber:[self.appUserInfo objectForKey:@"phone"]];
                
            }else{
                
                cell.phoneLable.text = [self.appUserInfo objectForKey:@"phone"];
            }
            
            
        }
        return cell;
        
    }else if (indexPath.section == 1){
        
        MainCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
        
        cell.bundleLable.text = @"点击绑定";
        
        cell.iconImg.image = IMG([iconArray objectAtIndex:indexPath.row]);
        
        cell.nameLable.text = [nameArray objectAtIndex:indexPath.row];
        
        if (indexPath.row == 1) {
            
            if ([self userIsAouth]) {
                
                cell.bundleLable.text = @"解除绑定";
                cell.bundleLable.textColor = superID_Demo_Font_Tips;
                cell.iconImg.image = [UIImage imageNamed:@"superid_demo_binding_superid_ico_normal"];
                
            }else{
                
                cell.bundleLable.text = @"点击绑定";
                cell.bundleLable.textColor = superID_Demo_Theme;
                cell.iconImg.image = [UIImage imageNamed:@"superid_demo_binding_superid_ico_disable"];
            }
        }

        return cell;
        
    }else if (indexPath.section == 2){
        
        MainCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
        
        cell.nameLable.text = [functionArray objectAtIndex:indexPath.row];
        
        cell.iconImg.image = [UIImage imageNamed:@"superid_demo_faceinfo_weibo_ico_normal"];
        
        cell.bundleLable.text = @"点击体验";
        
        return cell;
        
    }else{
        
         logoutCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"logoutCell" forIndexPath:indexPath];
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    if (indexPath.section == 1&&indexPath.row == 1) {
        
        if ([self userIsAouth]) {
            
            [[SuperIDSDK sharedInstance] superIDUserCancelTheAuthorization];
            
        }else{
            
           //采用present方式弹出授权绑定页面：
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"xxx",@"name",@"xxxx@gmail.com",@"email",@"http://xxxxxx",@"avatar", nil];
            //此处采用时间戳作为替代UID，以做DEMO示例
            NSDate *datenow = [NSDate date];
            NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
            NSError *error = nil;
//            开发者应当如下使用（如果手机号码为空，置为nil）：
//            id SuperIDOAuthView = [[SuperIDSDK sharedInstance] obtainSuperIDOAuthViewWithAppUid:@"用户的AppUid"
//                                                                                    MobliePhone:@“用户的手机号码” userAppInfo:@“用户的App个人信息” error:&error];
            
            id SuperIDOAuthView = [[SuperIDSDK sharedInstance] obtainSuperIDOAuthViewWithAppUid:timeSp
                                                                                         MobliePhone:nil userAppInfo:nil error:&error];
                
            if (SuperIDOAuthView) {
                    
                [self presentViewController:SuperIDOAuthView animated:YES completion:nil];
                    
            }else{
                    
                NSLog(@"SuperIDOAuthView Error =%ld,%@",(long)[error code],[error localizedDescription]);
            }

        }
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            //采用present的方式弹出人脸情绪的功能：
            NSError *error = nil;
            
            id emotionView = [[SuperIDSDK sharedInstance]obtainSuperIDFaceFeatureViewWithPreview:&error];
            
            
            if (emotionView) {
                
                [self presentViewController:emotionView animated:YES completion:nil];
                
            }else{
                
                NSLog(@"loginView Error =%ld,%@",(long)[error code],[error localizedDescription]);
                //授权过期或者用户已经解除绑定
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"请先绑定一登";
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:0.8];
            }

        }else if (indexPath.row == 1){
        
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HideModeFaceFeatureView *faceFeatureView = [storyboard instantiateViewControllerWithIdentifier:@"hideModeFaceFeatureView"];
            [self presentViewController:faceFeatureView animated:YES completion:nil];
        }
        
        
    }else if (indexPath.section == 3) {
        
        //当app执行退出账号操作时，您需要执行以下方法，以清楚SuperID SDK内的缓存信息。
        // [[SuperIDSDK sharedInstance]logoutSuperIDAccountInApp];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否退出当前账号" message:nil delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
        
        alert.delegate = self;
        
        alert.tag = 1;
        
        [alert show];
        
        self.appUserInfo = nil;
    }
}

-(BOOL)userIsAouth{
    
    //由于demo无法提供完善的三方账号体系作为流程演示，在使用授权接口是采用随机时间戳作为替代，因此在检测user 授权状态时，在demo内使用改接口 isAppAouth.
    return [[SuperIDSDK sharedInstance]isAppOAuth];
    
    //在实际使用中，您应当使用如下接口：
    //-(void)checkUserAouthrizedStateWithUid:(NSString *)uid; 传入当前用户在您APP内的uid，检测该uid是否已经被SuperID账号授权。
    
}

#pragma mark - SuperIDSDK Delegate methods

//用户解绑成功提醒操作：
-(void)userCancelOAuthWithSuperIDSuccess{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"解绑成功";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
    [self.tableView reloadData];
    NSLog(@"SuperIDSDK:userCancelAouthWithSuperIDSuccess");
}

//用户解绑失败提醒操作：
-(void)userCancelOAuthWithSuperIDFail{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"解绑失败";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
    NSLog(@"SuperIDSDK:userCancelOAuthWithSuperIDFail");
}

//用户授权绑定成功后的方法回调
-(void)userDidFinishOAuthAppWithSuperID:(NSDictionary *)superIDUserInfo andAppUID:(NSString *)appUid{
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]initWithDictionary:superIDUserInfo];
    self.appUserInfo = temp;
    NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];
    [userSettings setObject:superIDUserInfo forKey: @"appUserInfo"];

    [self.tableView reloadData];
}

//用户授权绑定失败后的方法回调
-(void)userOAuthAppWithSuperIDFail:(NSError *)error{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"绑定失败";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];

    NSLog(@"superid SDK:userAouthAppWithSuperIDFail");
}

//获取人脸信息成功回调
-(void)getSuperIDUserFaceFeatureSuccess:(NSDictionary *)featureData{
    
    if (featureData) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        faceFeatureListView *personView= [storyboard instantiateViewControllerWithIdentifier:@"faceFeatureList"];
         [[NSUserDefaults standardUserDefaults]setObject:[PubFunctions filterFaceFeaturesData:featureData] forKey:@"FaceFeature"];
        [self.navigationController pushViewController:personView animated:NO];
        
    }
}

//获取人脸信息失败回调
-(void)getSuperIDUserFaceFeatureFail:(NSError *)error{
    
    if ([error code]==-1007) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请先绑定一登";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0.8];
        NSLog(@"getSuperIDUserEmotionAndFaceFeatureFail");
        
    }else if ([error code]==-1005){
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"帐号已被冻结";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0.8];
        NSLog(@"userAccountHasBeenFrozen");
        
    }else if ([error code] ==-1016){
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"获取人脸信息失败";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0.8];
        NSLog(@"getSuperIDUserEmotionAndFaceFeatureFail");
        
    }
    
}

-(void)finshGetFaceFeatureNoPreviewMode:(NSNotification*)notification{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    faceFeatureListView *personView= [storyboard instantiateViewControllerWithIdentifier:@"faceFeatureList"];
    [self.navigationController pushViewController:personView animated:NO];
}

#pragma mark - UIAlertview delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1 && buttonIndex == 1) {

        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
