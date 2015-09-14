//
//  UITempletViewController.h
//  ChuanDaZhi
//
//  Created by hers on 13-6-5.
//  Copyright (c) 2013年 hers. All rights reserved.
//
#import "Define.h"
#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Define.h"
#import "CommonModel.h"
#import "EGORefreshTableHeaderView.h"
#import "ConstObject.h"
#import "LoadingView.h"
#import "CheckNetwork.h"
//#import "MobClick.h"
#import "JSONKit.h"
#import "SCGIFImageView.h"
#import "UIButton+WebCache.h"
#import "AppDelegate.h"
#import "MJRefresh.h"


@interface UITempletViewController : UIViewController<UIAlertViewDelegate>{
    UIButton          *returnbutton;//左导航按钮
    UIButton          *rightBtn;//右导航按钮
    CommonModel       *commonModel;
    UIView            *blackViews;
    SCGIFImageView    *gifViews;
    UIImageView       *zaKaiDanImageViews;
    UILabel           *jinBiTextLabels;
    UIView            *backgroundView;//修改背景图
}

@property (nonatomic,retain) UIButton *returnbutton;
@property (nonatomic,retain) UIButton *rightBtn;


//NavBar设置
- (void)initNavBarItems:(NSString *)titlename;

//NavBar左右按钮
- (void)addButtonReturn:(NSString *)image lightedImage:(NSString *) aLightedImage selector:(SEL)buttonClicked;

- (void)addRightButton:(NSString *)image  lightedImage:(NSString *) aLightedImage selector:(SEL)pushPastView;

//隐藏navigation bar
- (void)hideNavBarItems;

//显示navigation bar
- (void)noHideNavBarItems;

//解析数据
- (NSDictionary *)parseJsonRequest:(ASIHTTPRequest *) request;

//显示文字加载提示
- (void)showMBProgressHUD:(NSString *)title;

//隐藏加载提示
- (void)hideMBProgressHUD;

//显示文字加载提示 提问和回答专用
- (void)showMBProgressHUDOnlyForAskAndAnswer:(NSString *)title offsetY:(float)anOffsetY;

//检查登录状态
- (BOOL)checkLoginStatus:(NSDictionary *)aDict currentController:(UIViewController *)presentLoginController;

//提示网络状态
- (BOOL)checkNetworkStatus;

//显示UIAlert提示框
- (void)showMessageBox:(id)aDelegate title:(NSString *)aTitle  message:(NSString *)aMessage cancel:(NSString *)aCancel confirm:(NSString *)aConfirm;

//获取文件路径
- (NSString *)fileTextPath:(NSString *)fileName;

//获取账户UID
- (NSString *)readUid;

//获取设别唯一标识
- (NSString *)getDeviceIdentifier;

//用户积分墙的手机标志
- (NSString *)getDeviceIdentifierForWall;

//获取账户昵称
- (NSString *)readNickName;

//分析用户等级，显示等级logo
- (void)analyzeUserLevel:(NSString *)aLevel andImageView:(UIButton *)levelButton;

//用户肤质类型
- (NSString *)showUserSkin:(NSString *)userSkinString;

//砸金蛋界面
- (void)showTheGif:(UIView *)mainView;

//显示官方、顾问、专家、达人回答标志
- (void)showSpecialIcon:(UIButton *)sender level:(NSString *)levelString;

//保存当前cookie
- (void)saveCookies;

//重载cookie
- (void)reloadStoredCookies;

//清除当前cookie
- (void)deleteCookies;

//计算元宝数
- (NSArray *)countYuanBao:(NSString *)coinNumber;

//出登录提示
- (void)showLoginTips:(UIViewController *)aController;

//显示登录页面
- (void)showLoginController:(UIViewController *)aController;

//播放网络视频
- (void)playVideo:(NSString *)vUrl presentController:(UIViewController *)aController;

//主视图内容显示 不含表情时、字数在80字内 字数内容截取
- (NSString *)contentMainView:(NSString *)content;

//获取账户性别
- (NSString *)readFemale;

- (BOOL) isBlankString:(NSString *)string;
- (BOOL) isBlankDictionary:(NSDictionary *)dictionary;
//时间戳转时间
-(NSString *)transformTime:(NSString *)originTime;
//计算字符串size
- (CGSize)getStringSizeWith:(NSString*)_mystr boundingRectWithSize:(CGSize)_boundSize font:(UIFont*)font;
//获取token
-(NSString *)userToken;
//删除token
-(void)deleteToken;
//获取account信息
-(NSDictionary *)accountInfo;
//获取uid
-(NSString *)userIDs;
-(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
//字符串简单处理
-(NSString *)trimString:(NSString *)tempString;
@end
