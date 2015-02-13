//
//  ViewController.m
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 2/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import "ViewController.h"
#import "PubFunctions.h"
#import "SuperIDSDK.h"
#import "CONFIG.h"
#import "PersonalCenter.h"
#import "ViewController+UICategory.h"
#import "MBProgressHUD.h"


@interface ViewController ()<SuperIDSDKDelegate,UITextFieldDelegate>{
    
    SuperIDSDK  *SDK;                   //声明SuperID SDK 对象
    id          SuperIDLoginView;       //声明SuperIDLoginView
    
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

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    SDK = [SuperIDSDK sharedInstance];                          //获取SDK单例；
    [SuperIDSDK sharedInstance].delegate = self;                //设置SDK的委托对象
}

//采用Present方式弹出SuperIDLoginView:
- (IBAction)loginWithSuperID:(id)sender {
    
    NSError *error = nil;
    SuperIDLoginView=[SDK obtainSuperIDLoginViewWithmobilePhone:nil error:&error];
    
    if (SuperIDLoginView) {
        
        [self presentViewController:SuperIDLoginView animated:YES completion:nil];
        
    }else{
        
        NSLog(@"loginView Error =%ld,%@",(long)[error code],[error localizedDescription]);
    }
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



-(void)addClearCaCheBtnOnView{
    
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

#pragma mark SuperIDSDK delegate

-(void)userDidFinishLoginWithSuperID:(NSDictionary *)superIDUserInfo andAppUID:(NSString *)appUid{
    
    
    NSLog(@"superid SDK:userDidFinishLoginWithSuperID %@ %@",superIDUserInfo,appUid);
    [[NSUserDefaults standardUserDefaults] setObject:superIDUserInfo forKey:@"appUserInfo"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PersonalCenter *personView= [storyboard instantiateViewControllerWithIdentifier:@"personalCenter"];
    personView.appUserInfo = [[NSMutableDictionary alloc]initWithDictionary:superIDUserInfo];
    personView.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:personView animated:NO];
    
}

-(void)userLoginWithSuperIDFail:(NSError *)error{
    
    NSLog(@"loginView Error =%ld,%@",(long)[error code],[error localizedDescription]);
}


-(void)resignTextField{
    
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
