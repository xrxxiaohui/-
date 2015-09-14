//
//  SSSetModel.m
//  ShunShunLiuXue
//
//  Created by AndyJerry on 15/9/14.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "SSSetModel.h"

@implementation SSSetModel
+ (instancetype)modelWithTitle:(NSString *)title type:(SSSetModelType)type isRetract:(BOOL)isRetract {
    SSSetModel *model = [[SSSetModel alloc] init];
    model.title = title;
    model.type = type;
    model.retract = isRetract;
    return model;
}
@end
