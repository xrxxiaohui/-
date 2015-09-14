//
//  MyCareViewController.h
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/9/8.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHBasicViewController.h"
#import "SUNSlideSwitchView.h"

@interface MyCareViewController : QHBasicViewController<SUNSlideSwitchViewDelegate>

@property (nonatomic, retain) SUNSlideSwitchView *slideSwitchView;
@property (nonatomic, retain) NSMutableArray *controllerArray;
@end
