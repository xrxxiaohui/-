//
//  config.h
//  01-UITableVeiw03-通过代码自定义cell
//
//  Created by lolex on 14-9-11.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#pragma mark - 屏幕相关
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceFrame [UIScreen mainScreen].bounds
#define BASEHEIGHT 480.0f

#define kDeviceStatusHeight 20.0
#define kDeviceNaviHeight 44.0
#define kViewOrignY 64.0

//基于6适配其他尺寸
#define HeightScale_IOS6(height) ((height/667.0) * SCREEN_HEIGHT)
#define WidthScale_IOS6(width) ((width/375.0) * SCREEN_WIDTH)



//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]



//----------------------文字类--------------------------
#define fontSize_parent  13.0f
#define fontSize_sub 11.0f
#define fontSize_nomal 15.0f


//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define FONT_BLACKCOLOR UIColorFromRGB(0x666666)
#define FONT_GRAYCOLOR UIColorFromRGB(0x999999)

//字体
#define FONTNAME        @"Helvetica"
#define FONTNAME_BOLD   @"Helvetica-Bold"
#define FONTNAME_LIGHT  @"HelveticaNeue-Light"

#define SUAGAREIGHTARRAY @[@"凌晨",@"空腹",@"早后",@"午前",@"午后",@"晚前",@"晚后",@"睡前"]


#ifndef _1_UITableVeiw03________cell_config_h
#define _1_UITableVeiw03________cell_config_h

//cell的边框宽度
#define kCellBorderT 5
#define kCellBorderL 10

//头像的宽高
#define kIconWH 40

//单位标签行高会员图标的宽高
#define kLabelH 15

//配图的kuangao
#define kImage 70
#define kImageW 70
#define kImageH 50

#define kImageW_shopList 65
#define kImageH_shopList 63


//昵称字体大小
#define kNameFont  [UIFont systemFontOfSize:10]

//时间字体大小
#define kTimeFont  [UIFont systemFontOfSize:12]

//来源字体大小
#define kSourceFont  [UIFont systemFontOfSize:12]

//正文字体大小
#define kContentFont  [UIFont systemFontOfSize:14]

#endif
