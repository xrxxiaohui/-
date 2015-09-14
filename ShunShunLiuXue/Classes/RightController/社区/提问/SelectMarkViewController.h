//
//  SelectMarkViewController.h
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/9/7.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWTagList.h"
#import "UIFavoriteAlertView.h"
#import "QHBasicViewController.h"

@interface SelectMarkViewController : QHBasicViewController<DWTagListDelegate>
{
    DWTagList *tagList;
    UIButton *mentionButton;
}
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)NSMutableArray *tagArray;


@end
