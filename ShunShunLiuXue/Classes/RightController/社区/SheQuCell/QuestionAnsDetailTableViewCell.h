//
//  QuestionAnsDetailTableViewCell.h
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/25.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionAnsDetailTableViewCell : UITableViewCell

@property(nonatomic,retain) UIButton *avarButton;//头像
@property(nonatomic,retain) UILabel *nameLabel;//姓名
@property(nonatomic,retain) UILabel *zanNumberLabel;//赞个数
@property(nonatomic,retain) UILabel *answerLabel;//回答
@property(nonatomic,retain) UIImageView *lineImage;

@end
