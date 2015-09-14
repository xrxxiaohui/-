//
//  WenTiTableViewCell.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/9/10.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "WenTiTableViewCell.h"

@implementation WenTiTableViewCell
@synthesize careLabel;
@synthesize answerSomeQuestionLabel;
@synthesize questionLabel;
@synthesize lineImage;

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        
        self.questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth-30, 15)];
        questionLabel.font = [UIFont systemFontOfSize:15];
        questionLabel.textColor = COLOR(0x38, 0x3d, 0x49);
        questionLabel.textAlignment = NSTextAlignmentLeft;
        questionLabel.numberOfLines = 0;
        questionLabel.backgroundColor = [UIColor clearColor];
        questionLabel.text = @"";
        [self addSubview:questionLabel];
        [questionLabel release];
        
        //关注label
        self.careLabel = [[UILabel alloc] init];
        [careLabel setFont:kFontArial14];
        careLabel.backgroundColor = [UIColor clearColor];
        careLabel.text = @"10个关注";
        careLabel.textColor = COLOR(0xff, 0x3e, 0x30);
        careLabel.textAlignment = NSTextAlignmentLeft;
        [careLabel setFrame:CGRectMake(15, questionLabel.bottom+15, 70, 14)];
        careLabel.numberOfLines = 1;
        [self addSubview:self.careLabel];
        [careLabel release];

        //回答label
        self.answerSomeQuestionLabel = [[UILabel alloc] init];
        [answerSomeQuestionLabel setFont:kFontArial14];
        answerSomeQuestionLabel.backgroundColor = [UIColor clearColor];
        answerSomeQuestionLabel.text = @"10个回答";
        answerSomeQuestionLabel.textAlignment = NSTextAlignmentLeft;
        answerSomeQuestionLabel.textColor = COLOR(0xff, 0x3e, 0x30);
        [answerSomeQuestionLabel setFrame:CGRectMake(100, questionLabel.bottom+15, kScreenWidth-160, 14)];
        answerSomeQuestionLabel.numberOfLines = 1;
        [self addSubview:self.answerSomeQuestionLabel];
        [answerSomeQuestionLabel release];
        
        self.lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(15,answerSomeQuestionLabel.bottom+15 , kScreenWidth-15, 0.5)];
        lineImage.backgroundColor = COLOR1(227, 227, 227);
        //        bottomLineImageView.image = [UIImage imageNamed:@"dixian"];
        [self addSubview:lineImage];
        [lineImage release];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
