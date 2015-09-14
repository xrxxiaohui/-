//
//  MyAnswerViewController.h
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/9/8.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHBasicViewController.h"
#import "QHBasicViewController.h"
#import "SUNSlideSwitchView.h"
#import "AnswerSortByTimeViewController.h"
#import "AnswerSortByZanViewController.h"

@interface MyAnswerViewController : QHBasicViewController<SUNSlideSwitchViewDelegate>
@property (nonatomic, retain) SUNSlideSwitchView *slideSwitchView;
@property (nonatomic, retain) NSMutableArray *controllerArray;

@end

