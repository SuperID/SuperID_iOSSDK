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
#import "SuperID.h"                             //声明一登头文件
#import "MBProgressHUD.h"
#import "faceFeatureListViewController.h"
#import "AdvancedFaceFeatureViewController.h"

/**
 *  声明SuperIDDelegate协议引用
 */
@interface PersonalCenter()<SuperIDDelegate>{
    
    NSArray     *iconArray;
    NSArray     *nameArray;
    NSArray     *functionArray;
    SuperID     *superIdSdk;
}

@end

//   ************************************************************

//   当用户修改了app的个人资料以后，请调用此接口进行资料上传更新。
//    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];

//    更新用户的APP个人信息
//    [userInfo setObject:@"xxxxx" forKey:@"name"];
//    [userInfo setObject:@"xxxx@gmail.com" forKey:@"email"];
//    [userInfo setObject:@"xxxxxxxxx" forKey:@"avatar"];
//
//    [SDK updateAppUserInfoToSuperIDAccount:userInfo];/**

//   ************************************************************

//   ************************************************************
//
//   当用户完成授权操作或者进入用户个人授权页面时，开发者需查询用户授权状态用
//   于更新UI界面和切换绑定、解绑操作。方法如下
//   - (void)queryCurrentUserAuthorizationStateWithUid:(NSString *)uid;
//
//   ************************************************************

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
    
     [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    superIdSdk = [SuperID sharedInstance];  //获取SDK单例；
    superIdSdk.delegate = self;             //设置SDK的委托对象
   
    
    
    
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
            
            //此处通过查询用户与一登账号授权状态切换UI界面。开发者需调用Uid查询接口，在实现SuperID协议的方法中根据状态reloadTableView
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
            
            [[SuperID sharedInstance] userCancelAuthorization];
            
        }else{
            
           //生成用户个人账户信息的字典：其中key：name，email，avatar这三项需跟demo所示一致：
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"xxx",@"name",@"xxxx@gmail.com",@"email",@"http://xxxxxx",@"avatar", nil];
            
            //调用授权绑定的VC需传入用户的账号Uid，由于Demo无独立的三方账号体系，采用随机的时间戳作为Uid做Demo示例用。
            NSDate *datenow = [NSDate date];
            NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
            NSError *error = nil;
            
//            开发者应当如下使用（如果手机号码为空，置为nil）：
//            id SIDAuthViewController = [[SuperID sharedInstance]obtainAuthViewControllerWithUid:@"用户的AppUid" phoneNumber:@“用户的手机号码” appUserInfo:@"用户的应用账户信息" error:&error];
            
            id SIDAuthViewController = [[SuperID sharedInstance]obtainAuthViewControllerWithUid:timeSp phoneNumber:nil appUserInfo:nil error:&error];
            
            if (SIDAuthViewController) {
                    
                [self presentViewController:SIDAuthViewController animated:YES completion:nil];
                    
            }else{
                    
                NSLog(@"SuperIDOAuthView Error =%ld,%@",(long)[error code],[error localizedDescription]);
            }

        }
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            //采用present的方式弹出人脸情绪的功能：
            NSError *error = nil;
            
            id SIDEmotionViewController = [[SuperID sharedInstance]obtainFaceFeatureViewControllerWithError:&error];
            
            
            if (SIDEmotionViewController) {
                
                [self presentViewController:SIDEmotionViewController animated:YES completion:nil];
                
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
            AdvancedFaceFeatureViewController *AdvancedFaceFeatureViewController = [storyboard instantiateViewControllerWithIdentifier:@"advancedFaceFeatureView"];
            [self presentViewController:AdvancedFaceFeatureViewController animated:YES completion:nil];
        }
        
        
    }else if (indexPath.section == 3) {

        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否退出当前账号" message:nil delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
        
        alert.delegate = self;
        
        alert.tag = 1;
        
        [alert show];
        
        self.appUserInfo = nil;
    }
}

-(BOOL)userIsAouth{
    
    //由于demo无法提供完善的三方账号体系作为流程演示，在使用授权接口是采用随机时间戳作为替代，因此在检测user 授权状态时，在demo内使用改接口 isAppAouth.
    return [[SuperID sharedInstance]isAppAuth];
    
    //在实际使用中，您应当使用如下接口：
    //-(void)checkUserAouthrizedStateWithUid:(NSString *)uid; 传入当前用户在您APP内的uid，检测该uid是否已经被SuperID账号授权。
    
}

#pragma mark - SuperIDSDK Delegate methods

//用户完成一登授权绑定操作的回调方法
- (void)superID:(SuperID *)sender userDidFinishAuthAppWithUserInfo:(NSDictionary *)userInfo withAppUid:(NSString *)uid error:(NSError *)error{
    
    if (!error) {
        
        //用户授权绑定成功后的执行内容
        NSMutableDictionary *temp = [[NSMutableDictionary alloc]initWithDictionary:userInfo];
        self.appUserInfo = temp;
        NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];
        [userSettings setObject:userInfo forKey: @"appUserInfo"];
        
        [self.tableView reloadData];
        
    }else{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"绑定失败";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0.8];
    }
}

//用户完成一登账号取消绑定授权操作完成的回调方法
- (void)superID:(SuperID *)sender userDidFinishCancelAuthorization:(NSError *)error{
    
    if (!error) {
        
        //解除绑定授权成功
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"解绑成功";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0.8];
        [self.tableView reloadData];
        
    }else{
        
        //解除绑定授权失败
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"解绑失败";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0.8];
    }
}

//用户完成获取人脸信息操作的回调方法
- (void)superID:(SuperID *)sender userDidFinishGetFaceFeatureWithFeatureInfo:(NSDictionary *)featureInfo error:(NSError *)error{
    
    if (!error) {
        
        //获取人脸信息成功
        if (featureInfo) {
            
            NSLog(@"featureInfo = %@",featureInfo);
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            faceFeatureListViewController *featureListView= [storyboard instantiateViewControllerWithIdentifier:@"faceFeatureList"];
            [[NSUserDefaults standardUserDefaults]setObject:[PubFunctions filterFaceFeaturesData:featureInfo] forKey:@"FaceFeature"];
            [self.navigationController pushViewController:featureListView animated:NO];
            
        }
        
    }else{
        
        //获取人脸信息失败，开发者统一做获取失败的处理。也可根据开发者文档的错误信息描述进行不同的操作处理。
        if ([error code]==-1007) {
            
            //用户尚未使用一登账号登录或绑定授权一等账号，因此无法获取人脸信息，开发者可建议用户执行一登账号绑定或登录操作
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"请先绑定一登";
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:0.8];
            
        }else if ([error code]==-1005){
            
            //用户的一登账号由于安全问题，用户选择冻结其一登账号，此情况下无法进行获取人脸信息操作。
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"帐号已被冻结";
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:0.8];
            
        }else if ([error code] ==-1016){
            
            //由于用户手机网络连接问题、服务器异常等情况，出现的获取人脸信息失败。
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"获取人脸信息失败";
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:0.8];
        }
    }
}

//查询用户当前授权状态接口的回调方法，开发者根据如下情况进行不同操作
-(void)superID:(SuperID *)sender queryCurrentUserAuthorizationStateResponse:(SIDUserAuthorizationState)state{
    
    if (state == SIDUserHasAuth) {
        
        //当前用户Uid已授权APP
        
    }else if (state == SIDUserNoAuth){
        
        //当前用户Uid未授权绑定APP
        
    }else if (state == SIDQueryUserAuthorizationFail ){
        
        //查询用户Uid授权状态失败，如出现网络问题
    }
}


//更新应用的用户Uid一登账号中的回调方法
- (void)superID:(SuperID *)sender updateAppUserInfoStateResponse:(SIDUserUpdateResponseState)state{
    
    if (state == SIDUpdateUserInfoSucceed) {
        
        //更新用户应用账号信息操作成功
        
    }else if (state == SIDUpdateAppUserInfoFail){
        
        //更新用户应用账号信息操作失败，如出现网络问题
        
    }else if (state == SIDUserAccessExpired){
        
        //用户长时间不使用App，导致Token失效。出现概率低。出现该情况开发者可建议用户重新使用一登登录登录一次即可。
        
    }else if (state == SIDUserNoAuthToSuperID){
        
        //当前用户并为使用一登登录或者授权绑定一登账号，无法更新用户个人账号信息到一登账号中，出现该情况开发者可建议用户使用一登登录或一登授权绑定。
    }
}

//
-(void)superID:(SuperID *)sender updateAppUidResponse:(SIDUserUpdateResponseState)state{
    
    if (state == SIDUpdateAppUidSucceed) {
        
        //更新用户Uid操作成功
        
    }else if (state == SIDUidHasExist){
        
        //当前用户Uid已绑定其他一登账号。因此无法更新
        
    }else if (state == SIDUserNoAuthToSuperID){
        
        //当前用户并为使用一登登录或者授权绑定一登账号，无法更新Uid到一登账号中，出现该情况开发者可建议用户使用一登登录或一登授权绑定。
        
    }else if (state == SIDUserAccessExpired){
        
        //用户长时间不使用App，导致Token失效。出现概率低。出现该情况开发者可建议用户重新使用一登登录登录一次即可。
        
    }else if (state == SIDUpdateAppUidFail){
        
        //更新用户Uid操作失败，如出现网络问题
    }
}

#pragma mark - Notification
-(void)finshGetFaceFeatureNoPreviewMode:(NSNotification*)notification{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    faceFeatureListViewController *personView= [storyboard instantiateViewControllerWithIdentifier:@"faceFeatureList"];
    [self.navigationController pushViewController:personView animated:NO];
}

#pragma mark - UIAlertview delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1 && buttonIndex == 1) {

        //当app执行退出账号操作时，您需要执行以下方法，以清楚SuperID SDK内的缓存信息。
         [[SuperID sharedInstance]appUserLogoutCurrentAccount];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
