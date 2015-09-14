//
//  SelectTeacherViewCell.h
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/20.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTeacherViewCell : UITableViewCell{

    UILabel *nameLabel;//姓名
    UIImageView *avarImageView;//头像
    UILabel *normalLabel;//已回答n个问题
    UILabel *invertNumLabel;//n次访问

    UILabel *zanNumberLabel;//赞个数
    UILabel *saveNumberLabel;//问题内容
}

@property(nonatomic,retain)UILabel *nameLabel;//姓名
@property(nonatomic,retain)UIImageView *avarImageView;//头像
@property(nonatomic,retain)UILabel *normalLabel;//已回答n个问题
@property(nonatomic,retain)UILabel *invertNumLabel;//n次访问
@property(nonatomic,retain)UILabel *zanNumberLabel;//赞个数
@property(nonatomic,retain)UILabel *saveNumberLabel;//问题内容


@end
