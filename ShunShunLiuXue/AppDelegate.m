//
//  AppDelegate.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/7.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "AppDelegate.h"

#import <AdSupport/ASIdentifierManager.h>
#import "UIDevice+IdentifierAddition.h"
#import "ConstObject.h"
#import <ShareSDK/ShareSDK.h>
#import "SheQuViewController.h"
#import "UIWindow+Extension.h"

//static const CGFloat kPublicLeftMenuWidth = kScreenWidth-220;


@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)shareAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //获取用户地理位置
    [self gatherUserLocationInformationAndUdid];
    
    //根据uid来获取登陆状态
    NSString *anUid = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"loginUid"]];
    if (![anUid isEqualToString:@"(null)"]) {
        [[ConstObject instance] setIsLogin:YES];
    }
    else{
        [[ConstObject instance] setIsLogin:NO];
    }

    // 通过版本切换引导页主页
    [self.window switchRootViewController];
    //注册推送服务
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound| UIRemoteNotificationTypeAlert)];
    // IOS8 新系统需要使用新的代码咯
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        //这里还是原来的代码
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    [ShareSDK registerApp:@"9af115514064"];

    
//    //登录成功，注册token消息
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(registerToken)
//                                                 name:kRegisterPushNotification
//                                               object:nil];

    return YES;
}

////获取设别唯一标识
//- (NSString *)getDeviceIdentifier{
//    NSString *deviceIdentify = nil;
//    if (kSystemIsAboveIOS6) {
//        deviceIdentify = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    }
//    else{
//        deviceIdentify = [[UIDevice currentDevice]  uniqueDeviceIdentifier];
//    }
//    NSLog(@"deviceIdentify===%@",deviceIdentify);
//    return deviceIdentify;
//}

//获取当前登录uid
- (NSString *)readUid{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"loginUid"];
}

//获取用户地理位置和UDID
- (void)gatherUserLocationInformationAndUdid{
    if ([CLLocationManager locationServicesEnabled]) {
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 500000;
        [locationManager startUpdatingLocation];
    }else{
        NSLog(@"系统定位服务未开启！！！");
    }
}


- (BOOL)application: (UIApplication *)application  handleOpenURL: (NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application: (UIApplication *)application
            openURL: (NSURL *)url
  sourceApplication: (NSString *)sourceApplication
         annotation: (id)annotation
{
    return [ShareSDK handleOpenURL: url
                 sourceApplication:sourceApplication
                        annotation: annotation
                        wxDelegate: self];
}



@end
