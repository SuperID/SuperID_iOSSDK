//
//  FaceFeatureViewNoPre.h
//  SuperIDsdk_Demo
//
//  Created by XU JUNJIE on 24/12/14.
//  Copyright (c) 2014 ISNC. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SuperIDFaceFeatureViewClass.h"
#import "MBProgressHUD.h"

@protocol EmotionViewNoPreviewDelegate<NSObject>

@optional

-(void)getEmotionNOPreviewSuccessWithfeatureData:(NSDictionary *)featureData;
-(void)getEmotionNOPreviewFail;
-(void)userNoAouthAccount;

@end



@interface FaceFeatureViewNoPre:SuperIDFaceFeatureViewClass<EmotionViewNoPreviewDelegate>{
    
    id<EmotionViewNoPreviewDelegate> delegate;

}

@property(nonatomic, assign)id<EmotionViewNoPreviewDelegate> delegate;

@end
