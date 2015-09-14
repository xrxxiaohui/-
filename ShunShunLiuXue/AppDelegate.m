//
//  AppDelegate.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/7.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "AppDelegate.h"
//#import "SUNViewController.h"
#import "LeftViewController.h"
//#import "MMDrawerController.h"
//#import "MMDrawerVisualState.h"
#import <AdSupport/ASIdentifierManager.h>
#import "UIDevice+IdentifierAddition.h"
#import "SliderViewController.h"
#import "LeftViewController.h"
//#import "HomePageViewController.h"
//#import "MainTabViewController.h"
#import "MLBlackTransition.h"
#import "ConstObject.h"
#import <ShareSDK/ShareSDK.h>
#import "SheQuViewController.h"

//static const CGFloat kPublicLeftMenuWidth = kScreenWidth-220;


@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)shareAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
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

//创建主视图和左视图
- (void)createMainView{
    // 创建了主视图和左视图 设置宽度 响应手势
//    if (![self.window.rootViewController isKindOfClass:[SUNViewController class]]) {
//        LeftViewController *leftVC = [[LeftViewController alloc] init];
//        SUNViewController * drawerController = [[SUNViewController alloc]
//                                                initWithCenterViewController:leftVC.homeSwitchVC
//                                                leftDrawerViewController:leftVC
//                                                rightDrawerViewController:nil];
//        [drawerController setMaximumLeftDrawerWidth:kPublicLeftMenuWidth];
//        [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//        [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
//        [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
//            MMDrawerControllerDrawerVisualStateBlock block;
//            block = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
//            block(drawerController, drawerSide, percentVisible);
//        }];
    
//        [leftVC release];
//        
//        [self.window setRootViewController:drawerController];
//        [self.window makeKeyAndVisible];
//    }else{
//        
//    }
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    [SliderViewController sharedSliderController].LeftVC = leftVC;
//    [SliderViewController sharedSliderController].MainVC = [[MainTabViewController alloc] init];
    [SliderViewController sharedSliderController].MainVC = [[SheQuViewController alloc] init];;
    [SliderViewController sharedSliderController].LeftSContentOffset=245;
    [SliderViewController sharedSliderController].LeftContentViewSContentOffset = 50;
    [SliderViewController sharedSliderController].LeftSContentScale=1;//缩放
    [SliderViewController sharedSliderController].LeftSJudgeOffset=100;
    [SliderViewController sharedSliderController].changeLeftView = ^(CGFloat sca, CGFloat transX)
    {
        //        leftVC.contentView.layer.anchorPoint = CGPointMake(1, 1);
        CGAffineTransform ltransS = CGAffineTransformMakeScale(sca, sca);
        CGAffineTransform ltransT = CGAffineTransformMakeTranslation(transX, 0);
        CGAffineTransform lconT = CGAffineTransformConcat(ltransT, ltransS);
        leftVC.contentView.transform = lconT;
    };
    
    //    [UIViewController validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypePan];
    //手势返回更新为MLBlackTransition
    [MLBlackTransition validatePanPackWithMLBlackTransitionGestureRecognizerType:MLBlackTransitionGestureRecognizerTypePan];
    
    UINavigationController *naviC = [[UINavigationController alloc] initWithRootViewController:[SliderViewController sharedSliderController]];
    [[ConstObject instance] setMainNavigationController:naviC];
    self.window.rootViewController = naviC;
    
    [self.window makeKeyAndVisible];

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
