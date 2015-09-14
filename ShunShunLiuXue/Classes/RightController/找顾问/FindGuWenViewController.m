//
//  FindGuWenViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/11.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "FindGuWenViewController.h"
#import "LoginViewController.h"

@interface FindGuWenViewController ()

@end

@implementation FindGuWenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavWithTitle:@"找顾问" createMenuItem:^UIView *(int nIndex)
     {
//         if (nIndex == 1)
//         {
//             UIButton *mentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
//             //            UIImage *i = [UIImage imageNamed:@"group_right_btn.png"];
//             //            [btn setImage:i forState:UIControlStateNormal];
//             //            [btn setFrame:CGRectMake(self.navView.width - i.size.width - 10, (self.navView.height - i.size.height)/2, i.size.width, i.size.height)];
//             [mentionButton setFrame:CGRectMake(self.navView.width - 60, (self.navView.height - 40)/2, 60, 40)];
//             [mentionButton setTitle:@"提醒" forState:UIControlStateNormal];
//             [mentionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//             
//             return mentionButton;
//         }else
         if (nIndex == 2)
         {
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             //            UIImage *i = [UIImage imageNamed:@"group_right_btn.png"];
             //            [btn setImage:i forState:UIControlStateNormal];
             //            [btn setFrame:CGRectMake(self.navView.width - i.size.width - 10, (self.navView.height - i.size.height)/2, i.size.width, i.size.height)];
             [btn setFrame:CGRectMake(10, (self.navView.height - 40)/2, 45, 45)];
             [btn setBackgroundImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
             [btn setBackgroundImage:[UIImage imageNamed:@"menuButtonLighted"] forState:UIControlStateHighlighted];
             [btn addTarget:self action:@selector(toShowMenu) forControlEvents:UIControlEventTouchUpInside];
             [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             
             return btn;
         }
         
         return nil;
     }];

    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setBackgroundColor:[UIColor greenColor]];
    [loginButton setFrame:CGRectMake(50, 100, 80, 80)];
    [loginButton setTitle:@"去登录" forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    [loginButton addTarget:self action:@selector(toLoginPage) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

//登录
-(void)toLoginPage{

//    LoginViewController *loginViewController = [[LoginViewController alloc] init];
//    [self presentViewController:loginViewController animated:YES completion:nil];
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
//    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
//    [[SliderViewController sharedSliderController].navigationController presentViewController:loginNav animated:YES completion:^{
//        
//    }];
    [[SliderViewController sharedSliderController].navigationController pushViewController:loginViewController animated:YES];
}

//返回主页左侧栏
- (void)toShowMenu{
    //    [MobClick event:@"left_menu_count"];
    //[self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    [[SliderViewController sharedSliderController] showLeftViewController];
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
