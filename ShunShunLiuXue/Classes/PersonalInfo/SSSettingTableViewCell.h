//
//  SSSettingTableViewCell.h
//  ShunShunLiuXue
//
//  Created by AndyJerry on 15/9/14.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSSetModel;
extern NSString * const SSSettingTableViewCellID;
@interface SSSettingTableViewCell : UITableViewCell

@property (nonatomic, strong) SSSetModel *setModel;

@end
