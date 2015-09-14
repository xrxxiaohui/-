//
//  LeftTableViewCell.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/29.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell
@synthesize myTitleLabel;
@synthesize categoryImageView;
@synthesize linesImageView;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryNone;
        self.categoryImageView = [[UIImageView alloc] init];
        [categoryImageView setFrame:CGRectMake(25, 5, 25, 25)];
        [self addSubview:categoryImageView];
        [categoryImageView release];
        
        self.myTitleLabel = [[UILabel alloc] init];
        [myTitleLabel setFrame:CGRectMake(categoryImageView.right+15, 10, 120, 17)];
        [myTitleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [myTitleLabel setTextColor:COLOR(0x38, 0x3d, 0x49)];
        [self addSubview:myTitleLabel];
        [myTitleLabel release];
        
        self.linesImageView = [[UIImageView alloc] init];
        [linesImageView setFrame:CGRectMake(60, 43, kScreenWidth-60, 1)];
        [linesImageView setBackgroundColor:COLOR(0xe5, 0xe5, 0xe5)];
        [self addSubview:linesImageView];
        [linesImageView release];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
