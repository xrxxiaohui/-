//
//  HomePageViewController.m
//  IMApp
//
//  Created by chen on 14/7/20.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "MainTabViewController.h"

#import "HomePageViewController.h"
#import "SheQuViewController.h"
#import "FindGuWenViewController.h"
#import "ZiXunViewController.h"
//#import "MineViewController.h"

@interface MainTabViewController ()
{
    UITabBarController *_tabController;
}

@end

@implementation MainTabViewController

static MainTabViewController *main;

+ (MainTabViewController *)getMain
{
    return main;
}

- (id)init
{
    self = [super init];
    
    main = self;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6){
        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    }
    
    [_tabController.tabBar setClipsToBounds:YES];
    [self addObserver];
    
    _tabController = [[UITabBarController alloc] init];
    [_tabController.tabBar setBackgroundColor:[UIColor whiteColor]];
    [_tabController.view setFrame:self.view.frame];
//    [self.view addSubview:_tabController.view];
    
//    HomePageViewController *homePageViewController = [[HomePageViewController alloc] init];
    SheQuViewController *sheQuViewController = [[SheQuViewController alloc] init];
     [self.view addSubview:sheQuViewController.view];
//    ZiXunViewController *ziXunViewController = [[ZiXunViewController alloc] init];
    FindGuWenViewController *findGuWenViewController= [[FindGuWenViewController alloc] init];
    
//    MineViewController *ff = [[MineViewController alloc] init];
//    UITabBarItem *ffItem = [[UITabBarItem alloc]initWithTitle:@"svip" image:nil tag:1];
//    [ffItem setImage:[UIImage imageNamed:@"tab_me_svip_nor.png"]];
//    [ffItem setSelectedImage:[UIImage imageNamed:@"tab_me_svip_press.png"]];
//    ff.tabBarItem = ffItem;
    
    _tabController.viewControllers = @[ sheQuViewController,findGuWenViewController];
    
    [self reloadImage];
//    [[UITabBarItem appearance] setTitleTextAttributes:
//        [NSDictionary dictionaryWithObjectsAndKeys:RGBA(96, 164, 222, 1), UITextAttributeTextColor, nil]
//                                             forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:
//        [NSDictionary dictionaryWithObjectsAndKeys:RGBA(96, 164, 222, 1), UITextAttributeTextColor, nil]
//                                             forState:UIControlStateSelected];
//    [_tabC.tabBar setTintColor:RGBA(96, 164, 222, 1)];
    [_tabController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBottom"]];
    _tabController.tabBar.translucent = YES;
    [_tabController.tabBar setAlpha:0.94];
    [_tabController setSelectedIndex:0];
}

- (void)reloadImage
{
    [super reloadImage];
    
//    NSString *imageName = nil;
//    if (isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1 && [QHConfiguredObj defaultConfigure].nThemeIndex != 0)
//    {
//        imageName = @"tabbar_bg_ios7.png";
//    }else
//    {
//        imageName = @"tabbar_bg.png";
//    }
//    [_tabController.tabBar setBackgroundImage:[QHCommonUtil imageNamed:imageName]];
    
  //  UIImage *tempImage = [self imageWithColor:[UIColor whiteColor] size:CGSizeMake(_tabController.tabBar.width, _tabController.tabBar.height)];
    [_tabController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBottom"]];
//    _tabController.tabBar.translucent = YES;
//    [_tabController.tabBar setBackgroundColor:[UIColor redColor]];
    [_tabController.tabBar setAlpha:0.94];
    
    NSArray *ar = _tabController.viewControllers;
    NSMutableArray *arD = [NSMutableArray new];
    [ar enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop)
    {
//        UITabBarItem *item = viewController.tabBarItem;
        UITabBarItem *item = nil;
        switch (idx)
        {
            case 0:
            {
                item = [[UITabBarItem alloc] initWithTitle:@"" image:[[QHCommonUtil imageNamed:@"tab_recent_nor.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[QHCommonUtil imageNamed:@"tab_recent_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                break;
            }
            case 1:
            {
                item = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:1];
                [item setImage:[[QHCommonUtil imageNamed:@"tab_buddy_nor.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[QHCommonUtil imageNamed:@"tab_buddy_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                break;
            }
//            case 2:
//            {
//                item = [[UITabBarItem alloc]initWithTitle:@"资讯" image:nil tag:1];
//                [item setImage:[[QHCommonUtil imageNamed:@"tab_qworld_nor.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//                [item setSelectedImage:[[QHCommonUtil imageNamed:@"tab_qworld_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//                break;
//            }
//            case 2:
//            {
//                item = [[UITabBarItem alloc]initWithTitle:@"找顾问" image:nil tag:1];
//                [item setImage:[[QHCommonUtil imageNamed:@"tab_buddy_nor.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//                [item setSelectedImage:[[QHCommonUtil imageNamed:@"tab_buddy_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//                break;
//            }

        }
        viewController.tabBarItem = item;
        [arD addObject:viewController];
    }];
    _tabController.viewControllers = arD;
}

@end
