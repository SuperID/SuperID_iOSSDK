//
//  HideModeFaceFeatureView.m
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 13/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import "HideModeFaceFeatureView.h"
#import "PubFunctions.h"
#import "CONFIG.h"

@implementation HideModeFaceFeatureView{
    
     MBProgressHUD *hud;
}


-(void)viewDidLoad{
    
    
    [self initFaceFeatureViewOfDuration:10.0f withFrameWith:320 andHight:320];
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *musicView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.435)];
    musicView.center = self.view.center;
    musicView.image = [UIImage imageNamed:@"music"];
    [self.view addSubview:musicView];

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

- (IBAction)startGetFaceFeature:(id)sender {
    
    [self startDetectFaceFeature];
    self.startFaceFeature.hidden = YES;
}

- (IBAction)dismissCurrentView:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//SDK已获取当前人脸，开始分析人脸信息
-(void)didFinishDetectFace{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在获取...";
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
}


//SDK成功完成人脸信息后的回调
-(void)getFaceFeatureNOPreviewSuccessWithfeatureData:(NSDictionary *)featureData{
    
    [hud show:NO];
    hud.hidden = YES;
    
    self.startFaceFeature.hidden = NO;
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"获取人脸信息成功";
    NSLog(@"emotiondata successful= %@",featureData);
   
    [hud showAnimated:YES whileExecutingBlock:^{
        
        sleep(1.5);
        
    } completionBlock:^{
        
        [hud removeFromSuperview];
        hud = nil;
        [hud hide:YES];
        
        if (featureData) {
            
            [[NSUserDefaults standardUserDefaults]setObject:[PubFunctions filterFaceFeaturesData:featureData] forKey:@"FaceFeature"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:GETFACEFEATURE object:GETFACEFEATUREDONE userInfo:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
   
}

//SDK获取人脸信息超时回调
-(void)finishGetUserEmotionAfterDuration{


    [hud show:NO];
    hud.hidden = YES;
    hud = nil;
    self.startFaceFeature.hidden = NO;
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"获取人脸信息失败";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
    
    NSLog(@"getEmotionNOPreviewFail over time");
}


//SDK后去人脸信息失败后的回调
-(void)getFaceFeatureNoPreviewFail:(NSError *)error{
    
    if ([error code] == -1016) {
        
        [hud show:NO];
        hud.hidden = YES;
        hud = nil;
        self.startFaceFeature.hidden = NO;
        
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"获取人脸信息失败";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
        NSLog(@"getEmotionNOPreviewFail");
        
    }else if ([error code] == -1007){
        
        [hud show:NO];
        hud.hidden = YES;
        hud = nil;
        self.startFaceFeature.hidden = NO;
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"帐号授权失效";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
        
    }else if ([error code]==-1015){
        
        [hud show:NO];
        hud.hidden = YES;
        hud = nil;
        self.startFaceFeature.hidden = NO;
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"当前帐号已被冻结";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
    }
}


@end
