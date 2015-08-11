//
//  BageView.m
//  BeautyMakeup
//
//  Created by hers on 13-12-16.
//  Copyright (c) 2013年 hers. All rights reserved.
//
#import "Define.h"
#import "BadgeView.h"



@implementation BadgeView
@synthesize badgeImageView,numberLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    
    return self;
}


#pragma --mark
#pragma --mark ---Functions
- (id)initWithTarget:(UIView *)targetView originX:(float)aOriginX originY:(float)aOriginY badgeNumber:(NSString *)aBadgeNumber{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(aOriginX, aOriginY, 31.0f, 30.0f);
        
        self.badgeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-3.0f, 0.0f, 31.0f, 30.0f)];
        [badgeImageView setImage:[UIImage imageNamed:@"badgeBackground.png"]];
        [self addSubview:badgeImageView];
        [badgeImageView release];
        
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(3.0f, 7.0f, 20.0f, 15.0f)];
        numberLabel.backgroundColor = [UIColor clearColor];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = [UIColor whiteColor];//kUserNameColor;
        numberLabel.font = [UIFont fontWithName:@"ArialHebrew" size:13.0f];
        numberLabel.text = aBadgeNumber;
        [self addSubview:numberLabel];
        [numberLabel release];
        
        [targetView addSubview:self];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    [numberLabel setText:badgeValue];
}

- (void)removeBadgeView{
    [self removeFromSuperview];
}



- (void)dealloc{

    [badgeImageView release];
    [numberLabel release];
    [super dealloc];
}


@end
