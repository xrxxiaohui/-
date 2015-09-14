//
//  SheQuTableViewCell.h
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/14.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheQuTableViewCell : UITableViewCell{

    UILabel *nameLabel;//姓名
    UILabel *normalLabel;//回答该问题
    UILabel *zanNumberLabel;//赞个数
    UIButton *questionButton;//问题内容
    UIButton *answerButton;//回答
    UIButton *avarButton;//头像
    
}

@property(nonatomic,retain) UILabel *nameLabel;//姓名
@property(nonatomic,retain) UILabel *normalLabel;//回答该问题
@property(nonatomic,retain) UILabel *zanNumberLabel;//赞个数
@property(nonatomic,retain) UIButton *questionButton;//问题内容
@property(nonatomic,retain) UIButton *answerButton;//回答
@property(nonatomic,retain) UIButton *avarButton;//头像

@property(nonatomic,retain) UILabel *questionLabel;//问题内容
@property(nonatomic,retain) UILabel *answerLabel;//回答

@end
