//
//  SelectTeacherTableViewCell.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/28.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "SelectTeacherTableViewCell.h"

@implementation SelectTeacherTableViewCell
@synthesize avarButton;
@synthesize careButton;
@synthesize careNumberLabel;
@synthesize nameLabel;
@synthesize zanButton;
@synthesize zanNumberLabel;
@synthesize answerSomeQuestionLabel;
@synthesize lineImage;
@synthesize inviteLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        //标题
        self.avarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [avarButton setFrame:CGRectMake(15.0f, 15.0f, 54, 54)];
        
        [avarButton.layer setMasksToBounds:YES];
        avarButton.layer.cornerRadius = 8;
        avarButton.layer.borderColor = [UIColor grayColor].CGColor;
        avarButton.layer.borderWidth = 0.1;
        //        avarButton.backgroundColor = [UIColor greenColor];
        [self addSubview:avarButton];
        
        //名字
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(avarButton.right+15, 15.0f, kScreenWidth-80-80, 16.0f)];
        nameLabel.font = kFontArial16;
        nameLabel.textColor = COLOR(0x38, 0x3d, 0x49);
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.text = @"刘雨骁";
        [self addSubview:nameLabel];
        [nameLabel release];
        
        //回答label
        self.answerSomeQuestionLabel = [[UILabel alloc] init];
        [answerSomeQuestionLabel setFont:kFontArial15];
        answerSomeQuestionLabel.backgroundColor = [UIColor clearColor];
        answerSomeQuestionLabel.text = @"已回答10个问题";
        answerSomeQuestionLabel.textColor = COLOR(255, 0, 0);
        [answerSomeQuestionLabel setFrame:CGRectMake(avarButton.right+15, nameLabel.bottom+3, kScreenWidth-160, 14)];
        answerSomeQuestionLabel.numberOfLines = 0;
        [self addSubview:self.answerSomeQuestionLabel];
        [answerSomeQuestionLabel release];
        
        self.zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [zanButton setBackgroundImage:[UIImage imageNamed:@"zanTeacher"] forState:UIControlStateNormal];
        [zanButton setFrame:CGRectMake(avarButton.right+15, answerSomeQuestionLabel.bottom+8, 34, 13)];
        [self addSubview:zanButton];
        
        //赞label
        self.zanNumberLabel = [[UILabel alloc] init];
        [zanNumberLabel setFrame:CGRectMake(17, 2, 30, 10)];
        [zanNumberLabel setFont:kFontArial8];
        [zanNumberLabel setText:@"1.1k"];
        [zanNumberLabel setText:@"999"];
        [zanNumberLabel setTextColor:[UIColor whiteColor]];
        [zanNumberLabel setTextAlignment:NSTextAlignmentLeft];
        [self.zanButton addSubview:zanNumberLabel];
        [zanNumberLabel release];
        
        self.careButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [careButton setBackgroundImage:[UIImage imageNamed:@"careTeacher"] forState:UIControlStateNormal];
        [careButton setFrame:CGRectMake(zanButton.right+10, answerSomeQuestionLabel.bottom+8, 34, 13)];
        [self addSubview:careButton];
        
        //关注label
        self.careNumberLabel = [[UILabel alloc] init];
        [careNumberLabel setFrame:CGRectMake(17, 2, 30, 10)];
        [careNumberLabel setFont:kFontArial8];
        [careNumberLabel setText:@"1.1k"];
        [careNumberLabel setText:@"99"];
        [careNumberLabel setTextColor:[UIColor whiteColor]];
        [careNumberLabel setTextAlignment:NSTextAlignmentLeft];
        [self.careButton addSubview:careNumberLabel];
        [careNumberLabel release];
        
        self.inviteLabel = [[UILabel alloc] init];
        [inviteLabel setFrame:CGRectMake(kScreenWidth-120, 15, 105, 15)];
        [inviteLabel setFont:kFontArial16];
        [inviteLabel setText:@"0次访问"];
        inviteLabel.textColor = COLOR(255, 0, 0);
        [inviteLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:inviteLabel];
        [inviteLabel release];
        
        self.lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(15,avarButton.bottom+15 , kScreenWidth-15, 0.5)];
        lineImage.backgroundColor = COLOR1(227, 227, 227);
        //        bottomLineImageView.image = [UIImage imageNamed:@"dixian"];
        [self addSubview:lineImage];
        [lineImage release];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
