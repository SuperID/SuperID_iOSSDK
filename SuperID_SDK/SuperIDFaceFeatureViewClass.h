//
//  SuperIDEmotionNoPreView.h
//  SuperIDSDK
//
//  Created by XU JUNJIE on 24/12/14.
//  Copyright (c) 2014 ISNC. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface SuperIDFaceFeatureViewClass : UIViewController

/**
 *  1.if current app cannot access to the emotion funciton, you will get a NO bool value, and the initial step cannot be finish.
 *  2.if your application cannot access to the network after app launch. the initial SDK work cannot be done, you also will receieve a NO bool value.
 *  3.if your app can access to the emotion function, and you got a NO bool value, that means the user has not aouth this application access to the camera. you can present a alertView to guide the user to oauth this application after receive the NO bool value.
 *
 *  @return BOOL Value;
 */
-(BOOL)initFaceFeatureViewOfDuration:(float)duration withFrameWith:(float)width andHight:(float)hight;

//you can use this methods to start the face feature detection function, it will insist 30s. in this 30s, if the detection event has finished, sdk will inform developers to handle the event. if this event is time out after 30s, the event will auto stop and infom the developers current detection is fail.
-(void)startDetectFaceFeature;


-(void)stopDetectFaceFeature;

/**
 *  the process of get face feature is seperated into two part. the first part is detect user's face before analysis the face infomation. once the SDK has detected user's face in the camera stream. this method will be called to inform the developers. you can update the UI state when this method is implement.
 */
-(void)didFinishDetectFace;

/**
 *  get face feature successfully will implement this method.
 *
 *  @param featureData you can get the user's face feature according to the key value in json format data.
 */
-(void)getFaceFeatureNOPreviewSuccessWithfeatureData:(NSDictionary *)featureData;

/**
 *  get user's face feature fail, it may cause by network error, cannot detect face feature, etc.
 */
-(void)getFaceFeatureNoPreviewFail:(NSError *)error;

-(id)getCurrentPreviewLayer;

@end
