//
//  LeftViewController.m
//  Mei Zhuang
//
//  Created by Apple on 13-10-29.
//  Copyright (c) 2013年 Apple. All rights reserved.
//
#import "BadgeView.h"
#import "MenuCell.h"
#import "LoadingView.h"
//#import "UMFeedback.h"
#import "LeftViewController.h"
#import "UIViewController+MMDrawerController.h"
//#import "MessageViewController.h"
//#import "WealthListViewController.h"
//#import "SetUpViewController.h"
//#import "ProfileViewController.h"
//#import "InviteFriendsViewController.h"
#import "UIButton+WebCache.h"
#import "ConstObject.h"
//#import "GoldCoinMallViewController.h"
//#import "FreeUseViewController.h"
//#import "FindAndSiftViewController.h"
//#import "CommandAppController.h"
//#import "ZaJinDanViewController.h"

enum checkinButtonTag{
    NoCheckin,
    Checkined,
};

@interface LeftViewController ()

//进入个人主页
- (void)toProfileViewController;

//请求个人主页信息
- (void)fetchProfileData;

//保存登录个人信息（包括绑定的账号信息）
- (void)getLoginUserInfo:(NSNotification *)notificaton;

//重置菜单刷新标量
- (void)setRefreshFlag;

//进入设置主页
- (void)toSetPage;

//邀请好友砸金蛋
- (void)toInviteFriendZaDan;

//提示用户登录
- (void)showLoginControllerTips;

//点击登录
- (void)toLoginController;

//签到
- (void)tocheckinPage;

//已签到
- (void)changeCheckinStatus;

@end

@implementation LeftViewController

@synthesize homeSwitchVC,messageSwitchVC,wealthSwitchVC,setSwitchVC,profileSwitchVC,goldCoinMallSwitchVC,inviteFriendSwitchVC,freeSwitchVC,findSwitchVC,commandAppSwitchVC,checkinSwitchVC;
@synthesize myCoinNum,commandAppUrl,check_countString,check_leftString,coinNumberString,nextCheckNumString;
@synthesize newMessageCount;

- (id)init {
    if ((self = [super init])) {
        HomePageViewController *slideSwitchVC = [[HomePageViewController alloc] init];
        self.homeSwitchVC = [[UINavigationController alloc] initWithRootViewController:slideSwitchVC];
        [[ConstObject instance] setHomeViewController:slideSwitchVC];
        [slideSwitchVC release];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //设置状态栏字颜色为黑色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    if ((!fetchDataSucceed || [[[ConstObject instance] messageCount] intValue] != 0) && [[ConstObject instance] isLogin]) {
        //读取新消息数
        self.newMessageCount = [[ConstObject instance] messageCount];
        [centerTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone] ;
        [self fetchProfileData];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //设置状态栏字颜色为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"viewBackGround.png"]];
    
    if (kSystemIsIOS7) {
        centerTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x,20.0f, kScreenBounds.size.width, kScreenBounds.size.height) style:UITableViewStyleGrouped];
    }
    else{
        centerTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x,0.0f, kScreenBounds.size.width, kScreenBounds.size.height) style:UITableViewStylePlain];
    }
    centerTableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"viewBackGround.png"]] autorelease];
    //    centerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    centerTableView.delegate = self;
    centerTableView.dataSource = self;
    centerTableView.backgroundColor = [UIColor clearColor];
    //设置表头部个人信息
    centerTableView.tableHeaderView = ({
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 130.0f)] autorelease];
        view.backgroundColor = [UIColor clearColor];
        // 透明大背景,点击进入个人主页
        UIButton *profileBackgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        profileBackgroundButton.frame = CGRectMake(0, 0.0f, kScreenBounds.size.width, 2*74.0f);
        profileBackgroundButton.backgroundColor = [UIColor clearColor];
        profileBackgroundButton.adjustsImageWhenHighlighted = NO;
        [profileBackgroundButton addTarget:self action:@selector(toProfileViewController) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:profileBackgroundButton];
        
        // 头像
        avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        avatarButton.backgroundColor = [UIColor clearColor];
        avatarButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        [avatarButton setBackgroundImage:[UIImage imageNamed:@"menuAvatar.png"] forState:UIControlStateNormal];
        avatarButton.frame = CGRectMake(18.0f, 40.0f, 80.0f, 80.0f);
        avatarButton.layer.masksToBounds = YES;
        avatarButton.layer.cornerRadius = 40.0;
        avatarButton.layer.borderColor = [UIColor whiteColor].CGColor;
        avatarButton.layer.borderWidth = 2.0f;
        avatarButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
        avatarButton.layer.shouldRasterize = YES;
        avatarButton.clipsToBounds = YES;
        [avatarButton setBackgroundImage:[UIImage imageNamed:@"menuAvatar.png"] forState:UIControlStateNormal];
        [avatarButton addTarget:self action:@selector(toProfileViewController) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:avatarButton];
        
        //昵称
        nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(130.0f, 80.0f, 130.0f, 25.0f)];
        nickLabel.frame = CGRectMake(110.0f, 50.0f, 130.0f, 25.0f);
        nickLabel.backgroundColor = [UIColor clearColor];
        nickLabel.font = [UIFont fontWithName:@"Arial" size:16.0f];
        nickLabel.textColor = [UIColor colorWithRed:78.0f/255.0f green:80.0f/255.0f blue:83.0f/255.0f alpha:1];
        nickLabel.numberOfLines = 1;
        [view addSubview:nickLabel];
        [nickLabel release];
        nickLabel.hidden = ![[ConstObject instance] isLogin];

        /*
         //等级标志
         levelImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
         levelImageView.backgroundColor = [UIColor clearColor];
         [view addSubview:levelImageView];
         [levelImageView release];
         */
        
        //未登录 点击登录
        loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton  setFrame:CGRectMake(avatarButton.frame.origin.x+avatarButton.frame.size.width+15.0f, avatarButton.frame.origin.y+avatarButton.frame.size.height/2.5, 110.0f, 30.0f)];
        [loginButton setBackgroundColor:[UIColor clearColor]];
        [loginButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [loginButton.titleLabel setFont:kFontArial17];
        [loginButton setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:140.0f/255.0f blue:175.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [loginButton setTitle:@"点击登录" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(toLoginController) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:loginButton];
        loginButton.hidden = [[ConstObject instance] isLogin];
        
        //签到
        checkinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *checkinImage = [UIImage imageNamed:@"checkin_ProfilePage.png"];
        checkinButton.backgroundColor = [UIColor clearColor];
        checkinButton.frame = CGRectMake(110.0f, nickLabel.frame.origin.y + nickLabel.frame.size.height, checkinImage.size.width, checkinImage.size.height);
        [checkinButton addTarget:self action:@selector(tocheckinPage) forControlEvents:UIControlEventTouchUpInside];
        checkinButton.hidden = ![[ConstObject instance] isLogin];
        [view addSubview:checkinButton];

        //设置
        UIButton *setButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *setImage = [UIImage imageNamed:@"setup.png"];
        setButton.backgroundColor = [UIColor clearColor];
        setButton.frame = CGRectMake(230.0f, 15.0f, setImage.size.width, setImage.size.height);
        [setButton setImage:setImage forState:UIControlStateNormal];
        [setButton addTarget:self action:@selector(toSetPage) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:setButton];
        
        view;
    });
    /*
    //设置表尾视图
    centerTableView.tableFooterView = ({
        UIView *footView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenBounds.size.width, 119.0f)] autorelease];
        footView.backgroundColor = [UIColor clearColor];
        
        //邀请好友砸金蛋
        UIImageView *inviteFriendImageView = [[UIImageView alloc] init];
        inviteFriendImageView.userInteractionEnabled = YES;
        UIImage *inviteFriendImage = [UIImage imageNamed:@"inviteFriendZaDan.png"];
        inviteFriendImageView.frame = CGRectMake(110.0f, -48.0f, inviteFriendImage.size.width, inviteFriendImage.size.height);
        [inviteFriendImageView setImage:inviteFriendImage];
        
        UIButton *inviteFriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        inviteFriendButton.frame = CGRectMake(0.0f, 12.0f, inviteFriendImage.size.width, inviteFriendImage.size.height-23.0f);
        inviteFriendButton.backgroundColor = [UIColor clearColor];
        [inviteFriendButton addTarget:self action:@selector(toInviteFriendZaDan) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:inviteFriendImageView];
        [inviteFriendImageView addSubview:inviteFriendButton];
        [inviteFriendImageView release];
        
        footView;
    });
    */
    //添加上拉刷新
    if (refreshHeaderView == nil) {
        refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - centerTableView.bounds.size.height, self.view.frame.size.width, centerTableView.bounds.size.height)];
        refreshHeaderView.delegate = self;
        refreshHeaderView._statusLabel.text = @"下拉更新个人信息";
        [centerTableView addSubview:refreshHeaderView];
        [refreshHeaderView release];
    }
    
    
    [self.view addSubview:centerTableView];
    [centerTableView release];
    //初始化标志NO
    fetchDataSucceed = NO;

    //初始化应用显示VC
    NSString *remoteVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"remoteVersion"];
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if ([appVersion compare:remoteVersion] == NSOrderedDescending) {
        displayCommandAppVC = NO;
    }
    else{
        displayCommandAppVC = YES;
    }

    //拿到登录用户信息 通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getLoginUserInfo:)
                                                 name:kGetLoginUserInfo
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(thirdLoginoutSucceed)
                                                 name:@"thirdLoginoutSucceed"
                                               object:nil];
    //左侧栏 签到改为已签到
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeCheckinStatus)
                                                 name:kCheckined
                                               object:nil];
}

#pragma mark
#pragma mark --- Functions
//请求个人主页信息
- (void)fetchProfileData{
    if ([[ConstObject instance] isLogin]) {
        NSString *thirdUserId; //第三方登录用户id
        //区分是新浪微博登录还是qq登录
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaIsLoginSucceed"] integerValue] == 1) {
            thirdUserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sina_serverUid"];
        }else{
            thirdUserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"qq_serverUid"];
        }
        [commonModel requestProfile:thirdUserId httpRequestSucceed:@selector(requestProfileSucceed:) httpRequestFailed:@selector(requestProfileFailed:)];
    }
}

- (void)doLoginOutSucceed{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"qqIsLoginSucceed"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sinaIsLoginSucceed"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sinaBind_uid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sina_token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen_username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen_name"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"qq_username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"qq_accessToken"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"qq_openId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"qq_serverName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"qq_serverUid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"qq_serverAvatar"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sina_serverName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sina_serverUid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sina_serverAvatar"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"answer_notice"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"system_notice"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"diary_notice"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"qq_loginAllInfo"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"anUid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"female"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //清理当前登录状态
    [[ConstObject instance] setIsLogin:NO];
    [avatarButton setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"menuAvatar.png"]];
    [nickLabel setHidden:YES];

    [loginButton setHidden:NO];
    [checkinButton setHidden:YES];
    //清除cookie
    [super deleteCookies];
    
    //清除针对不登录/登录只浏览，不做交互的用户金蛋奖励机制
//    [[[BeautyAppDelegate shareAppDelegate].window viewWithTag:33333] removeFromSuperview];
    [[ConstObject instance] setEggCoinCount:nil];


/*
    //发送登录通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddLoginView
                                                        object:nil];
*/
    
    //切换到首页视图
    //    if(self.homeSwitchVC){
    //        [self.homeSwitchVC removeFromParentViewController];
    //        [self.homeSwitchVC release];
    //        self.homeSwitchVC = nil;
    //    }
    //    HomePageViewController *homeSlideController = [[HomePageViewController alloc] init];
    //    [[ConstObject instance] setHomeViewController:homeSlideController];
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeSlideController];
    //    [homeSlideController release];
    //    [self.mm_drawerController setCenterViewController:nav
    //                                   withCloseAnimation:YES completion:nil];
}

- (void)setRefreshFlag{
    [[ConstObject instance] setReLoadHomeData:YES];
    [[ConstObject instance] setReLoadMessageData:YES];
    [[ConstObject instance] setReLoadWealthData:YES];
    [[ConstObject instance] setReLoadFreeUseData:YES];
    [[ConstObject instance] setReLoadMallData:YES];
    [[ConstObject instance] setReLoadSetData:YES];
    [[ConstObject instance] setReLoadProfileData:YES];
}

- (void)toSetPage{
    //切换到设置视图
//    [MobClick event:@"set_page_count"];
    if (![[ConstObject instance] isLogin]) {
        [super showLoginTips:self];
    }
    else{
        //标记全局首页变量为NO
        [[ConstObject instance] setIsHomePage:NO];
        if (!self.setSwitchVC || [[ConstObject instance] reLoadSetData]) {
//            SetUpViewController *setUpSlideController = [[SetUpViewController alloc] init];
//            self.setSwitchVC = [[UINavigationController alloc] initWithRootViewController:setUpSlideController];
//            [setUpSlideController release];
            [[ConstObject instance] setReLoadSetData:NO];
        }
        [self.mm_drawerController setCenterViewController:self.setSwitchVC
                                   withFullCloseAnimation:YES completion:nil];
    }
}

- (void)toInviteFriendZaDan{
    NSLog(@"邀请好友砸金蛋");
//    [MobClick event:@"invite_egg_count"];
    //标记全局首页变量为NO
    [[ConstObject instance] setIsHomePage:NO];
    if (!self.inviteFriendSwitchVC) {
//        ZaJinDanViewController *zaJinDanViewController = [[ZaJinDanViewController alloc] init];
//        self.inviteFriendSwitchVC = [[UINavigationController alloc] initWithRootViewController:zaJinDanViewController];
//        [zaJinDanViewController release];
    }
    [self.mm_drawerController setCenterViewController:self.inviteFriendSwitchVC
                               withFullCloseAnimation:YES
                                           completion:nil];
}

- (void)showLoginControllerTips{
    [self showMessageBox:self
                   title:@"美人帮提示"
                 message:@" 登录后才能访问哦~~登录参与美妆问答互动,赚取金币,便可兑换金币商场实物奖励"
                  cancel:@"马上登录"
                 confirm:@"取消"];
}

- (void)toLoginController{
    [[ConstObject instance] setPresentLoginController:self];
    [super showLoginController:self];
}

//#pragma mark UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0) {
//        [super showLoginController:self];
////        [self.mm_drawerController setCenterViewController:self.homeSwitchVC
////                                   withFullCloseAnimation:YES completion:nil];
////        //发送登录通知
////        [[NSNotificationCenter defaultCenter] postNotificationName:kAddLoginView
////                                                            object:nil];
//    }
//}

//- (void)tocheckinPage{
//    //区分是否已签到
//    if (checkinButton.tag == Checkined) {
//        if (!self.checkinSwitchVC || [[ConstObject instance] reLoadSetData]) {
//            CheckinSuccessViewController *checkinSuccessViewController = [[CheckinSuccessViewController alloc] init];
//
//            checkinSuccessViewController.coinNum = [NSString stringWithFormat:@"%@",self.coinNumberString];
//            checkinSuccessViewController.checkinedDayNum = [NSString stringWithFormat:@"%@",self.check_countString];
//            checkinSuccessViewController.check_leftString = [NSString stringWithFormat:@"%@",self.check_leftString];
//            checkinSuccessViewController.nextCheckCoinNumString = [NSString stringWithFormat:@"%@",self.nextCheckNumString];
//            
//            self.checkinSwitchVC = [[UINavigationController alloc] initWithRootViewController:checkinSuccessViewController];
//            [checkinSuccessViewController release];
//            [[ConstObject instance] setReLoadSetData:NO];
//        }
//        [self.mm_drawerController setCenterViewController:self.checkinSwitchVC
//                                   withFullCloseAnimation:YES completion:nil];
//    }else{
//      [commonModel requestCheckin:@selector(requestCheckinSuccess:) httpRequestFailed:@selector(requestCheckinFailed:)];
//    }
//}

- (void)changeCheckinStatus{
    [checkinButton setImage:[UIImage imageNamed:@"checkined.png"] forState:UIControlStateNormal];
    checkinButton.tag = Checkined;
    //初始化标志NO,重新刷新下个人资料信息
    fetchDataSucceed = NO;
}

#pragma --mark
#pragma --mark -- ASIHTTPRequest CallBack
-(void)requestProfileSucceed:(ASIHTTPRequest *)request{
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic=%@",dic);
    self.myCoinNum = [dic objectForKey:@"coins"];
    //签到相关参数
    self.check_countString = [dic objectForKey:@"check_count"];
    self.coinNumberString = [dic objectForKey:@"number"];
    self.nextCheckNumString = [dic objectForKey:@"check_number"];
    self.check_leftString = [dic objectForKey:@"check_left"];
    
    //我的金币存到本地，"试用详情申请试用"页面需要用到
    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"coins"] forKey:@"myCoins"];
    //重置数据标志
    [[dic objectForKey:@"status"] intValue] == 0 ? (fetchDataSucceed = YES) : (fetchDataSucceed = NO);
    
    //设置昵称
    [nickLabel setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"username"]]];
    nickLabel.hidden = ![[ConstObject instance] isLogin];
    [nickLabel sizeToFit];
    
    //未登录按钮设置
    loginButton.hidden = [[ConstObject instance] isLogin];
    
    //签到按钮设置
    checkinButton.hidden = ![[ConstObject instance] isLogin];
    //签到过
    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"checked"]] intValue] == 1)
    {
        [checkinButton setImage:[UIImage imageNamed:@"checkined.png"] forState:UIControlStateNormal];
        checkinButton.tag = Checkined;
    }
    //还没有签到
    else
    {
        [checkinButton setImage:[UIImage imageNamed:@"checkin_ProfilePage.png"] forState:UIControlStateNormal];
        checkinButton.tag = NoCheckin;
    }
    
    //应用推荐地址
    self.commandAppUrl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"rurl"]];
    
    //区分新旧用户
    [[ConstObject instance] setIsNewUser:[[NSString stringWithFormat:@"%@",[dic objectForKey:@"new"]] boolValue]];
    
    //若是管理员，重新设置颜色
    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"uid"]] isEqualToString:kAdministratorUid]) {
        [nickLabel setTextColor:kRedColor];
    }
    else{
        nickLabel.textColor = kContentColor;
    }
    
    //设置头像
    [avatarButton setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"avatar80"]] placeholderImage:[UIImage imageNamed:@"menuAvatar.png"]];
    /*
     //设置等级标志
     levelImageView.frame = CGRectMake(nickLabel.frame.origin.x + nickLabel.frame.size.width + 2.0f, nickLabel.frame.origin.y + 2.0f, 40.0f, 15.0f);
     [super analyzeUserLevel:[dic objectForKey:@"level"] andImageView:levelImageView];
     */
    
    //读取新消息数
    self.newMessageCount = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[dic objectForKey:@"newmessages"]]];
    //新消息数不为0  就刷新消息行
    [newMessageCount intValue] != 0 ? [centerTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone] : @"";
    NSLog(@"newMessageCount=%@",newMessageCount);
    [[ConstObject instance] setMessageCount:newMessageCount];
    
    //回复通知
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"answer_notice"]] forKey:@"answer_notice"];
    //系统通知
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"system_notice"]] forKey:@"system_notice"];
    //心情日记开关
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"public_diary"]] forKey:@"diary_notice"];

    //更新当前UID
    if (![super readUid] || [[super readUid] isEqualToString:@"(null)"]) {
        [self saveUid:[NSString stringWithFormat:@"%@",[dic objectForKey:@"uid"]]];
    }
    //更新当前cookie
    [super saveCookies];
    
    //更新当前全局nickName
    [[NSUserDefaults standardUserDefaults] setValue:[dic objectForKey:@"username"] forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
}

-(void)requestProfileFailed:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
    fetchDataSucceed = NO;
}


- (void)toProfileViewController{
    if (![[ConstObject instance] isLogin]) {
        [super showLoginTips:self];
    }
    else{
        if ([super checkNetworkStatus]) {
            if (!self.profileSwitchVC || [[ConstObject instance] reLoadProfileData]) {
//                ProfileViewController *profileController = [[ProfileViewController alloc] init];
//                profileController.isMyHomePage = YES;
//                self.profileSwitchVC  = [[UINavigationController alloc] initWithRootViewController:profileController];
//                [profileController release];
//                [[ConstObject instance] setReLoadProfileData:NO];
            }
            [self.mm_drawerController setCenterViewController:profileSwitchVC
                                       withFullCloseAnimation:YES completion:nil];
        }
    }
}

//保存uid到本地
- (void)saveUid:(NSString *)uid{
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"anUid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)getLoginUserInfo:(NSNotification *)notificaton{
    NSDictionary *getUserInfoDic = (NSDictionary *)[notificaton userInfo];
    
    NSLog(@"getUserInfoDic=%@",getUserInfoDic);
    //如果是qq注册的 绑定了微博 下次用微博登录 需要记录下初始注册的是哪个第三方（qq还是微博） 为了区分设置页的取消绑定的按钮加在哪里
    [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"type"] forKey:@"whichThirdRegister"];
    NSString *tempUserId =[getUserInfoDic objectForKey:@"uid"];
    //判断重新切换账户
    if(![[super readUid] isEqualToString:tempUserId]){
        [self setRefreshFlag];
    }
    
    //保存账户UID cookie
    [self saveUid:tempUserId];
    [super saveCookies];
    NSLog(@"---%@",tempUserId);
    NSString *expiredDate = [NSString stringWithFormat:@"%@",[getUserInfoDic objectForKey:@"expired"]];
    if ([expiredDate isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:expiredDate forKey:@"qq_expirationDate"];
    }else{
        expiredDate = [expiredDate stringByReplacingCharactersInRange:NSMakeRange(expiredDate.length-5, 5) withString:@""];
        [[NSUserDefaults standardUserDefaults] setObject:expiredDate forKey:@"qq_expirationDate"];
    }
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"qq_expirationDate"]);
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaIsLoginSucceed"] integerValue] == 1) {
        [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"username"] forKey:@"sina_serverName"];
        [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"uid"] forKey:@"sina_serverUid"];
        [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"avatar"] forKey:@"sina_serverAvatar"];
        [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"token"]  forKey:@"qqBind_accessToken"];
        [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"openid"] forKey:@"qqBind_openId"];
        [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"qqname"] forKey:@"qqBind_username"];
    }else{
        [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"username"] forKey:@"qq_serverName"];
        [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"uid"] forKey:@"qq_serverUid"];
        [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"avatar"] forKey:@"qq_serverAvatar"];
        [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"auth"] forKey:@"sinaBind_token"];
        [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"sinaid"] forKey:@"sinaBinded_uid"];
        [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"sinaname"] forKey:@"Bindscreen_username"];
    }
    
    //设置头像
    [avatarButton setImageWithURL:[NSURL URLWithString:[getUserInfoDic objectForKey:@"avatar80"]] placeholderImage:[UIImage imageNamed:@"menuAvatar.png"]];
    
    //设置昵称
    [nickLabel setText:[NSString stringWithFormat:@"%@",[getUserInfoDic objectForKey:@"username"]]];
    nickLabel.hidden = ![[ConstObject instance] isLogin];
    [nickLabel sizeToFit];
    
    //未登录按钮设置
    loginButton.hidden = [[ConstObject instance] isLogin];
    
    //签到按钮设置
    checkinButton.hidden = ![[ConstObject instance] isLogin];

    //保存一个全局的nickName
    [[NSUserDefaults standardUserDefaults] setValue:[getUserInfoDic objectForKey:@"username"] forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //登录成功后，刷新数据
    [self fetchProfileData];
    
    //登录成功发送注册消息通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kRegisterPushNotification
                                                        object:nil];

}

//签到回调
- (void)requestCheckinSuccess:(ASIHTTPRequest *)request{
    NSDictionary *dic = [super parseJsonRequest:request];
    if ([[dic objectForKey:@"status"] intValue] == 1){
        [[LoadingView sharedManager] showView:self.view message:@"签到失败" originX:100.0f originY:90.0f  delay:1.0f];
    }else{
        /*
        number：0表示今天已经签到，其它表示签到得到的金币数量
        count：表示连续签到的天数
         */
        //左侧栏 签到标示为已签到
        [self changeCheckinStatus];
//        if (!self.setSwitchVC || [[ConstObject instance] reLoadSetData]) {
//            CheckinSuccessViewController *checkinSuccessViewController = [[CheckinSuccessViewController alloc] init];
//            if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"number"]] intValue] == 0) {//今天已经签到
//                [[LoadingView sharedManager] showView:self.view message:@"今天已经签到" originX:100.0f originY:90.0f  delay:1.0f];
//            }else{
//                checkinSuccessViewController.coinNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"number"]];
//                checkinSuccessViewController.checkinedDayNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]];
//                checkinSuccessViewController.check_leftString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"check_left"]];
//                checkinSuccessViewController.nextCheckCoinNumString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"check_number"]];
//            }
//            self.setSwitchVC = [[UINavigationController alloc] initWithRootViewController:checkinSuccessViewController];
//            [checkinSuccessViewController release];
//            [[ConstObject instance] setReLoadSetData:NO];
//        }
        [self.mm_drawerController setCenterViewController:self.setSwitchVC
                                   withFullCloseAnimation:YES completion:nil];
    }
}

- (void)requestCheckinFailed:(ASIHTTPRequest *)request{
    [[LoadingView sharedManager] showView:self.view message:@"操作失败,请重新尝试" originX:100.0f originY:150.0f  delay:1.0f];
}

#pragma mark --- ThirdLoginout CallBack
- (void)thirdLoginoutSucceed{
    if(!self.homeSwitchVC){
        HomePageViewController *homeSlideController = [[HomePageViewController alloc] init];
        self.homeSwitchVC = [[UINavigationController alloc] initWithRootViewController:homeSlideController];
        [homeSlideController release];
    }
    [self.mm_drawerController setCenterViewController:self.homeSwitchVC
                               withFullCloseAnimation:YES completion:nil];
    
    fetchDataSucceed = NO;
    [self doLoginOutSucceed];
}

#pragma mark
#pragma mark--- UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![super checkNetworkStatus]) {
        return;
    }
   //重置当前menu背景
    if (menuCell) {
        [menuCell setBackgroundView:nil];
        menuCell = nil;
    }
//
    menuCell = (MenuCell*)[tableView cellForRowAtIndexPath:indexPath];
//    [menuCell setBackgroundView:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuSelectedBackground.png"]] autorelease]];
    
    if (indexPath.row == 0) {
        //切换到首页视图
//        [MobClick event:@"home_page_count"];
        //标记全局首页变量为YES
        [[ConstObject instance] setIsHomePage:YES];
        //由于在财富榜页面会隐藏消息提醒 所以这个页面得重新置下状态
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateLastedQusetionCount
                                                            object:nil];
        
        if(!self.homeSwitchVC || [[ConstObject instance] reLoadHomeData]){
            HomePageViewController *homeSlideController = [[HomePageViewController alloc] init];
            self.homeSwitchVC = [[UINavigationController alloc] initWithRootViewController:homeSlideController];
            [[ConstObject instance] setHomeViewController:homeSlideController];
            [homeSlideController release];
            [[ConstObject instance] setReLoadHomeData:NO];
            [[ConstObject instance] setRemoveTQTextDelegate:YES];
        }
        [self.mm_drawerController setCenterViewController:self.homeSwitchVC
                                   withFullCloseAnimation:YES completion:nil];
        //更新新消息提醒
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateNewMessageCount
                                                            object:nil];
        
        
    } else if (indexPath.row == 1) {
        //切换到消息视图
//        [MobClick event:@"message_page_count"];
        if (![[ConstObject instance] isLogin]) {
            [super showLoginTips:self];
        }
        else{
            //标记全局首页变量为NO
            [[ConstObject instance] setIsHomePage:NO];
            
            if (!self.messageSwitchVC || [[ConstObject instance] reLoadMessageData]) {
//                MessageViewController *messageSlideController = [[MessageViewController alloc] init];
//                self.messageSwitchVC = [[UINavigationController alloc] initWithRootViewController:messageSlideController];
//                [messageSlideController release];
                [[ConstObject instance] setReLoadMessageData:NO];
            }
            [menuCell.badgeView setHidden:YES];
            [self.mm_drawerController setCenterViewController:self.messageSwitchVC
                                       withFullCloseAnimation:YES completion:nil];
        }
    }
    else if(indexPath.row == 2){
        //切换到财富榜视图
//        [MobClick event:@"wealth_page_count"];
        //标记全局首页变量为NO
        [[ConstObject instance] setIsHomePage:NO];
        
        if (!self.wealthSwitchVC|| [[ConstObject instance] reLoadWealthData]) {
//            WealthListViewController *wealthSlideController = [[WealthListViewController alloc] init];
//            self.wealthSwitchVC = [[UINavigationController alloc] initWithRootViewController:wealthSlideController];
//            [wealthSlideController release];
            [[ConstObject instance] setReLoadWealthData:NO];
        }
        [menuCell.badgeView setHidden:YES];
        [self.mm_drawerController setCenterViewController:self.wealthSwitchVC
                                   withFullCloseAnimation:YES completion:nil];
        
    }
    else if (indexPath.row == 3){
        //切换到邀请好友视图
        [self toInviteFriendZaDan];
    }
    else if (indexPath.row == 4){
        //切换到免费试用视图
//        [MobClick event:@"free_use_page_count"];
        //标记全局首页变量为NO
        [[ConstObject instance] setIsHomePage:NO];
        if (!self.freeSwitchVC|| [[ConstObject instance] reLoadFreeUseData]) {
//            FreeUseViewController *freeSlideController = [[FreeUseViewController alloc] init];
//            self.freeSwitchVC = [[UINavigationController alloc] initWithRootViewController:freeSlideController];
//            [freeSlideController release];
            [[ConstObject instance] setReLoadFreeUseData:NO];
        }
        [self.mm_drawerController setCenterViewController:self.freeSwitchVC
                                   withFullCloseAnimation:YES completion:nil];
    }
    else if(indexPath.row == 5){
        //切换到金币商城视图
//        [MobClick event:@"gold_coin_mall_count"];
        //标记全局首页变量为NO
        [[ConstObject instance] setIsHomePage:NO];
        if (!self.goldCoinMallSwitchVC || [[ConstObject instance] reLoadMallData]) {
//            GoldCoinMallViewController *goldCoinMallViewController = [[GoldCoinMallViewController alloc] init];
//            goldCoinMallViewController.myCoinNum = myCoinNum;
//            self.goldCoinMallSwitchVC = [[UINavigationController alloc] initWithRootViewController:goldCoinMallViewController];
//            [goldCoinMallViewController release];
            [[ConstObject instance] setReLoadMallData:NO];
        }
        [self.mm_drawerController setCenterViewController:self.goldCoinMallSwitchVC
                                   withFullCloseAnimation:YES
                                               completion:nil];
    }
    else if(indexPath.row == 6){
        //切换到意见反馈视图
//        [MobClick event:@"set_feedback_count"];
        [super showMBProgressHUD:@"加载中..."];
//        [UMFeedback showFeedback:self withAppkey:@"52ae695f56240b08a41b0038"];
        [super hideMBProgressHUD];
    }
    else{
        //切换到精品应用视图
//        [MobClick event:@"command_app_count"];
        //标记全局首页变量为NO
        [[ConstObject instance] setIsHomePage:NO];
        if(!commandAppUrl){
            self.commandAppUrl = kCommandUrl;
        }
        
        if (!self.commandAppSwitchVC) {
//            CommandAppController *appController = [[CommandAppController alloc] init];
//            [appController initWithUrl:commandAppUrl andTitle:@"精品应用"];
//            self.commandAppSwitchVC = [[UINavigationController alloc] initWithRootViewController:appController];
//            [appController release];
        }
        [self.mm_drawerController setCenterViewController:self.commandAppSwitchVC
                                   withFullCloseAnimation:YES
                                               completion:nil];
        
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex{
    return 24.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    if (displayCommandAppVC) {
        return 8;
    }
    else{
        return 7;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenBounds.size.width, 24.0f)] autorelease];
    sectionView.backgroundColor = [UIColor clearColor];
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"MenuCell";
    MenuCell *cell = (MenuCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[[MenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row == 0) {
            [cell setBackgroundView:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuSelectedBackground.png"]] autorelease]];
        }else{
            [cell setBackgroundView:[[[UIImageView alloc] initWithImage:nil] autorelease]];
        }
    }
    
    switch (indexPath.row) {
        case 0:
            
            cell.iconImageView.image = [UIImage imageNamed:@"home.png"];
            cell.titleLabel.text = @"首页";
            menuCell = cell;
            cell.badgeView.hidden = YES;
            cell.newImageView.hidden = YES;
            cell.hotImageView.hidden = YES;
            //            cell.topLineImageView.hidden = NO;
            break;
        case 1:
            cell.iconImageView.image = [UIImage imageNamed:@"message.png"];
            cell.titleLabel.text = @"消息";
            cell.newImageView.hidden = YES;
            cell.hotImageView.hidden = YES;
            //newMessageCount 为零,不显示消息提醒
            if ([newMessageCount intValue] != 0) {
                [cell.badgeView setBadgeValue:newMessageCount];
                cell.badgeView.hidden = NO;
            }
            else{
                cell.badgeView.hidden = YES;
            }
            break;
        case 2:
            cell.iconImageView.image = [UIImage imageNamed:@"rich.png"];
            cell.titleLabel.text = @"福不死财富榜";
            cell.badgeView.hidden = YES;
            cell.newImageView.hidden = YES;
            cell.hotImageView.hidden = YES;
            break;
        case 3:
            cell.iconImageView.image = [UIImage imageNamed:@"inviteFri_leftView.png"];
            cell.titleLabel.text = @"邀请好友砸金蛋";
            cell.badgeView.hidden = YES;
            cell.newImageView.hidden = YES;
            cell.hotImageView.hidden = NO;
            break;
        case 4:
            cell.iconImageView.image = [UIImage imageNamed:@"free.png"];
            cell.titleLabel.text = @"免费试用";
            cell.badgeView.hidden = YES;
            cell.newImageView.hidden = YES;
            cell.hotImageView.hidden = YES;
            break;
        case 5:
            cell.iconImageView.image = [UIImage imageNamed:@"mall.png"];
            cell.titleLabel.text = @"金币商城";
            cell.badgeView.hidden = YES;
            cell.newImageView.hidden = YES;
            cell.hotImageView.hidden = YES;
            break;
        case 6:
            cell.iconImageView.image = [UIImage imageNamed:@"ideaFeedBack.png"];
            cell.titleLabel.text = @"意见反馈";
            cell.badgeView.hidden = YES;
            cell.newImageView.hidden = YES;
            cell.hotImageView.hidden = YES;
            break;
        case 7:
            cell.iconImageView.image = [UIImage imageNamed:@"qualityApp.png"];
            cell.titleLabel.text = @"精品应用";
            cell.badgeView.hidden = YES;
            cell.newImageView.hidden = YES;
            cell.hotImageView.hidden = YES;
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma --mark
#pragma --mark -EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
    [self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

- (void)doneLoadingTableViewData{
	reloading = NO;
	[refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:centerTableView];
    refreshHeaderView._statusLabel.text =  @"下拉更新个人信息";
    
}

- (void)reloadTableViewDataSource{
	reloading = YES;
    [self fetchProfileData];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    NSLog(@"[[ConstObject instance] isLogin]=%d",[[ConstObject instance] isLogin]);
    if (![CheckNetwork isExistenceNetwork] || ![[ConstObject instance] isLogin]){
        if ((![CheckNetwork isExistenceNetwork] && reloading) ||
            (![CheckNetwork isExistenceNetwork] &&
             (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height + 44)) || ![[ConstObject instance] isLogin]){
                [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
            }
    }
    
    
}

-(void)dealloc{
    
    [homeSwitchVC release];
    homeSwitchVC = nil;
    
    [messageSwitchVC release];
    messageSwitchVC = nil;
    
    [wealthSwitchVC release];
    wealthSwitchVC = nil;
    
    [setSwitchVC release];
    setSwitchVC = nil;
    
    [profileSwitchVC release];
    profileSwitchVC = nil;
    
    [freeSwitchVC release];
    freeSwitchVC = nil;
    
    [goldCoinMallSwitchVC release];
    goldCoinMallSwitchVC = nil;
    
    [commandAppSwitchVC release];
    commandAppSwitchVC = nil;
    
    [findSwitchVC release];
    findSwitchVC = nil;
    
    [myCoinNum release];
    [commandAppUrl release];
    
    [newMessageCount release];
    newMessageCount = nil;
    
    //移除 得到登录个人信息 通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kGetLoginUserInfo
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kShowNewestNumber
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"thirdLoginoutSucceed"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kCheckined
                                                  object:nil];
    [super dealloc];
}

@end