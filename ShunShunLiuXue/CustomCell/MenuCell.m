//
//  menuCell.m
//  BeautyMakeup
//
//  Created by hers on 13-11-7.
//  Copyright (c) 2013年 hers. All rights reserved.
//
#import "Define.h"
#import "MenuCell.h"
#import "BadgeView.h"

@implementation MenuCell

@synthesize titleLabel,topLineImageView,iconImageView,badgeView,newImageView,hotImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryNone;

        [self setSelectedBackgroundView:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuSelectedBackground.png"]] autorelease]];
        
        //顶部那条线
        topLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenBounds.size.width, 1.0f)];
        topLineImageView.backgroundColor = [UIColor clearColor];
        topLineImageView.image = [UIImage imageNamed:@"separatorLine.png"];
        topLineImageView.hidden = YES;
        [self addSubview:topLineImageView];
        [topLineImageView release];
        
        //图标
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12.0f, 8.0f, 36.0f, 35.0f)];
        iconImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:iconImageView];
        [iconImageView release];
        
        //标题
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 0.0f, 150.0f, 50.0f)];
//        titleLabel.font = kFontArialBoldMT15;
//        titleLabel.textColor = kLeftContentColor;
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        [titleLabel release];
        
        //提醒
        badgeView = [[BadgeView alloc] initWithTarget:self originX:100.0f originY:10.0f badgeNumber:@"0"];
        [badgeView release];
        badgeView.hidden = YES;
        
        newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(125.6f, 3.0f, 21.0f, 21.0f)];
        newImageView.backgroundColor = [UIColor clearColor];
        newImageView.image = [UIImage imageNamed:@"menuNew.png"];
        newImageView.hidden = YES;
        [self addSubview:newImageView];
        [newImageView release];
        
        //热 标示图标
        hotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(168.6f, 10.0f, 36.0f, 36.0f)];
        hotImageView.backgroundColor = [UIColor clearColor];
        hotImageView.image = [UIImage imageNamed:@"hot.png"];
        hotImageView.hidden = YES;
        [self addSubview:hotImageView];
        [hotImageView release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
