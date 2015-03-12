//
//  ViewController.m
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 2/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import "ViewController.h"
#import "PubFunctions.h"
#import "CONFIG.h"
#import "PersonalCenter.h"
#import "ViewController+UICategory.h"
#import "MBProgressHUD.h"
#import "SuperID.h"                              //声明一登头文件

/**
 *  声明一登的Delegate
 */
@interface ViewController ()<SuperIDDelegate,UITextFieldDelegate>{
    
    SuperID     *superIdSdk;                   //声明SuperID SDK 对象
    
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PubFunctions setupLoginViewUIDisplay:self];
    
    [self setupUIcomponent];
    [self addClearCaCheBtnOnView];
    
    self.useraccount.delegate = self;
    self.password.delegate = self;
    
    UITapGestureRecognizer *confirmBtnRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignTextField)];
    [self.view addGestureRecognizer:confirmBtnRecognizer];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //开发者应在viewWillAppear中设置SDK的委托对象，当应用从其他VC回来回到当前VC后，确保SDK的委托对象为当前VC。
    
    superIdSdk = [SuperID sharedInstance];            //获取SDK单例对象；
    superIdSdk.delegate = self;                       //设置SDK的委托对象
}

//采用Present方式弹出SuperIDLoginView:
- (IBAction)loginWithSuperID:(id)sender {
    
    NSError *error = nil;
    
    //获取一登登录VC
    id SIDLoginViewController = [superIdSdk obtainLoginViewControllerWithError:&error];
    
    if (SIDLoginViewController) {
        //开发者须采用present方式弹出一登登录VC
        [self presentViewController:SIDLoginViewController animated:YES completion:nil];
        
    }else{
        
        NSLog(@"loginView Error =%ld,%@",(long)[error code],[error localizedDescription]);
    }
}


- (void)addClearCaCheBtnOnView{
    
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


/**
 *  该清除缓存内容用户Demo演示时清楚缓存数据、应用Token来重新复位体验流程，开发者植入SDK时无需进行如下操作：
 */
- (void)clearBtnEventHandle{
    
    NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];
    [userSettings removeObjectForKey:@"firstTimeUseSuperID"];
    [userSettings removeObjectForKey:@"appUserInfo"];
    [userSettings removeObjectForKey:@"superIDDefaultPhone"];
    [userSettings removeObjectForKey:@"superIDAppToken"];
    [userSettings removeObjectForKey:@"superid_defaultRegion"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"清除成功";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
    
    [[SuperID sharedInstance]registerAppWithAppID:@"nnxEVFmKxMzxQJeV1RJ1BmMv" withAppSecret:@"Fx1D7DUmCbKqIvaLYv1c7MUP"];
    
}

#pragma mark SuperIDSDK delegate

- (void)superID:(SuperID *)sender userDidFinishLoginWithUserInfo:(NSDictionary *)userInfo withAppUid:(NSString *)uid error:(NSError *)error{
    
    
    if (!error) {
        
        //用户登录成功的执行内容
        [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"appUserInfo"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PersonalCenter *personView= [storyboard instantiateViewControllerWithIdentifier:@"personalCenter"];
        personView.appUserInfo = [[NSMutableDictionary alloc]initWithDictionary:userInfo];
        personView.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:personView animated:NO];
        
    }else{
        
        //用户登录失败的执行内容
        NSLog(@"loginView Error =%ld,%@",(long)[error code],[error localizedDescription]);
    }
}


- (void)resignTextField{
    
    if ([_password isFirstResponder]) {
        
        [_password resignFirstResponder];
    }
    if ([_useraccount isFirstResponder]) {
        
        [_useraccount resignFirstResponder];
    }
}

#pragma mark UITextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([_password isFirstResponder]) {
        
        [_password resignFirstResponder];
    }
    if ([_useraccount isFirstResponder]) {
        
        [_useraccount resignFirstResponder];
    }
    return YES;
}

- (IBAction)confirmBtnClickEventHandle:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PersonalCenter *personView= [storyboard instantiateViewControllerWithIdentifier:@"personalCenter"];
    personView.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:personView animated:YES];

}



@end
