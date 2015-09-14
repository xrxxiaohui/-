//
//  UITempletViewController.m
//  ChuanDaZhi
//
//  Created by hers on 13-6-5.
//  Copyright (c) 2013年 hers. All rights reserved.
//
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
//#import "CustomNavigationBar.h"
#include "QuartzCore/QuartzCore.h"
#import <AdSupport/ASIdentifierManager.h>
#import "UITempletViewController.h"
#import "UIDevice+IdentifierAddition.h"
#import "LoginViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface UITempletViewController ()

@end

@implementation UITempletViewController

@synthesize returnbutton,rightBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        commonModel = [[CommonModel alloc] initWithTarget:self];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    if (self.navigationItem.hidesBackButton == NO) {
//        [self.navigationItem setHidesBackButton:YES animated:NO];
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationItem setHidesBackButton:YES animated:NO];
    //设置导航背景图片
    if (kSystemIsIOS7) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header_bg_ios7"] forBarMetrics:UIBarMetricsDefault];
    }
    else{
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topBarBg6.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        // 首先要判断版本号，否则在iOS 6 以下的版本会闪退  为了个人中心上部分一体 去除掉上导航毛边效果
        self.navigationController.navigationBar.shadowImage = [[[UIImage alloc] init] autorelease];
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(showLoginSucceedTips)
//                                                 name:kShowLoginSucceedTips
//                                               object:nil];
    
    
}

#pragma --mark Functions
- (void)hideNavBarItems{
    self.navigationController.navigationBarHidden = YES;
}

- (void)noHideNavBarItems{
    self.navigationController.navigationBarHidden = NO;
}

- (void)initNavBarItems:(NSString *)titlename{
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    if (!backgroundView) {
        backgroundView =[[UIView alloc]initWithFrame:CGRectMake(20.0f, 0.0f,kScreenWidth-40, 64.0f)];
        backgroundView.backgroundColor = [UIColor clearColor];
        backgroundView.tag = 1011;
        
        //设置标题
        UILabel *aTitleLabel = nil;
        aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-60-13,  11, 120.0f, 40.0f)];
        aTitleLabel.text = titlename;
        
        aTitleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
        aTitleLabel.textAlignment = NSTextAlignmentCenter;
        aTitleLabel.backgroundColor = [UIColor clearColor];
        aTitleLabel.adjustsFontSizeToFitWidth = YES;
        aTitleLabel.textColor = [UIColor whiteColor];
        aTitleLabel.tag = 1022;
        [backgroundView addSubview:aTitleLabel];
        [self.navigationItem setTitleView:backgroundView];
        [aTitleLabel release];
        [backgroundView release];
    }
    else{
        UILabel *titlaLabel =  (UILabel*)[backgroundView viewWithTag:1022];
        [titlaLabel setText:titlename];
    }

}

- (void)addButtonReturn:(NSString *)image lightedImage:(NSString *) aLightedImage selector:(SEL)buttonClicked{
    returnbutton = [UIButton  buttonWithType:UIButtonTypeCustom];
    returnbutton.backgroundColor = [UIColor clearColor];
    [returnbutton setTintColor:[UIColor whiteColor]];
    returnbutton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [returnbutton setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [returnbutton setBackgroundImage:[UIImage imageNamed:aLightedImage] forState:UIControlStateHighlighted];
    [returnbutton addTarget:self action:buttonClicked forControlEvents:UIControlEventTouchUpInside];
    
//    if (kSystemIsIOS7) {
        returnbutton.frame = CGRectMake(-12.0f, 12.0f, 32,32);
//    }
//    else{
//        returnbutton.frame = CGRectMake(-5.0f, 2.0f, 30,30);
//    }
    returnbutton.tag = NAME_MAX;
    [self.navigationItem.titleView addSubview:returnbutton];
}

- (void)addRightButton:(NSString *)image  lightedImage:(NSString *) aLightedImage selector:(SEL)pushPastView{
    rightBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    returnbutton.backgroundColor = [UIColor clearColor];
    [rightBtn setTintColor:[UIColor whiteColor]];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [rightBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:aLightedImage] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:pushPastView forControlEvents:UIControlEventTouchUpInside];
    if (kSystemIsIOS7) {
        rightBtn.frame = CGRectMake(250.0f, 11.0f, [UIImage imageNamed:image].size.width,[UIImage imageNamed:image].size.height);
    }
    else{
        rightBtn.frame = CGRectMake(255.0f, 2.0f, [UIImage imageNamed:image].size.width,[UIImage imageNamed:image].size.height);
    }
    rightBtn.tag = 10009;
    [self.navigationItem.titleView addSubview:rightBtn];
}

#pragma parseJsonRequest

- (NSDictionary *)parseJsonRequest:(ASIHTTPRequest *) request{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSData *data = [request responseData];
    NSString *response = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    //打印请求返回的原串   JSONKit解析
    NSLog(@"response string=%@",response);
    NSDictionary *message = [response objectFromJSONString];
    
    /*
    NSDictionary *resultDic = [message objectForKey:@"result"];
    if([[resultDic objectForKey:@"status"] isEqualToString:@"01"]){
    
//        NSDictionary *finalDic = [resultDic objectForKey:@"businessData"];
//        return finalDic;
        return message;
    }else{
    
        NSDictionary *errorMessageDic = [resultDic objectForKey:@"error"];
        NSString *errorMessage = [errorMessageDic objectForKey:@"errorMessage"];
        return nil;
    }
     */
    return message;
}

- (void)showMBProgressHUD:(NSString *)title{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = title;
}


- (void)hideMBProgressHUD{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)showMBProgressHUDOnlyForAskAndAnswer:(NSString *)title offsetY:(float)anOffsetY{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    CGRect tRect = HUD.frame;
    tRect.origin.y -= anOffsetY;
    HUD.frame = tRect;
    HUD.labelText = title;
}


- (BOOL)checkLoginStatus:(NSDictionary *)aDict currentController:(UIViewController *)presentLoginController{
    [[ConstObject instance] setPresentLoginController:presentLoginController];
    //已经弹出登录提示就直接跳过
    if ([[ConstObject instance] hasAlertLogin]) return NO;
    if ([[NSString stringWithFormat:@"%@",[aDict objectForKey:@"status"]] intValue] == 1 && [[aDict objectForKey:@"nologin"] intValue] == 1) {
        [self showMessageBox:self
                       title:@"温馨提示"
                     message:[aDict objectForKey:@"error"]
                      cancel:nil
                     confirm:@"去登录"];
        [[ConstObject instance] setHasAlertLogin:YES];
        return NO;
    }
    else{
        [[ConstObject instance] setHasAlertLogin:NO];
        return YES;
    }
}

- (BOOL)checkNetworkStatus{
    if (![CheckNetwork isExistenceNetwork] && [[ConstObject instance] networkIsAvailable]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"网络不给力,请稍后再试"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        alert.tag = 10068;//临时断网tag
        [alert show];
        [alert release];
        [self hideMBProgressHUD];
        [[ConstObject instance] setNetworkIsAvailable:NO];
        return NO;
    }
    else{
        [[ConstObject instance] setNetworkIsAvailable:YES];
        return YES;
    }
}

//获取account信息
-(NSDictionary *)accountInfo{
    
    NSString *plistPath = [self fileTextPath:@"token.plist"];
    NSMutableArray *listArray = [[NSMutableArray alloc ] initWithContentsOfFile:plistPath];
    NSString *userName = @"";
    NSString *agreeCount = @"0";
    NSString *fansCount = @"0";
    NSString *viewCount = @"0";
    NSString *answer_count = @"0";
    
    if([listArray count]==0)
        return nil;
    else if ([listArray count]>2)
        userName = [listArray objectAtIndex:2];
    else if ([listArray count]>3)
        agreeCount = [listArray objectAtIndex:3];
    else if ([listArray count]>4)
        fansCount = [listArray objectAtIndex:4];
    else if ([listArray count]>5)
        viewCount = [listArray objectAtIndex:5];
    else if ([listArray count]>6)
        answer_count = [listArray objectAtIndex:6];
    
    NSDictionary *finalDic = [NSDictionary dictionaryWithObjectsAndKeys:userName,@"user_name",agreeCount,@"agree_count",fansCount,@"fans_count",viewCount, @"views_count",answer_count,@"answer_count",nil];
    return finalDic;
//    NSString *userName = [NSString stringWithFormat:@"%@",[accountDic objectForKey:@"user_name"]];
//    NSString *agree_count = [NSString stringWithFormat:@"%@",[accountDic objectForKey:@"agree_count"]];
//    NSString *fans_count = [NSString stringWithFormat:@"%@",[accountDic objectForKey:@"fans_count"]];
//    NSString *views_count = [NSString stringWithFormat:@"%@",[accountDic objectForKey:@"views_count"]];
    
//    [listArray addObject:userName];
//    [listArray addObject:agree_count];
//    [listArray addObject:fans_count];
//    [listArray addObject:views_count];
}

//获取token
-(NSString *)userToken{
    
    NSString *plistPath = [self fileTextPath:@"token.plist"];
    NSMutableArray *listArray = [[NSMutableArray alloc ] initWithContentsOfFile:plistPath];
    if([listArray count]==0)
        return nil;
    return [listArray objectAtIndex:0];
}

//获取uid
-(NSString *)userIDs{
    
    NSString *plistPath = [self fileTextPath:@"token.plist"];
    NSMutableArray *listArray = [[NSMutableArray alloc ] initWithContentsOfFile:plistPath];
    if([listArray count]==0)
        return nil;
    else if ([listArray count]>1)
        return [listArray objectAtIndex:1];
    else
        return @"";
}

//删除token
-(void)deleteToken{
    
    NSString *plistPath = [self fileTextPath:@"token.plist"];
    NSMutableArray *listArray = [[NSMutableArray alloc ] init];
    [listArray writeToFile:plistPath atomically:YES];
    [listArray release];
}



- (void)showMessageBox:(id)aDelegate title:(NSString *)aTitle  message:(NSString *)aMessage cancel:(NSString *)aCancel confirm:(NSString *)aConfirm{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:aTitle
                                                    message:aMessage
                                                   delegate:aDelegate
                                          cancelButtonTitle:aCancel
                                          otherButtonTitles:aConfirm, nil];
    [alert show];
    [alert release];
}


- (NSString *)fileTextPath:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirctory = [paths objectAtIndex:0];
    return [docDirctory stringByAppendingPathComponent:fileName];
}


- (NSString *)readUid{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"anUid"];
}

- (NSString *)readFemale{
    //第三方新浪微博返回的：性别，m：男、f：女、n：未知
    //第三方腾讯返回的：性别，女、男
    NSString *genderString = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"female"]];
    if ([genderString isEqualToString:@"f"] || [genderString isEqualToString:@"n"] || [genderString isEqualToString:@"女"]) {
        return @"1";
    }else{
        return @"0";
    }
}


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
//
//- (NSString *)getDeviceIdentifierForWall{
//    NSString *deviceIdentify = nil;
//    if (kSystemIsAboveIOS6) {
//        deviceIdentify = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    }
//    else{
//        deviceIdentify = [[UIDevice currentDevice] macaddress];
//    }
//    NSLog(@"deviceIdentify===%@",deviceIdentify);
//    return deviceIdentify;
//}



- (NSString *)readNickName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
}

- (void)analyzeUserLevel:(NSString *)aLevel andImageView:(UIButton *)levelButton{
    /*
     等级说明
     0: 秀女
     1: 答应
     2: 常在
     3: 贵人
     4: 达人
     5: 专家
     6: 顾问
     7: 美妆美人帮
     8: 嫔妃
     9: 贵妃
     10: 皇后
     */
    switch ([aLevel intValue]) {
        case 0:
            [levelButton setImage:[UIImage imageNamed:@"level0.png"] forState:UIControlStateNormal];
            break;
        case 1:
            [levelButton setImage:[UIImage imageNamed:@"level1.png"] forState:UIControlStateNormal];
            break;
        case 2:
            [levelButton setImage:[UIImage imageNamed:@"level2.png"] forState:UIControlStateNormal];
            break;
        case 3:
            [levelButton setImage:[UIImage imageNamed:@"level3.png"] forState:UIControlStateNormal];
            break;
        case 4:
            [levelButton setImage:[UIImage imageNamed:@"level4.png"] forState:UIControlStateNormal];
            break;
        case 5:
            [levelButton setImage:[UIImage imageNamed:@"level5.png"] forState:UIControlStateNormal];
            break;
        case 6:
            [levelButton setImage:[UIImage imageNamed:@"level6.png"] forState:UIControlStateNormal];
            break;
        case 7:
            [levelButton setImage:[UIImage imageNamed:@"level7.png"] forState:UIControlStateNormal];
            break;
        case 8:
            [levelButton setImage:[UIImage imageNamed:@"level8.png"] forState:UIControlStateNormal];
            break;
        case 9:
            [levelButton setImage:[UIImage imageNamed:@"level9.png"] forState:UIControlStateNormal];
            break;
        case 10:
            [levelButton setImage:[UIImage imageNamed:@"level10.png"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (NSString *)showUserSkin:(NSString *)userSkinString{
    
    NSString *skinString;
    if([userSkinString hasPrefix:@"干性"])
        skinString = @"gan.png";
    else if([userSkinString hasPrefix:@"油性"])
        skinString = @"you.png";
    else if([userSkinString hasPrefix:@"中性"])
        skinString = @"zhong.png";
    else if([userSkinString hasPrefix:@"混合"])
        skinString = @"hun.png";
    else if([userSkinString hasPrefix:@"敏感"])
        skinString = @"min.png";
    else
        skinString = @"";
    return skinString;
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [self hideMBProgressHUD];
    NSError *error = [request error];
    if ([error code] == ASIRequestTimedOutErrorType) {
        NSLog(@"time Out!!!");
        [[LoadingView sharedManager] showView:self.view message:@"请求超时,请重试..." originX:100.0f originY:150.0f delay:1.5f];
        //发送超时通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNetWorkTimeOutNotification
//                                                            object:nil];
    }
}

#pragma mark - 砸金蛋

- (void)saveCookies{
    NSData *cookies = [NSKeyedArchiver archivedDataWithRootObject:[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies];
    NSLog(@"cookies---%@",cookies);
    [[NSUserDefaults standardUserDefaults] setObject:cookies forKey:@"savedCookie"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)reloadStoredCookies{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"savedCookie"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookies) {
        [cookieStorage setCookie:cookie];
    }
}

- (void)deleteCookies{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"savedCookie"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookies) {
        [cookieStorage deleteCookie:cookie];
    }
    
    NSURL *url = [NSURL URLWithString:@"http://wenda.hers.com.cn"];
    if (url) {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
        for (int i = 0; i < [cookies count]; i++) {
            NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
}


-(void)requestZanDanSuccess:(ASIHTTPRequest *)request{
    
    NSDictionary *dic = [self parseJsonRequest:request];
    NSLog(@"----%@",dic);
}

-(void)requestZanDanFailed:(ASIHTTPRequest *)request{
    NSDictionary *dic = [self parseJsonRequest:request];
    NSLog(@"----%@",dic);
}

-(void)toDisappearTheView{
    
    for(id tempView in [blackViews subviews]){
        [tempView removeFromSuperview];
        tempView = nil;
    }
    for(id tempView in [zaKaiDanImageViews subviews]){
        [tempView removeFromSuperview];
        tempView = nil;
    }
    
    blackViews.hidden = YES;
    [blackViews removeFromSuperview];
    blackViews = nil;
    
    zaKaiDanImageViews.hidden = YES;
    [zaKaiDanImageViews removeFromSuperview];
    zaKaiDanImageViews = nil;
}


- (NSArray *)countYuanBao:(NSString *)coinNumber{
    NSString *yuanBaoCount = [NSString stringWithFormat:@"%d",[coinNumber intValue]/10000];
    NSString *jinBiCount = [NSString stringWithFormat:@"%d",[coinNumber intValue]%10000];
    NSArray  *coinArray = [NSArray arrayWithObjects:yuanBaoCount,jinBiCount,nil];
    return coinArray;
}

- (void)showLoginTips:(UIViewController *)aController{
    [[ConstObject instance] setPresentLoginController:aController];
    [self showMessageBox:self
                   title:@"美人帮提示"
                 message:@" 登录后才能访问哦~~登录参与美妆问答互动,赚取金币,便可兑换金币商场实物奖励"
                  cancel:@"马上登录"
                 confirm:@"取消"];
}

- (void)showLoginController:(UIViewController *)aController{
    LoginViewController *loginViewCon = [[LoginViewController alloc] init];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginViewCon];
    [loginViewCon release];
    [aController presentModalViewController:loginNav animated:YES];
    [loginNav release];
}

- (void)playVideo:(NSString *)vUrl presentController:(UIViewController *)aController{
    NSURL *videoUrl = [NSURL URLWithString:vUrl];
    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:videoUrl];
    [aController presentMoviePlayerViewControllerAnimated:player];
    [player release];
}

//- (void)showGoldEggForUsers:(NSNotification *)aNotification{
//    if ([[BeautyAppDelegate shareAppDelegate].window viewWithTag:33333] || ![[ConstObject instance] eggCoinCount])
//        return;
//    UIButton *beforeTipsButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    beforeTipsButton.frame = CGRectMake(kScreenBounds.origin.x, kScreenBounds.origin.y-20.0f, kScreenBounds.size.width, kScreenBounds.size.height+20.f);
//    if (iPhone5) {
//        [beforeTipsButton setImage:[UIImage imageNamed:@"beforeHitEggTips5.png"] forState:UIControlStateNormal];
//    }
//    else{
//        [beforeTipsButton setImage:[UIImage imageNamed:@"beforeHitEggTips4.png"] forState:UIControlStateNormal];
//    }
//    beforeTipsButton.backgroundColor = [UIColor clearColor];
//    [beforeTipsButton setTag:33333];
//    [beforeTipsButton addTarget:self action:@selector(hitGoldEggForUsers:) forControlEvents:UIControlEventTouchUpInside];
//    [[BeautyAppDelegate shareAppDelegate].window addSubview:beforeTipsButton];
//}
//
//
//- (void)hitGoldEggForUsers:(id)sender{
//    if (![[ConstObject instance] isLogin]) {
//        [[[BeautyAppDelegate shareAppDelegate].window viewWithTag:33333] removeFromSuperview];
//        [self showLoginController:[[ConstObject instance]  presentLoginController]];
//    }
//    else{
//        [(UIButton*)sender removeFromSuperview];
//        //砸金蛋
//        [commonModel requestZaDan:@selector(requestZanDanSuccess:) httpRequestFailed:@selector(requestZanDanFailed:)];
//        [self hitGoldEggResultForUsers];
//    }
//}

//- (void)hitGoldEggResultForUsers{
//    UIButton *afterTipsButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    afterTipsButton.adjustsImageWhenHighlighted = NO;
//    afterTipsButton.frame = CGRectMake(kScreenBounds.origin.x, kScreenBounds.origin.y-20.0f, kScreenBounds.size.width, kScreenBounds.size.height+20.f);
//    if (iPhone5) {
//        [afterTipsButton setImage:[UIImage imageNamed:@"afterHitEggTips5.png"] forState:UIControlStateNormal];
//    }
//    else{
//        [afterTipsButton setImage:[UIImage imageNamed:@"afterHitEggTips4.png"] forState:UIControlStateNormal];
//    }
//    afterTipsButton.backgroundColor = [UIColor clearColor];
//    [[BeautyAppDelegate shareAppDelegate].window addSubview:afterTipsButton];
//    
//    //金币数
//    UILabel *coinLabel = [[UILabel alloc] init];
//    if (iPhone5) {
//        coinLabel.frame = CGRectMake(110.0f, 160.0f, 50.0f, 30.0f);
//    }
//    else{
//        coinLabel.frame = CGRectMake(110.0f, 90.0f, 50.0f, 30.0f);
//    }
//    [coinLabel setTextColor:[UIColor whiteColor]];
//    [coinLabel setTextAlignment:NSTextAlignmentCenter];
//    [coinLabel setAdjustsFontSizeToFitWidth:YES];
//    [coinLabel setBackgroundColor:[UIColor clearColor]];
//    [coinLabel setText:[[ConstObject instance] eggCoinCount]];
//    [coinLabel setFont:kFontArialBoldMT19];
//    [afterTipsButton addSubview:coinLabel];
//    [coinLabel release];
//    
//    //我知道了
//    UIButton *knowButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    if (iPhone5) {
//        knowButton.frame =  CGRectMake(100.0f, 485.0f, 115.0f, 40.0f);
//    }
//    else{
//        knowButton.frame =  CGRectMake(100.0f, 410.0f, 115.0f, 40.0f);
//    }
//    [knowButton setImage:[UIImage imageNamed:@"eggIKnow.png"] forState:UIControlStateNormal];
//    [knowButton setImage:[UIImage imageNamed:@"eggIKnowLighted.png"] forState:UIControlStateHighlighted];
//    knowButton.backgroundColor = [UIColor clearColor];
//    [afterTipsButton addSubview:knowButton];
//    [knowButton addTarget:self action:@selector(hitGoldEggAfterForUsers:) forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)hitGoldEggAfterForUsers:(id)sender{
//    UIButton *btn = (UIButton*)sender;
//    [btn.superview removeFromSuperview];
//    [[[BeautyAppDelegate shareAppDelegate].window viewWithTag:33333] removeFromSuperview];
//    [[ConstObject instance] setEggCoinCount:nil];
//}

- (void)showLoginSucceedTips{
    [[LoadingView sharedManager] showView:[[[ConstObject instance] presentLoginController] view] message:@"😄登录成功" originX:100 originY:150 delay:2.0f];
}

//- (void)showUserAreaTips:(NSArray *)anArray{
//    if ([[BeautyAppDelegate shareAppDelegate].window viewWithTag:44444]) return;
//    for (NSDictionary *dic in anArray) {
//        if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"tip"]] intValue] == 1) {
//            UIButton *areaTipsButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            areaTipsButton.frame = CGRectMake(kScreenBounds.origin.x, kScreenBounds.origin.y-20.0f, kScreenBounds.size.width, kScreenBounds.size.height+20.f);
//            if (iPhone5) {
//                [areaTipsButton setImage:[UIImage imageNamed:@"areaTips5.png"] forState:UIControlStateNormal];
//            }
//            else{
//                [areaTipsButton setImage:[UIImage imageNamed:@"areaTips4.png"] forState:UIControlStateNormal];
//            }
//            areaTipsButton.backgroundColor = [UIColor clearColor];
//            areaTipsButton.adjustsImageWhenHighlighted = NO;
//            areaTipsButton.tag = 44444;
//            [[BeautyAppDelegate shareAppDelegate].window addSubview:areaTipsButton];
//            
//            //关闭弹出框按钮
//            UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            UIImage *closeImage = [UIImage imageNamed:@"closeAlertVIew.png"];
//            UIImage *closeLightedImage = [UIImage imageNamed:@"closeAlertVIewLighted.png"];
//            
//            closeButton.frame = CGRectMake(275.0f, 130.0f, closeImage.size.width, closeImage.size.height);
//            [closeButton setImage:closeImage forState:UIControlStateNormal];
//            [closeButton setImage:closeLightedImage forState:UIControlStateHighlighted];
//            [closeButton addTarget:self action:@selector(closeAreaTips:) forControlEvents:UIControlEventTouchUpInside];
//            [areaTipsButton addSubview:closeButton];
//        }
//    }
//}

- (void)closeAreaTips:(id)sender{
    UIButton *btn = (UIButton*)sender;
    [btn.superview removeFromSuperview];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10068) {
        [[ConstObject instance] setNetworkIsAvailable:YES];
    }
    else{
        if (buttonIndex == 0) {
            [[ConstObject instance] setIsLogin:NO];
            [self showLoginController:[[ConstObject instance] presentLoginController]];
        }
    }
}

//主视图内容显示 不含表情时、字数在80字内 字数内容截取
- (NSString *)contentMainView:(NSString *)content{
    //查找[]表情符号
    //读取的内容类似[Expression_15]这种含有_下划线 正则表达式不能识别 所以要去掉_
    NSInteger loc = [content rangeOfString:@"_"].location;
    NSInteger len = [content rangeOfString:@"_"].length;
    NSMutableString *conMutableStr = [NSMutableString stringWithString:content];
    if ([content rangeOfString:@"_"].location != NSNotFound) {
        
        [conMutableStr replaceCharactersInRange:NSMakeRange(loc, len) withString:@""];
    }
    NSString *conStr = [NSString stringWithFormat:@"%@",conMutableStr];
    NSError *error;
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";//表情[]的正则表达式
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:regex_emoji
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:&error];
    NSArray *array = [regex2 matchesInString:conStr options:0 range:NSMakeRange(0, [conStr length])];
    
    int count=(int)[array count];//含有表情
    //内容大于80个字 并且 不含有表情符号
    if(content.length > 80 && (count == 0)){
        content = [content substringToIndex:80];
        content = [content stringByAppendingString:@"..."];
    }else{
        content = content;
    }
    return content;
}

#pragma mark - 字符串判断
- (BOOL) isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) { return YES; } if ([string isKindOfClass:[NSNull class]]) { return YES; } if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) { return YES; } return NO;
}

#pragma mark - 空字典判断
- (BOOL) isBlankDictionary:(NSDictionary *)dictionary
{
    if (dictionary == nil || dictionary == NULL) { return YES; } if ([dictionary isKindOfClass:[NSNull class]]) { return YES; }  return NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)dealloc
{
    [commonModel release];
    commonModel = nil;
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:kShowLoginSucceedTips
//                                                  object:nil];
    
    
    [super dealloc];
}


//时间戳转时间
-(NSString *)transformTime:(NSString *)originTime{
    
    NSTimeInterval time=[originTime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

//计算字符串size
- (CGSize)getStringSizeWith:(NSString*)_mystr boundingRectWithSize:(CGSize)_boundSize font:(UIFont*)font{
    
    if ([self isBlankString:_mystr]){
        return CGSizeMake(_boundSize.width, 20);
    }
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize size = [_mystr  boundingRectWithSize:_boundSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size;
    
}

-(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
        UIGraphicsBeginImageContext(rect.size);
    
        CGContextRef context = UIGraphicsGetCurrentContext();
    
        CGContextSetFillColorWithColor(context, [color CGColor]);
    
        CGContextFillRect(context, rect);
    
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
        UIGraphicsEndImageContext();
    
        return image;
    
    }

-(NSString *)trimString:(NSString *)tempString{

    tempString = [tempString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"\r"withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"\t"withString:@""];
    NSString *temps =[tempString substringToIndex:1];
    if([temps isEqualToString:@"\n"]){
        tempString = [tempString stringByReplacingOccurrencesOfString:@"\n"withString:@""];
    }
    return tempString;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
