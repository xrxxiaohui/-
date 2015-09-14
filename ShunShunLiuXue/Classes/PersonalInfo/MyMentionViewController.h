//
//  MyMentionViewController.h
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/9/8.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHBasicViewController.h"
#import "MoreCell.h"
#import "WenTiTableViewCell.h"
#import "QuestionViewController.h"

@interface MyMentionViewController : QHBasicViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *mainTableView;
    int page;
    int showMore;
    MoreCell *moreCell;
    BOOL moreAction;
    BOOL isFirstEnter;
    
}


@end
