//
//  LoadingView.m
//  ChuanDaZhi
//
//  Created by hers on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "Define.h"
#import "LoadingView.h"
#import "QuartzCore/QuartzCore.h"

static LoadingView *loadView = nil;

@implementation LoadingView

@synthesize badgeView,tipsView,remindImageView;


#pragma --mark
#pragma --mark ---单例方法

+ (LoadingView *) sharedManager {
	if (!loadView)
		loadView = [[self alloc] init];
	return loadView;
	
}

#pragma --mark
#pragma --mark ---Functions
- (void)showBadgeView:(UIView *)targetView originX:(float)aOriginX originY:(float)aOriginY badgeNumber:(NSString *)aBadgeNumber{
    
    badgeView = [[UIImageView alloc] initWithFrame:CGRectMake(aOriginX, aOriginY, 31.0f, 30.0f)];
    [badgeView setImage:[UIImage imageNamed:@"badgeBackground.png"]];
    
    UILabel* numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 7.0f, 20.0f, 15.0f)];
    numberLabel.backgroundColor = [UIColor clearColor];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.textColor = [UIColor whiteColor];
    [numberLabel sizeToFit];
    numberLabel.font = [UIFont fontWithName:@"ArialHebrew" size:13.0f];
    numberLabel.text = aBadgeNumber;
    [badgeView addSubview:numberLabel];
    [numberLabel release];
    
    [targetView addSubview:badgeView];
    [badgeView release];    
}

- (void)removeBadgeView{
    if (self.badgeView) {
        [self.badgeView removeFromSuperview];
    }
}

- (void)showView:(UIView*)targetView message:(NSString*)aMessage originX:(float)aOriginX originY:(float)aOriginY delay:(float)aInterval{
    [self stopAnimation];
    [self settingView:targetView message:aMessage position:aOriginX height:aOriginY];
    [NSTimer scheduledTimerWithTimeInterval:aInterval  target:self selector:@selector(stopAnimation) userInfo:nil repeats:NO];
}

- (void)settingView:(UIView*)view message:(NSString*)msg position:(CGFloat)pstion height:(CGFloat)h
{
    CGSize msgSize = [msg sizeWithFont:[UIFont boldSystemFontOfSize:15]
                constrainedToSize:CGSizeMake(200.0f, CGFLOAT_MAX)
                    lineBreakMode:NSLineBreakByCharWrapping];
    //普通文字提示视图
    self.tipsView = [[UIView alloc]initWithFrame:CGRectMake(pstion, h, msgSize.width+20.0f,msgSize.height + 20.0f)];
    [tipsView.layer setCornerRadius:8.0];
    [tipsView.layer setMasksToBounds:YES];
    tipsView.backgroundColor = [UIColor blackColor];
    tipsView.alpha = 0.9f;
    [view addSubview:tipsView];
    [tipsView release];
    
    //文字提示
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, 0.0f, tipsView.frame.size.width-10.0f, tipsView.frame.size.height)];
    lab.text = msg;
    lab.textAlignment = UITextAlignmentCenter;
    lab.numberOfLines = 0;
    lab.font = [UIFont boldSystemFontOfSize:15];
    lab.textColor = [UIColor whiteColor];
    lab.backgroundColor = [UIColor clearColor];
    [tipsView addSubview:lab];
    [lab release];
    
    //设置视图中心点 确保文字过多时 整体居中显示
    tipsView.center = CGPointMake(kScreenBounds.size.width/2, h);
}

- (void)stopAnimation {
    if (tipsView ==nil) {
        return;
    }
    [tipsView removeFromSuperview];
    [tipsView release];
    tipsView = nil;
}

- (void)showCustomAlertViewAnimation:(UIView *)superView{
    
    CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	
	transformAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.20, 1.20, 1.00)],
								  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.00)],
								  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.00, 1.00, 1.00)]];
	transformAnimation.keyTimes = @[@0.0, @0.5, @1.0];
	
	CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	opacityAnimation.fromValue = @0.5;
	opacityAnimation.toValue = @1.0;
	
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.animations = @[transformAnimation, opacityAnimation, opacityAnimation];
	animationGroup.duration = 0.2;
	animationGroup.fillMode = kCAFillModeForwards;
	animationGroup.removedOnCompletion = NO;
	
	[superView.layer addAnimation:animationGroup forKey:@"showAlert"];
    
}

- (void)showFatieRemind:(UIView*)targetView message:(NSString*)aMessage coinNum:(NSInteger)coinNums delay:(float)aInterval rewardCoin:(NSInteger)aRewardCoin
{
    //背景图
    remindImageView = [[UIImageView alloc] init];
    remindImageView.frame = CGRectMake(kScreenBounds.origin.x, kScreenBounds.origin.y-20, kScreenBounds.size.width, kScreenBounds.size.height+20);
    UIImage *remindImage_ip4 = [UIImage imageNamed:@"fatieRemind_4.png"];
    UIImage *remindImage_ip5 = [UIImage imageNamed:@"fatieRemind_5.png"];
    if (iPhone5) {
        [remindImageView setImage:remindImage_ip5];
    }else{
        [remindImageView setImage:remindImage_ip4];
    }
    remindImageView.userInteractionEnabled = YES;
    [targetView addSubview:remindImageView];
    [remindImageView release];
    
    //发帖成功内容提示
    UILabel *RemindConLabel = [[UILabel alloc] init];
    [RemindConLabel setBackgroundColor:[UIColor clearColor]];
    //发秀帖/美妆帖
    if (coinNums > 0) {
        if (iPhone5) {
            [RemindConLabel setFrame:CGRectMake(145, 260, 90, 20)];
        }else{
            [RemindConLabel setFrame:CGRectMake(145, 215, 90, 20)];
        }
    }
    //问答帖/私房话帖/热门贴
    else{
        //发帖没有悬赏金币
        if (aRewardCoin == 0) {
            if (iPhone5) {
                [RemindConLabel setFrame:CGRectMake(145, 280, 90, 20)];
            }else{
                [RemindConLabel setFrame:CGRectMake(145, 235, 90, 20)];
            }
        }
        //发帖有悬赏金币
        else{
            if (iPhone5) {
                [RemindConLabel setFrame:CGRectMake(145, 255, 90, 70)];
            }else{
                [RemindConLabel setFrame:CGRectMake(145, 210, 90, 70)];
            }
        }
    }
    
    [RemindConLabel setText:aMessage];
    RemindConLabel.lineBreakMode = NSLineBreakByCharWrapping;
    RemindConLabel.numberOfLines = 0;
    [RemindConLabel setTextColor:kGreenColor];
    [RemindConLabel setFont:kFontArialBoldMT14];
    [remindImageView addSubview:RemindConLabel];
    [RemindConLabel release];
    
    //发帖获得的金币数
    UILabel *coinGetLabel = [[UILabel alloc] init];
    [coinGetLabel setBackgroundColor:[UIColor clearColor]];
    [coinGetLabel setFrame:CGRectMake(RemindConLabel.frame.origin.x, RemindConLabel.frame.origin.y+RemindConLabel.frame.size.height+15, 40, 20)];
    [coinGetLabel setTextColor:kGreenColor];
    [coinGetLabel setFont:kFontArial22];
    [remindImageView addSubview:coinGetLabel];
    coinGetLabel.text = [NSString stringWithFormat:@"+%d",coinNums];
    [coinGetLabel release];
    
    //金币图片
    UIImageView *coinImageView = [[UIImageView alloc] init];
    coinImageView.frame = CGRectMake(coinGetLabel.frame.origin.x+coinGetLabel.frame.size.width, coinGetLabel.frame.origin.y+1, 17, 17);
    [coinImageView setImage:[UIImage imageNamed:@"[jinBi].png"]];
    [remindImageView addSubview:coinImageView];
    [coinImageView release];
    [NSTimer scheduledTimerWithTimeInterval:aInterval  target:self selector:@selector(hideRemindView) userInfo:nil repeats:NO];
    
    //发秀帖/美妆帖
    if (coinNums > 0) {
        coinGetLabel.hidden = NO;
        coinImageView.hidden = NO;
    }
    //问答帖/私房话帖/热门贴
    else{
        coinGetLabel.hidden = YES;
        coinImageView.hidden = YES;
    }
}

- (void)hideRemindView{
    if (remindImageView ==nil) {
        return;
    }
    [remindImageView removeFromSuperview];
    remindImageView = nil;
}

#pragma mark -- 升级动画显示
//发帖/回复成功后 主视图升级动画显示
- (void)showUpgradeGif:(UIView *)mainView{
    upgradeGifView = [[UIView alloc] init];
    upgradeGifView.backgroundColor = [UIColor blackColor];
    upgradeGifView.alpha = 0.5;
    [upgradeGifView setFrame:CGRectMake(0, 0, kScreenBounds.size.width, kScreenBounds.size.height+20)];
    [mainView addSubview:upgradeGifView];
    
    //调出展示图gif
    NSURL *fileUrl = [NSURL URLWithString:[[ConstObject instance] upgradeGifString]];
    upgradeGifImageView = [[SCGIFImageView alloc] initWithGIFData:[NSData dataWithContentsOfURL:fileUrl]];
    if (iphoneTypeAbove5) {
        upgradeGifImageView.frame = CGRectMake(0,90, 320, 363);
    }else{
        upgradeGifImageView.frame = CGRectMake(0,80, 320, 363);
    }
    upgradeGifImageView.backgroundColor = [UIColor clearColor];
    upgradeGifImageView.userInteractionEnabled = YES;
    [mainView addSubview:upgradeGifImageView];
    [upgradeGifImageView release];
    [upgradeGifView release];
    
    [NSTimer scheduledTimerWithTimeInterval:3.5  target:self selector:@selector(hideUpgradeGifView) userInfo:nil repeats:NO];
}

//隐藏升级动画
- (void)hideUpgradeGifView{
    if (upgradeGifView ==nil) {
        return;
    }
    [upgradeGifView removeFromSuperview];
    upgradeGifView = nil;
    
    [upgradeGifImageView removeFromSuperview];
    upgradeGifImageView = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)dealloc{
    
    [badgeView release];
    [tipsView release];
    [remindImageView release];
    
    [super dealloc];
}

@end
