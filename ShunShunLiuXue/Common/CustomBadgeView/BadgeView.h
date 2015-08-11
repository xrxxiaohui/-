//
//  BageView.h
//  BeautyMakeup
//
//  Created by hers on 13-12-16.
//  Copyright (c) 2013年 hers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeView : UIView{
    UIImageView  *badgeImageView;
    UILabel      *numberLabel;
}

@property(nonatomic,retain)UIImageView *badgeImageView;
@property(nonatomic,retain)UILabel *numberLabel;

// 初始化
- (id)initWithTarget:(UIView *)targetView originX:(float)aOriginX originY:(float)aOriginY badgeNumber:(NSString *)aBadgeNumber;

//移除Badge数字提醒视图
- (void)removeBadgeView;

//提醒赋值
- (void)setBadgeValue:(NSString *)badgeValue;

@end
