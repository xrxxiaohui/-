//
//  HomePageViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/10.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "HomePageViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super initNavBarItems:@"顺顺留学"];
    [super addButtonReturn:@"menuButton.png" lightedImage:@"menuButtonLighted.png" selector:@selector(toShowMenu)];

    self.view.backgroundColor = [UIColor redColor];
    UITabBarController *mainTabbarController = [[UITabBarController alloc] init];
    
    
    [mainTabbarController release];
    
    // Do any additional setup after loading the view.
}

//返回主页左侧栏
- (void)toShowMenu{
//    [MobClick event:@"left_menu_count"];
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
