//
//  SSSetModel.h
//  ShunShunLiuXue
//
//  Created by AndyJerry on 15/9/14.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SSSetModelType) {
    SSSetModelTypeArrows, // 箭头
    SSSetModelTypeSwitch  // 开关
};

@interface SSSetModel : NSObject
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  类型
 */
@property (nonatomic, assign) SSSetModelType type;

/**
 *  分割线是否缩进
 */
@property (nonatomic, assign, getter=isRetract) BOOL retract;


+ (instancetype)modelWithTitle:(NSString *)title type:(SSSetModelType)type isRetract:(BOOL)isRetract;
@end
