//
//  AnswerDetailViewController.h
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/24.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHBasicViewController.h"
#import "LoginViewController.h"

@interface AnswerDetailViewController : QHBasicViewController{

    UIScrollView *mainScrollView;
}

-(void)initWithTitle:(NSString *)mainTitles andAnswerDic:(NSDictionary *)answerDic;
@end
