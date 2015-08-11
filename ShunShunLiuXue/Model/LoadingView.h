//
//  LoadingView.h
//  ChuanDaZhi
//
//  Created by hers on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCGIFImageView.h"
#import "ConstObject.h"

@class UIWaitingView;

@interface LoadingView : UIView{
    UIView        *tipsView;//普通文案提示视图
    UIImageView   *badgeView;//badge数字提醒视图
    UIView        *gifBgView;//连续播放几张图片
    UIImageView   *remindImageView;//发帖成功弹出背景图
    UIView            *upgradeGifView;//升级动画显示背景视图
    SCGIFImageView    *upgradeGifImageView;//升级动画
}

@property(nonatomic,retain) UIImageView *badgeView;
@property(nonatomic,retain) UIView *tipsView;
@property(nonatomic,retain) UIImageView *remindImageView;

// 单例方法
+ (LoadingView *) sharedManager;

// 加载Badge数字提醒视图
- (void)showBadgeView:(UIView *)targetView originX:(float)aOriginX originY:(float)aOriginY badgeNumber:(NSString *)aBadgeNumber;

//移除Badge数字提醒视图
- (void)removeBadgeView;

//普通文案提示
- (void)showView:(UIView*)targetView message:(NSString*)aMessage originX:(float)aOriginX originY:(float)aOriginY delay:(float)aInterval;

//自定义弹出框（用于金币商品兑换成功提示和砸中金蛋提交地址成功后的提示）
- (void)showCustomAlertViewAnimation:(UIView *)superView;

//取消提示视图
- (void)stopAnimation;

//主视图发帖成功后提示弹出框
- (void)showFatieRemind:(UIView*)targetView message:(NSString*)aMessage coinNum:(NSInteger)coinNums delay:(float)aInterval rewardCoin:(NSInteger)aRewardCoin;//各参数含义：父视图、提示内容、奖励金币、持续时间、是否悬赏金币


//发帖/回复成功后 主视图升级动画显示 (动画出现在主视图)
- (void)showUpgradeGif:(UIView *)mainView;

@end
