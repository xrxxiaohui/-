//
//  MessageViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/15.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController (){

    UIButton *shareButton;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showHeaderView:@""];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showHeaderView:(NSString *)tempStr{
    
    [self createNavWithTitle: @"我的消息" createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 1)
         {
             //右侧消息按钮
             shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
             [shareButton setFrame:CGRectMake(self.navView.width - 40, self.navView.height - 35, 25, 25)];
             [shareButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
             [shareButton setBackgroundImage:[UIImage imageNamed:@"shareLighted"] forState:UIControlStateHighlighted];
             //             [shareButton setTitle:@"分享" forState:UIControlStateNormal];
             [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             [shareButton addTarget:self action:@selector(shareQuestion:) forControlEvents:UIControlEventTouchUpInside];
             shareButton.showsTouchWhenHighlighted = YES;
             
             
             return shareButton;
         }else  if (nIndex == 2)
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
         }else  if (nIndex == 3)
         {
             //搜索按钮
             //             UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
             //             [searchButton setFrame:CGRectMake((kScreenWidth-188)/2, self.navView.height - 38, 188, 28)];
             //             [searchButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
             //             //             [searchButton setBackgroundImage:[UIImage imageNamed:@"askQuestionButtonLighted"] forState:UIControlStateHighlighted];
             //             [searchButton addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
             //             searchButton.showsTouchWhenHighlighted = YES;
             //             [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             //
             //             return searchButton;
         }
         
         return nil;
     }];
}

-(void)shareQuestion:(id)sender{
    
    
}

-(void)returnBack{
    
    [self.navigationController popViewControllerAnimated:YES];
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
