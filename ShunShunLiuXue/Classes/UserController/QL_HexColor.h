//
//  QL_HexColor.h
//  qianlongwisebeijing
//
//  Created by ZhangMo's Mac on 14-6-23.
//  Copyright (c) 2014年 wisetrip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QL_HexColor : NSObject

/*
 * 十六进制颜色值转换成UIColor对象
 */
+ (UIColor *) hexStringToColor: (NSString *) stringToConvert;


/*
 *  UIColor对象转换成十六进制颜色值字符串
 */
+ (NSString *) changeUIColorToRGB:(UIColor *)color;

+ (UIImage*) createImageWithColor: (UIColor*) color;


@end
