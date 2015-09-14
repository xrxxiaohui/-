//
//  SheQuViewController.h
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/11.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHBasicViewController.h"
#import "SliderViewController.h"

@class MoreCell;
@interface SheQuViewController : QHBasicViewController<UITableViewDataSource,UITableViewDelegate>{

    MoreCell *moreCell;
    int showMore;
    BOOL moreAction;
    int page;
}

//计算字符串size
- (CGSize)getStringSizeWith:(NSString*)_mystr boundingRectWithSize:(CGSize)_boundSize font:(UIFont*)font;
@end
