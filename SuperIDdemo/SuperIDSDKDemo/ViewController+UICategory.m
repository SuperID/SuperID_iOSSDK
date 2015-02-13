//
//  ViewController+UICategory.m
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 3/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import "ViewController+UICategory.h"
#import "CONFIG.h"

@implementation ViewController (UICategory)

-(void)setupUIcomponent{
    
    [PubFunctions intialTextField:self.useraccount];
    [PubFunctions intialTextField:self.password];
    
    self.useraccount.placeholder=@"请输入账号";
    self.useraccount.text = @"some one";
    
    
    self.password.placeholder=@"请输入密码";
    self.password.text = @"1234567890";
    self.password.secureTextEntry = YES;
    
    
    self.confirmBtn.backgroundColor = superID_Demo_Theme;
    self.confirmBtn.clipsToBounds=YES;
    self.confirmBtn.layer.borderColor=[[UIColor clearColor]CGColor];
    self.confirmBtn.layer.borderWidth=0.5;
    self.confirmBtn.layer.cornerRadius = 4;
    self.confirmBtn.titleLabel.font= SuperID_Size_Font_Title;
    [self.confirmBtn.titleLabel setTextColor:superID_Demo_Font_White];
    
    
    [self.wechatBtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_binding_wechat_ico_disable"] forState:UIControlStateHighlighted];
    [self.wechatBtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_binding_wechat_ico_normal"] forState:UIControlStateNormal];
    self.wechatBtn.backgroundColor = [UIColor clearColor];
    
    [self.SuperIDBtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_binding_superid_ico_disable"] forState:UIControlStateHighlighted];
    [self.SuperIDBtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_binding_superid_ico_normal"] forState:UIControlStateNormal];
    self.SuperIDBtn.backgroundColor = [UIColor clearColor];
    
    [self.sinaBtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_binding_weibo_ico_disable"] forState:UIControlStateHighlighted];
    [self.sinaBtn setBackgroundImage:[UIImage imageNamed:@"superid_demo_binding_weibo_ico_normal"] forState:UIControlStateNormal];
    self.sinaBtn.backgroundColor = [UIColor clearColor];
    
    
    
}

@end
