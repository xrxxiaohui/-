//
//  AnswerSortByZanViewController.h
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/9/10.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "MoreCell.h"
#import "SheQuTableViewCell.h"
#import "AnswerDetailViewController.h"

@interface AnswerSortByZanViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *mainTableView;
    int page;
    int showMore;
    MoreCell *moreCell;
    BOOL moreAction;
    BOOL isFirstEnter;
}


@end
