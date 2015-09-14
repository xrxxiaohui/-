//
//  AddressViewController.m
//  HersOutlet
//
//  Created by Lee xiaohui on 12-9-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AddressViewController.h"
#import "QuartzCore/QuartzCore.h"

//#import "ImageHelper.h"
@interface AddressViewController ()
@end

@implementation AddressViewController


- (void)dealloc {
    [m_webView release];
    [super dealloc];
}

-(void)showHeaderView:(NSString *)title{

    [self createNavWithTitle:title createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 2)
         {
             //左侧提问按钮
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             [btn setFrame:CGRectMake(10, self.navView.height - 35, 25, 25)];
             [btn setBackgroundImage:[UIImage imageNamed:@"returnPic"] forState:UIControlStateNormal];
             [btn setBackgroundImage:[UIImage imageNamed:@"returnPicLighted"] forState:UIControlStateHighlighted];
             [btn addTarget:self action:@selector(doReturn) forControlEvents:UIControlEventTouchUpInside];
             btn.showsTouchWhenHighlighted = YES;
             [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

             return btn;
         }
         return nil;
     }];
}


-(void)initWithUrl:(NSString *)addressUrl andTitle:(NSString *)tittleStr
{


    [self showHeaderView:tittleStr];
    
    NSURL *url = [[NSURL alloc] initWithString:addressUrl];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setTimeoutInterval:300];

    m_webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    m_webView.backgroundColor = [UIColor clearColor];
    m_webView.delegate = self;
    m_webView.tag = 1000000;
    
    [m_webView loadRequest:req];
    [m_webView setFrame:CGRectMake(0, 64, m_webView.frame.size.width, m_webView.frame.size.height-44)];
   
    [m_webView setScalesPageToFit:YES];
    [self.view addSubview: m_webView];
    [url release];
}

- (void)doReturn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupGestureRecognizers];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma --mark - 手势处理 返回上一级
-(void)setupGestureRecognizers{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureCallback:)];
    [pan setDelegate:self];
    [self.view addGestureRecognizer:pan];
    [pan release];
}

-(void)panGestureCallback:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self.view];
    //只是向右的50偏移，防止一碰触就返回的不良体验
    if (point.x > 50.0f) {
        [self ToReturn];
    }
}

-(void)ToReturn{
//    if(self.enterFromListPage){
//        self.navigationController.navigationBarHidden = YES;
//    }
    [self.navigationController popViewControllerAnimated:YES];

    //重载cookie,以免部分值域丢失
//    [super reloadStoredCookies];
}

@end
