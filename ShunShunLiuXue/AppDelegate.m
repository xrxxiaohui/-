//
//  AppDelegate.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/7.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "AppDelegate.h"
#import "SUNViewController.h"
#import "LeftViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import <AdSupport/ASIdentifierManager.h>
#import "UIDevice+IdentifierAddition.h"

static const CGFloat kPublicLeftMenuWidth = 280.0f;


@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)shareAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
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
    
    //创建主视图
    [self createMainView];
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

//创建主视图和左视图
- (void)createMainView{
    // 创建了主视图和左视图 设置宽度 响应手势
    if (![self.window.rootViewController isKindOfClass:[SUNViewController class]]) {
        LeftViewController *leftVC = [[LeftViewController alloc] init];
        SUNViewController * drawerController = [[SUNViewController alloc]
                                                initWithCenterViewController:leftVC.homeSwitchVC
                                                leftDrawerViewController:leftVC
                                                rightDrawerViewController:nil];
        [drawerController setMaximumLeftDrawerWidth:kPublicLeftMenuWidth];
        [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
            MMDrawerControllerDrawerVisualStateBlock block;
            block = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
            block(drawerController, drawerSide, percentVisible);
        }];
        
        [leftVC release];
        
        [self.window setRootViewController:drawerController];
        [self.window makeKeyAndVisible];
    }else{
        
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
