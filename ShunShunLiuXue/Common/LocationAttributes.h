//
//  LocationAttributes.h
//  BeautyMakeup
//
//  Created by nuohuan on 14-3-3.
//  Copyright (c) 2014年 hers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationAttributes : NSObject

@property (copy, nonatomic) NSString *country;//国家
@property (copy, nonatomic) NSString *state;//省
@property (copy, nonatomic) NSString *city;//市
@property (copy, nonatomic) NSString *district;//区域
@property (copy, nonatomic) NSString *street;//街道
@property (nonatomic) double latitude;//纬度
@property (nonatomic) double longitude;//经度

@end
