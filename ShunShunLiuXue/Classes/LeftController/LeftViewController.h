//
//  LeftViewController.h
//  Mei Zhuang
//
//  Created by Apple on 13-10-29.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "HomePageViewController.h"
#import "EGORefreshTableHeaderView.h"

@class MenuCell;
@interface LeftViewController : UITempletViewController<UITableViewDataSource, UITableViewDelegate,EGORefreshTableHeaderDelegate>{
    EGORefreshTableHeaderView   *refreshHeaderView;//上拉刷新
    BOOL                        reloading;//下拉刷新是否正在加载标示
    UITableView                 *centerTableView;//个人中心数据列表
    UINavigationController      *_navSlideSwitchVC;//首页视图
    UILabel                     *nickLabel;//昵称
    UIButton                    *loginButton;//马上登录
    UIButton                    *avatarButton;//头像
    NSString                    *newMessageCount;//新的提醒数
    BOOL                        fetchDataSucceed;//已成功获取数据标志
    BOOL                        displayCommandAppVC;//审核通过后，显示应用推荐
    MenuCell                    *menuCell;//记录上次点击cell
//  UIImageView                 *levelImageView;//等级logo   暂时屏蔽显示 布局不合理
    UIButton                    *checkinButton;//签到
    NSString                    *check_countString;//连续签到的天数
    NSString                    *check_leftString;//签到剩余的天数
    NSString                    *coinNumberString;//签到得到的金币
    NSString                    *nextCheckNumString;//下一个签到段奖励的金币数
}

@property (nonatomic, retain) UINavigationController *homeSwitchVC;
@property (nonatomic, retain) UINavigationController *messageSwitchVC;
@property (nonatomic, retain) UINavigationController *wealthSwitchVC;
@property (nonatomic, retain) UINavigationController *setSwitchVC;
@property (nonatomic, retain) UINavigationController *checkinSwitchVC;
@property (nonatomic, retain) UINavigationController *profileSwitchVC;
@property (nonatomic, retain) UINavigationController *freeSwitchVC;
@property (nonatomic, retain) UINavigationController *goldCoinMallSwitchVC;
@property (nonatomic, retain) UINavigationController *commandAppSwitchVC;
@property (nonatomic, retain) UINavigationController *inviteFriendSwitchVC;
@property (nonatomic, retain) UINavigationController *findSwitchVC;
@property (nonatomic, retain) NSString               *myCoinNum;//我的金币数量
@property (nonatomic, retain) NSString               *commandAppUrl;//应用推荐地址
@property (nonatomic, retain) NSString               *newMessageCount;
@property (nonatomic, retain) NSString               *check_countString;
@property (nonatomic, retain) NSString               *check_leftString;
@property (nonatomic, retain) NSString               *coinNumberString;
@property (nonatomic, retain) NSString               *nextCheckNumString;

@end
