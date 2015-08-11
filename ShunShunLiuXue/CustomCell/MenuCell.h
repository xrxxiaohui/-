//
//  menuCell.h
//  BeautyMakeup
//
//  Created by hers on 13-11-7.
//  Copyright (c) 2013年 hers. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BadgeView;

@interface MenuCell : UITableViewCell{
    UILabel        *titleLabel;      //标题
    UIImageView    *iconImageView;   //图标
    BadgeView      *badgeView;       //数字消息提醒
    UIImageView    *newImageView;         //新上线功能标识
    UIImageView    *hotImageView;         //热 标识
}

@property(nonatomic,retain) UILabel      *titleLabel;
@property(nonatomic,retain) UIImageView  *topLineImageView;//第一个cell顶部分割线
@property(nonatomic,retain) UIImageView  *iconImageView;
@property(nonatomic,retain) BadgeView    *badgeView;
@property(nonatomic,retain) UIImageView  *newImageView;
@property(nonatomic,retain) UIImageView  *hotImageView;

@end
