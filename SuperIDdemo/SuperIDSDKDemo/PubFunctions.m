//
//  PubFunctions.m
//  SuperIDSDKDemo
//
//  Created by XU JUNJIE on 2/2/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import "PubFunctions.h"
#import "CONFIG.h"
#import <Accelerate/Accelerate.h>

@implementation PubFunctions

/**
 *  隐藏多余表格线
 */
+ (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    
    view.frame = CGRectMake(0, 0, VIEW_W(tableView), 48);
    view.backgroundColor = [UIColor clearColor];
    [view.layer addSublayer:[self AddBorderLayer:Superid_Demo_Artboard withWidth:tableView.frame.size.width onY:-0.5f]];
    [tableView setTableFooterView:view];
}

+ (CALayer *)AddBorderLayer:(UIColor *)borderColor withWidth:(float)width onY:(float)pointY
{
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0.0f, pointY, width, 0.5f);
    border.backgroundColor = borderColor.CGColor;
    return border;
}

+ (void *)intialTextField:(UITextField *)textField{
    
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

    return nil;
}

+(NSDictionary *)filterFaceFeaturesData:(NSDictionary *)originalData{
    
    NSMutableDictionary *faceFeatureDitionary = [[NSMutableDictionary alloc]init];
    NSString *gender;
    NSDictionary *ageDict = [originalData objectForKey:@"male"];
    if ([[ageDict objectForKey:@"result"]  isEqualToNumber:@1]) {
        
        gender = @"男";
    }else{
        gender = @"女";
        
    }
    [faceFeatureDitionary setObject:gender forKey:GENDER];
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *age = [numberFormatter stringFromNumber:[originalData objectForKey:@"age"]];
    [faceFeatureDitionary setObject:age forKey:AGE];
    
//    NSDictionary *beautyDict =[originalData objectForKey:@"attractive"];
//    int beautyValue = (int)([[beautyDict objectForKey:@"score"] floatValue]*100);
//    NSString *beautyString=[NSString stringWithFormat:@"%d",beautyValue];
//    [faceFeatureDitionary setObject:beautyString forKey:BEAUTY];
    
    NSDictionary *glassDict = [originalData objectForKey:@"eyeglasses"];
    NSString *glassString;
    if ([[glassDict objectForKey:@"result"] isEqualToNumber:@1]) {
        
        glassString = @"有戴";
        
    }else{
        
        glassString = @"没戴";
    }
    [faceFeatureDitionary setObject:glassString forKey:GLASS];
    
    NSString *sunglassString;
    NSDictionary *sunglassDict = [originalData objectForKey:@"sunglasses"];
    if ([[sunglassDict objectForKey:@"result"]  isEqualToNumber: @1]) {
        
        sunglassString = @"有戴";
        
    }else{
        
        sunglassString = @"没戴";
        
    }
    [faceFeatureDitionary setObject:sunglassString forKey:SUNGLASS];
    
    NSDictionary *smailDict = [originalData objectForKey:@"smiling"];
    
    int smileValue = (int)([[smailDict objectForKey:@"score"] floatValue]*100);
    NSLog(@"smileValue = %d",smileValue);
    NSString *smileString = [NSString stringWithFormat:@"%d",smileValue];
    [faceFeatureDitionary setObject:smileString forKey:SMILE];
    
    NSDictionary *mustacheDict = [originalData objectForKey:@"mustache"];
    NSString *beardString = [NSString stringWithFormat:@"%.2f%%",[[mustacheDict objectForKey:@"score"] floatValue]*100];
    [faceFeatureDitionary setObject:beardString forKey:BEARD];
    
//    NSDictionary *mouthOpenDict = [originalData objectForKey:@"mouth_open"];
//    NSString *mouthOpenString = [NSString stringWithFormat:@"%.2f%%",[[mouthOpenDict objectForKey:@"score"] floatValue]*100];
//    [faceFeatureDitionary setObject:mouthOpenString forKey:MOUTHOPEN];
//    
//    NSDictionary *eyeCloseDict = [originalData objectForKey:@"blink"];
//    NSString *eyeCloseString = [NSString stringWithFormat:@"%.2f%%",[[eyeCloseDict objectForKey:@"score"] floatValue]*100];
//    [faceFeatureDitionary setObject:eyeCloseString forKey:EYECLOSE];
    
//    NSDictionary *emotion = [originalData objectForKey:@"emotions"];
//    NSArray *keys  =    [emotion allKeys];
//    NSArray *values =   [emotion allValues];
//    double maximumValues=0;
//    NSString *keyString = [[NSString alloc]init];
//    
//    for (int i = 0; i<[values count]; i++) {
//        
//        NSNumber *value = [values objectAtIndex:i];
//        double valueInt = [value doubleValue];
//        if (valueInt>maximumValues) {
//            
//            maximumValues=valueInt;
//            keyString = [keys objectAtIndex:i];
//            
//        }
//    }
//    NSMutableDictionary *emotionDitionary = [[NSMutableDictionary alloc]initWithObjects:@[@"愉快",@"愤怒",@"平静",@"惊讶",@"困惑",@"悲伤",@"恐惧"] forKeys:@[@"happy",@"angry",@"calm",@"surprised",@"confused",@"sad",@"disgust"]];
//    NSString *emotionTag = [emotionDitionary objectForKey:keyString];
//    NSString *emotionValue = [NSString stringWithFormat:@"(%.2f%%)",maximumValues*100];
//    NSLog(@"emotionTag = %@ emotionValue = %@",emotionTag,emotionValue);
//    [faceFeatureDitionary setObject:emotionTag forKey:EMOTION];
//    [faceFeatureDitionary setObject:emotionValue forKey:EMOTIONVALUE];
    
    return faceFeatureDitionary;
    
}

+ (NSString *)transformFeatureKeyToChinese:(NSString *)keyStr{
    
    NSString *str;
    
    if ([keyStr isEqualToString:@"age"]) {
        
        str = @"年龄";
        
    }else if ([keyStr isEqualToString:@"beard"]){
        
        str = @"胡须密度";
        
    }else if ([keyStr isEqualToString:@"gender"]){
        
        str = @"性别";
        
    }else if ([keyStr isEqualToString:@"glass"]){
        
        str = @"眼镜";
        
    }else if ([keyStr isEqualToString:@"smile"]){
        
        str = @"微笑值";
        
    }else if ([keyStr isEqualToString:@"sunGlass"]){
        
        str = @"太阳镜";
    }
    return str;
}


+ (void)setupLoginViewUIDisplay:(UIViewController *)vc{
    
    vc.view.backgroundColor = Superid_Demo_Artboard;
    vc.navigationItem.title=@"一登Demo";
    vc.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    vc.navigationController.navigationBar.barTintColor = superID_Demo_Theme;
    vc.navigationController.navigationBar.translucent = NO;
    [vc.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [vc.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    
    [vc.navigationController.navigationBar setTitleTextAttributes:
     @{ NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
        UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]}];
}

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if ((blur < 0.0f) || (blur > 1.0f)) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    
    if (error) {
        
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}


@end
