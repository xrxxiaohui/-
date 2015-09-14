//
//  SheQuTableViewCell.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/14.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "SheQuTableViewCell.h"
#import "Define.h"

@implementation SheQuTableViewCell
@synthesize nameLabel;
@synthesize normalLabel;
@synthesize zanNumberLabel;
@synthesize questionButton;
@synthesize answerButton;
@synthesize avarButton;
@synthesize answerLabel;
@synthesize questionLabel;


- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        //标题
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(14.0f, 12.6f, 50.0f, 13.0f)];
        nameLabel.font = kFontArial12;
        nameLabel.textColor = COLOR(172, 176, 182);
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.text = @"刘雨骁";
        [self addSubview:nameLabel];
        [nameLabel release];
        
        //回答该问题    提了个问题
        self.normalLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.right+8, 13.0f, 70.0f, 13.0f)];
        normalLabel.font = kFontArial12;
        normalLabel.textColor = COLOR(0xa9, 0xae, 0xb4);
        normalLabel.textAlignment = NSTextAlignmentLeft;
        normalLabel.text = @"回答该问题";
        normalLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:normalLabel];
        [normalLabel release];
        
        //头像button
        self.avarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [avarButton setFrame:CGRectMake(kScreenWidth-15-24, 10, 24, 24)];
        [avarButton.layer setMasksToBounds:YES];
        avarButton.layer.cornerRadius = 12;
        avarButton.layer.borderColor = [UIColor grayColor].CGColor;
        avarButton.layer.borderWidth = 0.1;
//        avarButton.backgroundColor = [UIColor greenColor];
        [self addSubview:avarButton];
        
        //赞label
        self.zanNumberLabel = [[UILabel alloc] init];
        [zanNumberLabel setFrame:CGRectMake(14, 65, 25, 11)];
        [zanNumberLabel setBackgroundColor:COLOR(0x64, 0xb3, 0xf1)];
        [zanNumberLabel setFont:kFontArial11];
        [zanNumberLabel setText:@"1.1k"];
        [zanNumberLabel setText:@"999"];
        [zanNumberLabel setTextColor:[UIColor whiteColor]];
        [zanNumberLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:zanNumberLabel];
        [zanNumberLabel release];
        
        UILabel *tempLabel = [[UILabel alloc] init];
        [tempLabel setFont:kFontArial16];
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.text = @"大学毕业三年还能参加留学吗大学毕业三年还能参加留学吗大学毕业三年还能参加留学吗大学毕业三年还能参加留学吗大学毕业三年还能参加留学吗？";
        tempLabel.textColor = [UIColor blackColor];
        [tempLabel setFrame:CGRectMake(nameLabel.frame.origin.x, 40, kScreenWidth-nameLabel.frame.origin.x*2, 16)];
        tempLabel.numberOfLines =1;
        self.questionLabel = tempLabel;
        
        
        //问题button
        self.questionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.questionButton.frame = tempLabel.frame;
//        self.questionButton.showsTouchWhenHighlighted = YES;
        self.questionButton.backgroundColor = [UIColor clearColor];
        [self addSubview:questionButton];
        [self addSubview:self.questionLabel];
        [tempLabel release];
        [questionLabel release];
        
        //回答label
        self.answerLabel = [[UILabel alloc] init];
        [answerLabel setFont:kFontArial14];
        answerLabel.backgroundColor = [UIColor clearColor];
        answerLabel.text = @"没有问题的，国外院校非常欢迎";
        answerLabel.textColor = COLOR(0x7b, 0x83, 0x8e);
        [answerLabel setFrame:CGRectMake(zanNumberLabel.width+zanNumberLabel.frame.origin.x+5, 64, kScreenWidth-zanNumberLabel.origin.x-zanNumberLabel.width-20, 35)];
        answerLabel.numberOfLines = 2;
        

        //回答button
        self.answerButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        10+zan大小＋10
        [answerButton setFrame:answerLabel.frame];
//        answerButton.showsTouchWhenHighlighted = YES;
        [self.answerButton setBackgroundColor:[UIColor clearColor]];
        [self addSubview:answerButton];
        
        [self addSubview:self.answerLabel];
        [answerLabel release];
    }
    return self;
}

-(void)dealloc{

     nameLabel=nil;
     normalLabel=nil;
     zanNumberLabel=nil;
    [questionButton release];
     questionButton=nil;
    [answerButton release];
     answerButton=nil;
    [avarButton release];
     avarButton=nil;
     answerLabel=nil;
     questionLabel=nil;
    
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
