//
//  DWTagList.h
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/20.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DWTagList;

@protocol DWTagListDelegate <NSObject>

- (void)tagsControl:(DWTagList *)tagsControl tappedAtIndex:(NSInteger)index;

@end


@interface DWTagList : UIView<UIGestureRecognizerDelegate>
{
    UIView *view;
    NSArray *textArray;
    CGSize sizeFit;
    UIColor *lblBackgroundColor;
}

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) NSMutableArray *textLabelArray;
@property (assign, nonatomic) id<DWTagListDelegate> tapDelegate;

- (void)setLabelBackgroundColor:(UIColor *)color;
- (void)setTags:(NSArray *)array;
- (void)display;
- (CGSize)fittedSize;



@end
