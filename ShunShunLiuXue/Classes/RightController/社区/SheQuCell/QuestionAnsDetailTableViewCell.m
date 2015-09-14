//
//  QuestionAnsDetailTableViewCell.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/25.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "QuestionAnsDetailTableViewCell.h"

@implementation QuestionAnsDetailTableViewCell
@synthesize answerLabel;
@synthesize avarButton;
@synthesize nameLabel;
@synthesize zanNumberLabel;
@synthesize lineImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        //标题
        self.avarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [avarButton setFrame:CGRectMake(14.0f, 14.0f, 24.0f, 24.0f)];
       
        [avarButton.layer setMasksToBounds:YES];
        avarButton.layer.cornerRadius = 12;
        avarButton.layer.borderColor = [UIColor grayColor].CGColor;
        avarButton.layer.borderWidth = 0.1;
        //        avarButton.backgroundColor = [UIColor greenColor];
        [self addSubview:avarButton];
        
        //赞label
        self.zanNumberLabel = [[UILabel alloc] init];
        [zanNumberLabel setFrame:CGRectMake(13, avarButton.bottom+5, 25, 12)];
        [zanNumberLabel setBackgroundColor:COLOR(0x64, 0xb3, 0xf1)];
        [zanNumberLabel setFont:kFontArial11];
        [zanNumberLabel setText:@"1.1k"];
        [zanNumberLabel setText:@"999"];
        [zanNumberLabel setTextColor:[UIColor whiteColor]];
        [zanNumberLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:zanNumberLabel];
        [zanNumberLabel release];
        
        //名字
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.0f, 18.0f, kScreenWidth-65, 16.0f)];
        nameLabel.font = kFontArial16;
        nameLabel.textColor = COLOR(55, 60, 72);
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.text = @"刘雨骁";
        [self addSubview:nameLabel];
        [nameLabel release];
        
        //回答label
        self.answerLabel = [[UILabel alloc] init];
        [answerLabel setFont:kFontArial14];
        answerLabel.backgroundColor = [UIColor clearColor];
        answerLabel.text = @"没有问题的，国外院校非常欢迎";
        answerLabel.textColor = COLOR(0x7b, 0x83, 0x8e);
        [answerLabel setFrame:CGRectMake(45, avarButton.bottom+3, kScreenWidth-65, 35)];
        answerLabel.numberOfLines = 0;
        [self addSubview:self.answerLabel];
        [answerLabel release];
        
        self.lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(15,answerLabel.bottom+15 , kScreenWidth-15, 0.5)];
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
