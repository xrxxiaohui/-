//
//  MyAnswerViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/9/8.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "MyAnswerViewController.h"
#import "XueYouViewController.h"
#import "WenTiViewController.h"
#import "HuaTiViewController.h"

@interface MyAnswerViewController ()

@end

@implementation MyAnswerViewController
@synthesize slideSwitchView;
@synthesize controllerArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showHeaderView];
    self.controllerArray = [NSMutableArray arrayWithCapacity:1];
    self.slideSwitchView = [[SUNSlideSwitchView alloc] init];
    self.slideSwitchView.slideSwitchViewDelegate = self;
    [slideSwitchView setFrame:CGRectMake(0, 64, kScreenBounds.size.width, kScreenBounds.size.height)];
    
    [self.view addSubview:self.slideSwitchView];
    //    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"ff0000"];
    self.slideSwitchView.tabItemNormalColor = [UIColor whiteColor];
    
    UIImage *tempImage = [self imageWithColor:[UIColor whiteColor] size:CGSizeMake(98, 2)];
    self.slideSwitchView.shadowImage = [tempImage
                                        stretchableImageWithLeftCapWidth:98.0f topCapHeight:13.0f];
    AnswerSortByTimeViewController *xueYouViewController = [[AnswerSortByTimeViewController alloc] init];
    AnswerSortByZanViewController *wenTiViewController = [[AnswerSortByZanViewController alloc] init];
    
    [self.controllerArray addObject:xueYouViewController];
    //    [self.controllerArray addObject:guWenViewController];
    [self.controllerArray addObject:wenTiViewController];

    UIImageView *lineImage = [[UIImageView alloc] init];
    [lineImage setFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    [lineImage setBackgroundColor:COLOR(0xd4, 0x2d, 0x10)];
    [slideSwitchView addSubview:lineImage];
    [lineImage release];
    
    [self.slideSwitchView buildUI];

}
-(void)showHeaderView{
    
    [self createNavWithTitle:@"我的回答" createMenuItem:^UIView *(int nIndex)
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

#pragma mark - 滑动tab视图代理方法

- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 2;
}

- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if([self.controllerArray count]>0)
        return [self.controllerArray objectAtIndex:number];
    //    if (number == 0) {
    //        return self.newestViewController;
    //    }else if (number == 1) {
    
    //        return self.meiZhuangViewController;
    //    }else if (number == 2) {
    //        return self.xiuViewController;
    //    }else if (number == 3) {
    //        return self.cheDanViewController;
    //    }else if (number == 4) {
    //        return self.hottestViewController;
    //    } else {
    //        return nil;
    //    }
    return nil;
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer *)panParam
{
    //    if(![[ConstObject instance] isLogin])
    //        return;
    //    SUNViewController *drawerController = (SUNViewController *)self.navigationController.mm_drawerController;
    //    [drawerController panGestureCallback:panParam];
}

- (void)tabMenuButton{
    
    //    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number{
    if([self.controllerArray count]>0)
    {
        UIViewController *temp = [self.controllerArray objectAtIndex:number];
        [temp viewWillAppear:YES];
    }
    //    if (number == 0) {
    
    //        [self.newestViewController viewWillAppear:YES];
    //    } else if (number == 1) {
    //        [self.meiZhuangViewController viewWillAppear:YES];
    //    }else if (number == 2) {
    //        [self.xiuViewController viewWillAppear:YES];
    //    }else if (number == 3) {
    //        [self.cheDanViewController viewWillAppear:YES];
    //    } else if (number == 4) {
    //        [self.hottestViewController viewWillAppear:YES];
    //    }
}

-(void)returnBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
