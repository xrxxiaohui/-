//
//  QuestionViewController.h
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/25.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHBasicViewController.h"
#import "AddAnswerViewController.h"

@class MoreCell;
@interface QuestionViewController : QHBasicViewController<UITableViewDataSource,UITableViewDelegate>{

    MoreCell *moreCell;
    int page;
}

@property(nonatomic,retain)NSMutableArray *tagArray;
@property(nonatomic,retain)NSMutableArray *answerListArray;
@property (nonatomic, retain)UIView *backgroundViews;
@property (nonatomic, retain)UIView *shareView;

-(void)initWithTitle:(NSString *)mainTitles andAnswerDic:(NSDictionary *)answerDic;
@end
