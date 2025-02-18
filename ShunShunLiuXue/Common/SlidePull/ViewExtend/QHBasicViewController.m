//
//  QHBasicViewController.m
//  helloworld
//
//  Created by chen on 14/6/30.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "QHBasicViewController.h"

@interface QHBasicViewController ()
{
    float _nSpaceNavY;
}

@end

@implementation QHBasicViewController

- (id)initWithFrame:(CGRect)frame param:(NSArray *)arParams
{
    self.arParams = arParams;
    
    self = [super init];
    
    [self.view setFrame:self.view.bounds];
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
//    [[self navigationController] setNavigationBarHidden:YES];
    
    [super viewWillAppear:TRUE];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA(236.f, 236.f, 236.f, 1);
    _statusBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 0.f)];
    _nSpaceNavY = 0;
    if (isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)
    {
        _statusBarView.frame = CGRectMake(_statusBarView.frame.origin.x, _statusBarView.frame.origin.y, _statusBarView.frame.size.width, 20.f);
        _statusBarView.backgroundColor = [UIColor clearColor];
//        ((UIImageView *)_statusBarView).backgroundColor = [UIColor clearColor];
        ((UIImageView *)_statusBarView).backgroundColor = COLOR(0xe6, 0x32, 0x14);
        [self.view addSubview:_statusBarView];
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        
        _nSpaceNavY = 0;
        
    }
}

- (void)createNavWithTitle:(NSString *)szTitle createMenuItem:(UIView *(^)(int nIndex))menuItem
{
    UIImageView *navIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, _nSpaceNavY, self.view.width, 64 - _nSpaceNavY)];
    navIV.tag = 98;
    [self.view addSubview:navIV];
    [self reloadImage];
    
    /* { 导航条 } */
    _navView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, StatusbarSize, kScreenWidth, 44.f)];
//    ((UIImageView *)_navView).backgroundColor = [UIColor clearColor];
     ((UIImageView *)_navView).backgroundColor = COLOR(0xe6, 0x32, 0x14);
    [self.view addSubview:_navView];
    _navView.userInteractionEnabled = YES;
    
    //设置标题
    UILabel *aTitleLabel = nil;
    aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenBounds.size.width/2-67,  (_navView.height - 40)/2, 120.0f, 40.0f)];
    aTitleLabel.text = szTitle;
    aTitleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    aTitleLabel.textAlignment = NSTextAlignmentCenter;
    aTitleLabel.backgroundColor = [UIColor clearColor];
    aTitleLabel.adjustsFontSizeToFitWidth = YES;
    aTitleLabel.textColor = [UIColor whiteColor];
    aTitleLabel.tag = 1022;
    [_navView addSubview:aTitleLabel];
//    [aTitleLabel release];
    
    [self.navigationItem setTitleView:_navView];
//    [navigationTopView release];

    
    UIView *item1 = menuItem(0);
    if (item1 != nil)
    {
        [_navView addSubview:item1];
    }
    UIView *item2 = menuItem(1);
    if (item2 != nil)
    {
        _rightV = item2;
        [_navView addSubview:item2];
    }
    UIView *item3 = menuItem(2);
    if (item3 != nil)
    {
        [_navView addSubview:item3];
    }
    UIView *item4 = menuItem(3);
    if (item4 != nil)
    {
        [_navView addSubview:item4];
    }
    UIView *item5 = menuItem(4);
    if (item5 != nil)
    {
        [_navView addSubview:item5];
    }
}

- (void)createAnswerNavWithTitle:(NSString *)szTitle createMenuItem:(UIView *(^)(int nIndex))menuItem
{
    UIImageView *navIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, _nSpaceNavY, self.view.width, 64 - _nSpaceNavY)];
    navIV.tag = 98;
    [self.view addSubview:navIV];
    [self reloadImage];
    
    /* { 导航条 } */
    _navView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, StatusbarSize, kScreenWidth, 44.f)];
    //    ((UIImageView *)_navView).backgroundColor = [UIColor clearColor];
    ((UIImageView *)_navView).backgroundColor = COLOR(0xe6, 0x32, 0x14);
    [self.view addSubview:_navView];
    _navView.userInteractionEnabled = YES;
    
    //设置标题
    UILabel *aTitleLabel = nil;
    aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,  (_navView.height - 40)/2, kScreenWidth-100, 40.0f)];
    aTitleLabel.text = szTitle;
    aTitleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    aTitleLabel.textAlignment = NSTextAlignmentCenter;
    aTitleLabel.backgroundColor = [UIColor clearColor];
//    aTitleLabel.adjustsFontSizeToFitWidth = YES;
    aTitleLabel.textColor = [UIColor whiteColor];
    aTitleLabel.tag = 1022;
    [_navView addSubview:aTitleLabel];
    //    [aTitleLabel release];
    
    [self.navigationItem setTitleView:_navView];
    //    [navigationTopView release];
    
    
    UIView *item1 = menuItem(0);
    if (item1 != nil)
    {
        [_navView addSubview:item1];
    }
    UIView *item2 = menuItem(1);
    if (item2 != nil)
    {
        _rightV = item2;
        [_navView addSubview:item2];
    }
    UIView *item3 = menuItem(2);
    if (item3 != nil)
    {
        [_navView addSubview:item3];
    }
    UIView *item4 = menuItem(3);
    if (item4 != nil)
    {
        [_navView addSubview:item4];
    }
    
    
}

- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerReloadImage:) name:RELOADIMAGE object:nil];
}

- (void)reloadImage
{
//    NSString *imageName = nil;
//    if (isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)
//    {
//        imageName = @"header_bg_ios7.png";
//    }else
//    {
//        imageName = @"header_bg.png";
//    }
//    UIImage *image = [QHCommonUtil imageNamed:imageName];
//    UIImageView *navIV = (UIImageView *)[self.view viewWithTag:98];
//    [navIV setImage:image];
}

- (void)observerReloadImage:(NSNotificationCenter *)notif
{
    [self reloadImage:notif];
}

- (void)reloadImage:(NSNotificationCenter *)notif
{
    [self reloadImage];
}

- (void)subReloadImage
{
    NSLog(@"subReloadImage");
}

@end
