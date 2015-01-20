//
//  personalCenterView.m
//  SuperIDsdk_Demo
//
//  Created by XU JUNJIE on 20/12/14.
//  Copyright (c) 2014 ISNC. All rights reserved.
//

#import "personalCenterView.h"
#import "CONFIG.h"
#import "cell1.h"
#import "faceFeatureView.h"
#import "SuperIDSDK.h"
#import "MBProgressHUD.h"
#import "faceFeatureView.h"
#import "FaceFeatureViewNoPre.h"

@interface personalCenterView()<UITableViewDataSource,UITableViewDelegate,SuperIDSDKDelegate,EmotionViewNoPreviewDelegate>{
    
    NSMutableArray  *BundingArray;
    UILabel         *userNameLable;
    UILabel         *phoneNumber;
    UIImageView     *avatarImageView;
    SuperIDSDK      *SDK;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *logout;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@end


//   当用户修改了app的个人资料以后，请调用此接口进行资料上传更新。
//    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
//
//    [userInfo setObject:@"xxxxx" forKey:@"name"];
//    [userInfo setObject:@"xxxx@gmail.com" forKey:@"email"];
//    [userInfo setObject:@"xxxxxxxxx" forKey:@"avatar"];
//
//    [SDK updateAppUserInfoToSuperIDAccount:userInfo];/**

@implementation personalCenterView

-(void)viewDidLoad{
    
    [super viewDidLoad];

    self.backgroundView.backgroundColor = Superid_Demo_Artboard;
    
    NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];
    self.appUserInfo=[userSettings objectForKey:@"appUserInfo"];

    SDK= [SuperIDSDK sharedInstance];
    
    BundingArray = [[NSMutableArray alloc]initWithObjects:@"点击绑定",@"点击绑定",@"点击绑定",@"点击体验",@"点击体验", nil];
    self.view.backgroundColor = Superid_Demo_Artboard;
    self.navigationItem.title=@"个人中心";

    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.borderWidth = 0.5f;
    self.backView.layer.borderColor =[superID_Demo_Border CGColor];
    
    avatarImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0.05*Screen_width,0.028*VIEW_H(self.view),0.15*Screen_width,0.15*Screen_width)];
    avatarImageView.backgroundColor = [UIColor grayColor];
    avatarImageView.layer.cornerRadius = VIEW_W(avatarImageView)/2;
    avatarImageView.clipsToBounds = YES;
    avatarImageView.layer.borderWidth=1.5;
    avatarImageView.layer.borderColor=[[UIColor clearColor]CGColor];
    avatarImageView.image = [UIImage imageNamed:@"superid_demo_avatar_img_default"];
    
    [self.backView addSubview:avatarImageView];
    
    userNameLable = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_BX(avatarImageView)+0.05*Screen_width, VIEW_BY(avatarImageView)-VIEW_H(avatarImageView)/2-12.5,Screen_width-VIEW_BX(avatarImageView)-0.05*Screen_width, 25)];
    userNameLable.font = SuperID_Size_Font_Title;
    userNameLable.textColor = superID_Demo_Font_Title;
    userNameLable.text = @"some one";
    
    [self.backView addSubview:userNameLable];
    
    UILabel *phoneTitle = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_TX(avatarImageView), VIEW_BY(avatarImageView)+0.053*Screen_height,VIEW_W(avatarImageView), 25)];
    phoneTitle.font = SuperID_Size_Font_Contant;
    phoneTitle.textColor = superID_Demo_Font_Title;
    phoneTitle.text = @"电话";
    phoneTitle.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:phoneTitle];
    
    phoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_TX(userNameLable), VIEW_TY(phoneTitle),VIEW_W(userNameLable), 25)];
    phoneNumber.font = SuperID_Size_Font_Contant;
    phoneNumber.textColor = superID_Demo_Font_Contant;
    phoneNumber.text = @"未填写";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.backView addSubview:phoneNumber];
    
   // self.tableView.frame = CGRectMake(0, VIEW_BY(backView), VIEW_W(self.tableView), VIEW_H(self.tableView));
    
    self.logout.clipsToBounds = YES;
    self.logout.layer.cornerRadius = 2;
    self.logout.backgroundColor = superID_Demo_Theme;
    
    self.tableView.scrollEnabled = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    SDK.delegate = self;
    
    if (self.appUserInfo) {
        
        if ([self.appUserInfo objectForKey:@"name"]) {
            
            userNameLable.text = [self.appUserInfo objectForKey:@"name"];
        }
        if ([self.appUserInfo objectForKey:@"phone"]) {
            
            if ([[self.appUserInfo objectForKey:@"phone"] isKindOfClass:[NSNumber class]]){
                
                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                NSLog(@"[self.appUserInfo objectForKey:phone] ==%@",[self.appUserInfo objectForKey:@"phone"]);
                phoneNumber.text =[numberFormatter stringFromNumber:[self.appUserInfo objectForKey:@"phone"]];
            }

            phoneNumber.text = [self.appUserInfo objectForKey:@"phone"];
            
        }
        if ([self.appUserInfo objectForKey:@"avatar"]) {
            
            NSString *avatarPath =[self.appUserInfo objectForKey:@"avatar"];
            if (avatarPath) {
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    // Download the avatar
                    [self downLoadUserAvatarWithURL:avatarPath];
                    //reflesh the UI
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSString *imageName = [NSString stringWithFormat:@"superIDavatar.jpg"];
                        UIImage *avatar= SANDBOXIMAGE(imageName);
                        
                        if (avatar!=nil) {
                            
                            avatarImageView.image = avatar;
                            
                        }else{
                            
                            avatarImageView.image = [UIImage imageNamed:@"superid_demo_avatar_img_default"];
                        }
                    });
                    
                });

            }

            
        }
    }

}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    

    
}

-(void)downLoadUserAvatarWithURL:(NSString *)AvatarURL{
    
    
    NSURL *netUrl = [NSURL URLWithString:AvatarURL];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:netUrl];
    NSError *err = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error:&err ];
    if (!err) {
        
        UIImage *image = [[UIImage alloc] initWithData:data];
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        NSString *imageDocPath = [NSHomeDirectory()  stringByAppendingPathComponent:@"Documents"];
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm createDirectoryAtPath:imageDocPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *imageName = [NSString stringWithFormat:@"superIDavatar.jpg"];
        NSString *profiePhotoPath = [imageDocPath stringByAppendingPathComponent:imageName];
        [fm removeItemAtPath:profiePhotoPath error:nil];
        [imageData writeToFile:profiePhotoPath atomically:NO];
    }
}

- (IBAction)logoutBtnEventHandle:(id)sender {
    
    //当app执行退出账号操作时，您需要执行以下方法，以清楚SuperID SDK内的缓存信息。
   // [[SuperIDSDK sharedInstance]logoutSuperIDAccountInApp];

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否退出当前账号" message:nil delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    alert.tag = 1;
    [alert show];
    self.appUserInfo = nil;

}

-(void)userCancelAouthWithSuperIDFail{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"解绑失败";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
    NSLog(@"SuperIDSDK:userCancelAouthWithSuperIDFail");
}

-(void)userCancelAouthWithSuperIDSuccess{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"解绑成功";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
    [self.tableView reloadData];
    NSLog(@"SuperIDSDK:userCancelAouthWithSuperIDSuccess");
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1 && buttonIndex == 1) {
        
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(BOOL)userIsAouth{

    //由于demo无法提供完善的三方账号体系作为流程演示，在使用授权接口是采用随机时间戳作为替代，因此在检测user 授权状态时，在demo内使用改接口 isAppAouth.
    return [[SuperIDSDK sharedInstance]isAppAouth];
    
    //在实际使用中，您应当使用如下接口：
    //-(void)checkUserAouthrizedStateWithUid:(NSString *)uid; 传入当前用户在您APP内的uid，检测该uid是否已经被SuperID账号授权。
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 3;
        
    }else{
        
        return 2;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 16;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell1 *cardcell= [self.tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
     cardcell.bundingText.textColor =superID_Demo_Theme;
    
    cardcell.nameLable.text = @"微信";
    if (indexPath.section == 0) {
        
        cardcell.bundingText.text = [BundingArray objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            
            cardcell.iconImg.image = [UIImage imageNamed:@"superid_demo_binding_wechat_ico_disable"];
            cardcell.nameLable.text = @"微信";
            
        }else if (indexPath.row == 1){
            
            
            cardcell.nameLable.text = @"一登";
            
            if ([self userIsAouth]) {
                
                cardcell.iconImg.image = [UIImage imageNamed:@"superid_demo_binding_superid_ico_normal"];
                cardcell.bundingText.text = @"解除绑定";
                cardcell.bundingText.textColor = superID_Demo_Font_Tips;
                
            }else{
                
                cardcell.iconImg.image = [UIImage imageNamed:@"superid_demo_binding_superid_ico_disable"];
            
            }
            
        }else if (indexPath.row == 2){
            
            cardcell.iconImg.image = [UIImage imageNamed:@"superid_demo_binding_weibo_ico_disable"];
            cardcell.nameLable.text = @"新浪微博";
            
        }
       
    }else if (indexPath.section ==1 ){
        
        cardcell.bundingText.text =@"点击体验";
            
            cardcell.iconImg.image = [UIImage imageNamed:@"superid_demo_faceinfo_weibo_ico_normal"];
        
        if (indexPath.row == 0) {
            
            cardcell.nameLable.text = @"人脸信息";
            //
        }else{
            
          cardcell.nameLable.text = @"人脸信息(隐藏版)";
        }
    }
    
    
    return cardcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
            
            if (![self userIsAouth]) {
                
                NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
                
                [userInfo setObject:@"xxxx" forKey:@"name"];
                [userInfo setObject:@"xxxxxx@xxxxx.com" forKey:@"email"];
                [userInfo setObject:@"xxxxxxxxxxxxxxxx" forKey:@"avatar"];
                NSDate *datenow = [NSDate date];
                NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
                
                NSError *error = nil;
                id SuperIDAouthView = [[SuperIDSDK sharedInstance]obtainSuperIDAouthViewWithAppUid:timeSp MobliePhone:nil userAppInfo:nil error:&error];
               // NSLog(@"error = %@",error);
                NSLog(@"loginView Error =%ld,%@",[error code],[error localizedDescription]);
                if (SuperIDAouthView) {
                    
                    [self presentViewController:SuperIDAouthView animated:YES completion:nil];
                }
                
            }else{

                [[SuperIDSDK sharedInstance] superIDUserCancelTheAuthorization];
            }
        }
    }
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            BOOL canAccessEmotionFunction = [[SuperIDSDK sharedInstance]checkCurrentAppTokenCanAccessToFaceFeatureFunction];
            
            if (canAccessEmotionFunction) {
                
                NSError *error = nil;
                id emotionView = [[SuperIDSDK sharedInstance]obtainSuperIDFaceFeatureViewWithPreview:nil];
                NSLog(@"loginView Error =%ld,%@",(long)[error code],[error localizedDescription]);
                if (emotionView) {
                    
                    [self presentViewController:emotionView animated:YES completion:nil];
                    
                }else{
                    
                    //授权过期或者用户已经解除绑定
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"请先绑定一登";
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:0.8];
                    
                }
            }else{
                
                NSLog(@"Current app cannot access to the emotion functions");
            }
        }
        
        if (indexPath.row == 1) {
            
            
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                FaceFeatureViewNoPre *faceFeatureView = [storyboard instantiateViewControllerWithIdentifier:@"emotionView"];

            faceFeatureView.delegate = self;
            [self presentViewController:faceFeatureView animated:YES completion:nil];
        }
    }
}

-(void)userDidFinishAouthAppWithSuperID:(NSDictionary *)superIDUserInfo andAppUID:(NSString *)appUid{
    
    self.appUserInfo = superIDUserInfo;
    [self.tableView reloadData];
     NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];
    [userSettings setObject:superIDUserInfo forKey: @"appUserInfo"];
    NSLog(@"superid SDK:userDidFinishAouthAppWithSuperID %@ %@",superIDUserInfo,appUid);
}

-(void)userAouthAppWithSuperIDFail:(NSError *)error{
    
    NSLog(@"aouth error = %@",error);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"绑定失败";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
    
    NSLog(@"superid SDK:userAouthAppWithSuperIDFail");
}

-(void)getSuperIDUserFaceFeatureSuccess:(NSDictionary *)featureData{
    
    if (featureData) {

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        faceFeatureView *faceFeatureView= [storyboard instantiateViewControllerWithIdentifier:@"faceFeature"];
        faceFeatureView.faceFeatureDitionary = featureData;
        [self.navigationController pushViewController:faceFeatureView animated:NO];
       
    }
   // [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)getSuperIDUserFaceFeatureFail{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"获取人脸信息失败";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
    NSLog(@"getSuperIDUserEmotionAndFaceFeatureFail");
}

-(void)userHasCancelAouthToCurrentAccount{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"请先绑定一登";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
    NSLog(@"getSuperIDUserEmotionAndFaceFeatureFail");
    
}


-(void)getEmotionNOPreviewFail{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"获取人脸信息失败";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
    
    NSLog(@"getEmotionNOPreviewFail");
}

-(void)getEmotionNOPreviewSuccessWithfeatureData:(NSDictionary *)featureData{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    faceFeatureView *faceFeatureView= [storyboard instantiateViewControllerWithIdentifier:@"faceFeature"];
    faceFeatureView.faceFeatureDitionary = featureData;
    [self.navigationController pushViewController:faceFeatureView animated:YES];
}

-(void)userNoAouthAccount{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"请先绑定一登";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
}

-(void)appUserUidAouthStateResponse:(appUserUidAouthState)aouthState{
    
    if (aouthState == UidHasAouth) {
        
        NSLog(@"current user has aouth this application");
        
    }else if (aouthState == UidNoAouth ){
        
        NSLog(@"current user has not aouth this application");
        
    }else if (aouthState == CheckUserAouthFail ){
        
        NSLog(@"check user uid of aouthrized state fail");
    }
}

-(void)updateUserAppInfoStateResponse:(updateAppUserInfoState)updateAppUserInfo{
    
    if (updateAppUserInfo == updateAppUserInfoSuccess) {
        
        NSLog(@"update current app user info success");
        
    }else if (updateAppUserInfo == updateAppUserInfoFail){
        
        NSLog(@"update current app user info fail");
        
    }else if (updateAppUserInfo == userAccessExpired){
        
        NSLog(@"app user's access has expired");
        
    }else if (updateAppUserInfo == userNoAouthToSuperID){
        
        NSLog(@"superID user dose not aouthrized to this user account");
    }
}

-(void)updateUserAppUidResponse:(updateAppUserUidState)updateUid{
    
    if (updateUid == uidUpdateSuccess) {
        
        NSLog(@"current user update uid to superid account successful");
        
    }else if (updateUid == uidHasExist){
        
        NSLog(@"current uid has aleady exist in superID account");
        
    }else if (updateUid == uidNoAouthToSuperID){
        
        NSLog(@"current user has not aouth to SuperID account, cannot update uid");
        
    }else if (updateUid == uidAccessExpired){
        
        NSLog(@"current user's access expired, cannot update uid");
        
    }else if (updateUid == uidUpdateFail){
        
        NSLog(@"uid update fail");
    }
}

-(void)receieveNetWorkError{
    
    NSLog(@"there are some network error happened!");
}

@end
