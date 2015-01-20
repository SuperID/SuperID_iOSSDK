//
//  DemoLoginView.m
//  SuperIDsdk_Demo
//
//  Created by XU JUNJIE on 20/12/14.
//  Copyright (c) 2014 ISNC. All rights reserved.
//
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

#import "DemoLoginView.h"
#import "CONFIG.h"
#import "personalCenterView.h"
#import "SuperIDSDK.h"
#import "MBProgressHUD.h"

@interface DemoLoginView()<SuperIDSDKDelegate,UITextFieldDelegate>{
    
    SuperIDSDK *SDK;
    id SuperIDLoginView;

}
@end



//   若用户第一次使用SuperID通过点击登录View进行登录，完成登录后，当您获取到当前用户在您服务器的uid，调用此接口更新与SuperID绑定的uid，完成绑定操作。
//   [SDK updateAppUserUidToSuperIDAccount:@"xxxxxxxxx"];


@implementation DemoLoginView

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    if (IOS7_OR_LATER) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    
    SDK.delegate = self;
    
    self.view.backgroundColor = Superid_Demo_Artboard;
    self.navigationItem.title=@"一登Demo";
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = superID_Demo_Theme;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{ NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
        UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]}];
    
    useraccount.backgroundColor= [UIColor whiteColor];
    useraccount =[[UITextField alloc]initWithFrame:CGRectMake(0.05*VIEW_W(self.view), VIEW_H(self.view)*0.028, 0.9*VIEW_W(self.view),VIEW_H(self.view)*0.077)];
    useraccount = [self intialSuperidSdkTextField:useraccount];
    useraccount.placeholder=@"请输入账号";
    useraccount.text = @"some one";
    [self.view addSubview:useraccount];
    useraccount.delegate = self;
    
    password.backgroundColor= [UIColor whiteColor];
    password =[[UITextField alloc]initWithFrame:CGRectMake(0.05*VIEW_W(self.view), VIEW_BY(useraccount)+0.018*VIEW_H(self.view), 0.9*VIEW_W(self.view),VIEW_H(self.view)*0.077)];
    password = [self intialSuperidSdkTextField:password];
    password.placeholder=@"请输入密码";
    password.text = @"1234567890";
    password.secureTextEntry = YES;
    [self.view addSubview:password];
    password.delegate = self;
    
    UIButton *confirmBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.05*VIEW_W(self.view),VIEW_BY(password)+0.0423*VIEW_H(self.view), 0.9*VIEW_W(self.view), 0.0775*VIEW_H(self.view))];
                                                                   
    confirmBtn.backgroundColor = superID_Demo_Theme;
    confirmBtn.clipsToBounds=YES;
    confirmBtn.layer.borderColor=[[UIColor clearColor]CGColor];
    confirmBtn.layer.borderWidth=0.5;
    confirmBtn.layer.cornerRadius = 4;
    [confirmBtn setTitle: @"确定" forState: UIControlStateNormal];
    confirmBtn.titleLabel.font= SuperID_Size_Font_Title;
    [confirmBtn.titleLabel setTextColor:superID_Demo_Font_White];
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmBtnclickEventHandle)forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *confirmBtnRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignTextField)];
    [self.view addGestureRecognizer:confirmBtnRecognizer];
    UIImage *DisableImage=[self imageWithColor:common_Btn_Pressed size:CGSizeMake(VIEW_W(confirmBtn), VIEW_H(confirmBtn))];
    [confirmBtn setBackgroundImage:DisableImage forState:UIControlStateHighlighted];
    
    UIButton *wechatbtn = [[UIButton alloc]initWithFrame:CGRectMake(0.1254*VIEW_W(self.view), 0.6*VIEW_H(self.view), 0.15*VIEW_W(self.view), 0.15*VIEW_W(self.view))];
    [wechatbtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_binding_wechat_ico_disable"] forState:UIControlStateHighlighted];
    [wechatbtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_binding_wechat_ico_normal"] forState:UIControlStateNormal];
    wechatbtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:wechatbtn];
    
    UIButton *superIDbtn = [[UIButton alloc]initWithFrame:CGRectMake(VIEW_W(self.view)/2-0.075*VIEW_W(self.view), 0.6*VIEW_H(self.view), 0.15*VIEW_W(self.view), 0.15*VIEW_W(self.view))];
    [superIDbtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_binding_superid_ico_disable"] forState:UIControlStateHighlighted];
    [superIDbtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_binding_superid_ico_normal"] forState:UIControlStateNormal];
    superIDbtn.backgroundColor = [UIColor clearColor];
    [superIDbtn addTarget:self action:@selector(LoginWithSuperIDEventHandle)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:superIDbtn];
    
    UIButton *weiboBtn = [[UIButton alloc]initWithFrame:CGRectMake(VIEW_W(self.view)-VIEW_TX(wechatbtn)-VIEW_W(wechatbtn), 0.6*VIEW_H(self.view), 0.15*VIEW_W(self.view), 0.15*VIEW_W(self.view))];
    [weiboBtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_binding_weibo_ico_disable"] forState:UIControlStateHighlighted];
    [weiboBtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_binding_weibo_ico_normal"] forState:UIControlStateNormal];
    weiboBtn.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:weiboBtn];
    
    UIButton *clearBtn;
    if (isIphone4) {
        
        clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(VIEW_W(self.view)/2-0.375*VIEW_W(self.view)/2,VIEW_H(self.view)-0.053*VIEW_H(self.view)-24-64, 0.375*VIEW_W(self.view), 30)];
    }else{
        
        clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(VIEW_W(self.view)/2-0.375*VIEW_W(self.view)/2,VIEW_H(self.view)-0.053*VIEW_H(self.view)-24-64, 0.375*VIEW_W(self.view), 0.053*VIEW_H(self.view))];
    }
    
    [clearBtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_cleandate_btn_disable"] forState:UIControlStateHighlighted];
    [clearBtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_cleandate_btn_normal"] forState:UIControlStateNormal];
    clearBtn.backgroundColor = [UIColor clearColor];
    [clearBtn addTarget:self action:@selector(clearBtnEventHandle)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];

    
}



-(void)clearBtnEventHandle{

    NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];
    [userSettings removeObjectForKey:@"firstTimeUseSuperID"];
    [userSettings removeObjectForKey:@"appUserInfo"];
    [userSettings removeObjectForKey:@"defaultPhone"];
    [userSettings removeObjectForKey:@"appToken"];
    [userSettings removeObjectForKey:@"defaultRegion"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"清除成功";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
    
    [[SuperIDSDK sharedInstance]InitWithCredentialsAppID:@"OjMckn4xzHP1xdpf0uGJSgWj"
                                               AppSecret:@"OjMckn4xzHP1xdpf0uGJSasd"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    SDK = [SuperIDSDK sharedInstance];
    SDK.delegate = self;
}


-(void)LoginWithSuperIDEventHandle{

    NSError *error = nil;
   
    SuperIDLoginView=[SDK obtainSuperIDLoginView:&error];
    
    if (error) {
        
        NSLog(@"loginView Error =%ld,%@",[error code],[error localizedDescription]);
    }
    if (SuperIDLoginView) {
        
        [self presentViewController:SuperIDLoginView animated:YES completion:^(void){
        
        }];
    }
}

-(void)confirmBtnclickEventHandle{
 
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    personalCenterView *personView= [storyboard instantiateViewControllerWithIdentifier:@"personalcenter"];
    personView.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:personView animated:YES];
    
}

-(void)resignTextField{
    
    if ([password isFirstResponder]) {
        
        [password resignFirstResponder];
    }
    if ([useraccount isFirstResponder]) {
        
        [useraccount resignFirstResponder];
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([password isFirstResponder]) {
        
        [password resignFirstResponder];
    }
    if ([useraccount isFirstResponder]) {
        
        [useraccount resignFirstResponder];
    }
    return YES;
}
-(UITextField *)intialSuperidSdkTextField:(UITextField *)textField{
    
    textField.backgroundColor=[UIColor whiteColor];
    textField.keyboardAppearance=UIKeyboardAppearanceLight;
    textField.textColor=superID_Demo_Font_Title;
    textField.font=SuperID_Size_Font_Title;
    textField.textAlignment=NSTextAlignmentCenter;
    textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    textField.layer.cornerRadius = 4.0;
    textField.clipsToBounds = YES;
    textField.layer.borderWidth=0.5;
    textField.layer.borderColor=[superID_Demo_Border CGColor];
    
    return textField;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)userLoginWithSuperIDFail:(NSError *)error{
    
    
//    NSLog(@"%@",error);


}

-(void)userDidFinishLoginWithSuperID:(NSDictionary *)superIDUserInfo andAppUID:(NSString *)appUid{
    
        
        NSLog(@"superid SDK:userDidFinishLoginWithSuperID %@ %@",superIDUserInfo,appUid);
        NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];
        [userSettings setObject:superIDUserInfo forKey:@"appUserInfo"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        personalCenterView *personView= [storyboard instantiateViewControllerWithIdentifier:@"personalcenter"];
        personView.appUserInfo = superIDUserInfo;
        personView.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:personView animated:NO];

}



@end
