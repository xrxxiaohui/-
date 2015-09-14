//
//  MyMessageViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/9/8.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "MyMessageViewController.h"

@interface MyMessageViewController ()

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showHeaderView];
}
-(void)showHeaderView{
    
    [self createNavWithTitle:@"我的消息" createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 2)
         {
             //左侧提问按钮
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             [btn setFrame:CGRectMake(10, self.navView.height - 35, 25, 25)];
             [btn setBackgroundImage:[UIImage imageNamed:@"returnPic"] forState:UIControlStateNormal];
             [btn setBackgroundImage:[UIImage imageNamed:@"returnPicLighted"] forState:UIControlStateHighlighted];
             [btn addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
             btn.showsTouchWhenHighlighted = YES;
             [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             
             return btn;
         }
         return nil;
     }];
}

-(void)returnBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
