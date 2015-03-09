/**
 * @file    SuperIDSDK.h
 * @author  XU Junjie
 * @version 20150308 V1.1
 * @date    2015-03-08
 *
 */


// SuperID SDK Language Mode:
typedef enum {
    
    autoMode = 0,
    simplified_Chinese,
    english,
    tradition_Chinese,
    
}languageType;

typedef enum {
    
    updateAppUserInfoSuccess = 0,
    updateAppUserInfoFail,
    userNoOAuthToSuperID,
    userAccessExpired,
    
}updateAppUserInfoState;

typedef enum {
    
    uidHasOAuth = 0,
    uidNoOAuth,
    checkUserOAuthFail,
    
}appUserUidAouthState;

typedef enum {
  
    uidUpdateSuccess = 0,
    uidHasExist,
    uidNoOAuthToSuperID,
    uidAccessExpired,
    uidUpdateFail,

}updateAppUserUidState;



#import <Foundation/Foundation.h>

/**
 *  SuperIDSDK Delegate Methods, including SuperID Login View protocol mothods, SuperID Aouth View protocol methods, user cancel aouth event handle protocol methods, face feature detection protocol methods, and network error protocol.
 */
@protocol SuperIDSDKDelegate<NSObject>


@optional

/**
 *  if user finish login with SuperID, this method will be implement.
 *
 *  @param userInfo the SuperID user Info, you can use this info as the basical information of current user in your app.
 *  @param appUid   the user's app indentifier of your application.
 */
-(void)userDidFinishLoginWithSuperID:(NSDictionary *)superIDUserInfo andAppUID:(NSString *)appUid;
-(void)userLoginWithSuperIDFail:(NSError *)error;

/**
 *  if user finish aouthrization to his SuperID account, this method will be implement.
 *
 *  @param superIDUserInfo the SuperID user Info, you can use this info as the basical information of current user in your app.
 *  @param appUid          the user's app indentifier of your application.
 */
-(void)userDidFinishOAuthAppWithSuperID:(NSDictionary *)superIDUserInfo andAppUID:(NSString *)appUid;
-(void)userOAuthAppWithSuperIDFail:(NSError *)error;

//SuperID cancel aouth operation Protocol methods, this will implement for inform the developer.
-(void)userCancelOAuthWithSuperIDSuccess;
-(void)userCancelOAuthWithSuperIDFail;

/**
 *  if the facefeature can be obtain successfully. this method will be implement.
 *
 *  @param featureData
 */
-(void)getSuperIDUserFaceFeatureSuccess:(NSDictionary *) featureData;
-(void)getSuperIDUserFaceFeatureFail:(NSError *)error;

-(void)appUserUidOAuthStateResponse:(appUserUidAouthState)aouthState;
-(void)updateUserAppInfoStateResponse:(updateAppUserInfoState)updateAppUserInfo;
-(void)updateUserAppUidResponse:(updateAppUserUidState)updateUid;

-(void)receieveNetWorkError;

@end


@interface SuperIDSDK : NSObject{
    
    id<SuperIDSDKDelegate> deleage;
    
}

@property(assign,nonatomic)id<SuperIDSDKDelegate> delegate;
@property(assign,nonatomic)NSString      *logEnable;

/**
 *  SuperIDSDK Singleton pattern
 *
 *  @return SuperIDSDK Object.
 */
+ (SuperIDSDK *)sharedInstance;

/**
 *  Configure the SDK with AppID and AppSecret
 *
 *  @param AppID
 *  @param AppSecret
 *
 *  @return SuperIDSDK Object.
 */
-(id)InitWithCredentialsAppID:(NSString *)AppID
                    AppSecret:(NSString *)AppSecret;


/**
 *  SuperIDSDK language mode: Auto-mode is the default mode(the SDK's language with auto switch with the system language).
 *
 *  @param type autoMode(the SDK's language with auto switch with the system language)，
                simplified_Chinese,
                english,
                tradition_Chinese,
 */
+(void)SuperIDSDKLanguageMode:(languageType)type;


/**
 *  Set SDK debugMode
 *
 *  @param debugMode if YES, the SDK will print the logInfo.
 */
-(void)SuperIDSDKDebugMode:(BOOL)debugMode;
/**
 *  obtain SuperID Login View if the SuperIDSDK has been init successfully.
 *
 *  @param error
 *
 *  @return SuperID LoginView object.
 */
-(id)obtainSuperIDLoginViewWithmobilePhone:(NSString *)mobilePhone
                                     error:(NSError **)error;


/**
 *  Check current user's aouthrized State. you should use this API to check the uid has aouthrized by SuperID before obtain SuperID AouthView
 *
 *  @param uid current user's user identifier.
 */
-(void)checkUserAuthorizationStateWithUid:(NSString *)uid;


/**
 *  obtian SuperID AouthView
 *
 *  @param uid         current app user id that will be binding with the SuperID account.
 *  @param mobilePhone current user's mobile phone number. if not, set nil.
 *  @param userInfo    the current user's infomation, for new SuperID User, the SDK will user that as the basical infomation for superID user before user edit the personal information. if not, set nil.
 *  @param error
 *
 *  @return SuperID AouthView object.
 */
-(id)obtainSuperIDOAuthViewWithAppUid:(NSString *)uid
                          MobliePhone:(NSString *)mobilePhone
                          userAppInfo:(NSDictionary *)userInfo
                                error:(NSError **)error;

/**
 *  Obtain SuperID FaceFeatureView
 *
 *  @param error
 *
 *  @return SuperID FaceFeatureView
 */
-(id)obtainSuperIDFaceFeatureViewWithPreview:(NSError **)error;


/**
 *  if current app uid has aouthrized by SuperID account, you can use this API to cancel the aouthrization.
 */
-(void)superIDUserCancelTheAuthorization;

/**
 *  when your app provide logout function for current user. you should add this method in the logout method. implement this method will not cancel the aouthrization between SuperID account and app's user account.
 */
-(void)logoutSuperIDAccountInApp;

/**
 *  if user login your app through the app login View, you need to obtain current user's uid in your app and using this API to finish the aouth process.
 *
 *  @param uid app user's indentifer in developer's application that will be binding with the SuperID account.
 */
-(void)updateAppUserUidToSuperIDAccount:(NSString *)uid;

/**
 *  once user has change their personal information in your application, you should using this API to update the user's information in your app to SuperID account.
 *
 *  @param userInfo
 */
-(void)updateAppUserInfoToSuperIDAccount:(NSDictionary *)userInfo;

/**
 *  currently, the facefeature function will not open to all developer, you can use this API to check whether your app can access to this function. For more details: please visit http://superid.me
 *
 *  @return BOOL Value
 */
-(BOOL)checkCurrentAppTokenCanAccessToFaceFeatureFunction;

/**
 *  temp functions for demo usage. in your project, you do not need to use this function. use -(void)checkUserAouthrizedStateWithUid:(NSString *)uid instead.
 *
 *  @return BOOL
 */
-(BOOL)isAppOAuth;

-(void)retryInitialSuperIDSDK;

/**
 *  user behaviours
 */

-(void)uploadUserBehavioursOfActionTag:(NSString *)tag attributes:(NSDictionary *)arrtributes actions:(NSDictionary *)actions;




@end
