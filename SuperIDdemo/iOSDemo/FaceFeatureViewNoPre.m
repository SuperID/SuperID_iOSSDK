//
//  FaceFeatureViewNoPre.m
//  SuperIDsdk_Demo
//
//  Created by XU JUNJIE on 24/12/14.
//  Copyright (c) 2014 ISNC. All rights reserved.
//

#import "FaceFeatureViewNoPre.h"


@interface FaceFeatureViewNoPre (){
    
    MBProgressHUD *hud;
}
@property (weak, nonatomic) IBOutlet UIButton *getEmotionBtn;

@end

@implementation FaceFeatureViewNoPre

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    [self initFaceFeatureViewWithoutPreviewInDuration];
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *musicView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.435)];
    musicView.center = self.view.center;
    musicView.image = [UIImage imageNamed:@"music"];
    
    [self.view addSubview:musicView];

}
- (IBAction)getEmotionClickEventHandle:(id)sender {
    
    [self startDetectFaceFeature];
     self.getEmotionBtn.hidden = YES;
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}

-(void)finishGetUserEmotionAfterDuration{
    
    if ([self.delegate respondsToSelector:@selector(getEmotionNOPreviewFail)]) {
        
        [self.delegate getEmotionNOPreviewFail];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)getFaceFeatureNOPreviewSuccessWithfeatureData:(NSDictionary *)featureData{
    
    [hud show:NO];
    hud.hidden = YES;
    
    self.getEmotionBtn.hidden = NO;
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"获取人脸信息成功";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
    NSLog(@"emotiondata successful= %@",featureData);
}

-(void)userHasCancelAouthWithCurrentAccount{

    [hud show:NO];
    hud.hidden = YES;
    self.getEmotionBtn.hidden = NO;
    if ([self.delegate respondsToSelector:@selector(userNoAouthAccount)]) {
        
       // [self.delegate userNoAouthAccount];
    }
    
    //[self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)endcurrentView:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)getFaceFeatureNoPreviewFail{
    
    [hud show:NO];
    hud.hidden = YES;
    hud = nil;
    self.getEmotionBtn.hidden = NO;
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"获取人脸信息失败";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
    
    NSLog(@"getEmotionNOPreviewFail");
}

-(void)userAouthrizehasExpired{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"授权已过期，请重新刷脸登录" message:nil delegate:self cancelButtonTitle: @"确定" otherButtonTitles:nil, nil];
    alertView.tag = 1;
    [alertView show];
}

-(void)didFinishDetectFace{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在获取...";
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
