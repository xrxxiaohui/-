//
//  SelectTeacherTableViewCell.h
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/28.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTeacherTableViewCell : UITableViewCell

@property(nonatomic,retain) UIButton *avarButton;//头像
@property(nonatomic,retain) UILabel *nameLabel;//姓名

@property(nonatomic,retain) UILabel *answerSomeQuestionLabel;//回答n个问题
@property(nonatomic,retain) UILabel *zanNumberLabel;//赞个数
@property(nonatomic,retain) UILabel *careNumberLabel;//关注个数
@property(nonatomic,retain) UILabel *inviteLabel;//访问n次

@property(nonatomic,retain) UIButton *zanButton;//赞背景图button
@property(nonatomic,retain) UIButton *careButton;//关注背景图button
@property(nonatomic,retain) UIImageView *lineImage;

//@property(nonatomic,retain) UILabel *questionLabel;//问题内容
//@property(nonatomic,retain) UILabel *answerLabel;//回答

@end
