//
//  DWTagList.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/20.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//


#import "DWTagList.h"
#import <QuartzCore/QuartzCore.h>

#define CORNER_RADIUS 12.0f
#define LABEL_MARGIN 12.0f   //label横间距
#define BOTTOM_MARGIN 15.0f
#define FONT_SIZE 14.0f
#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING 3.0f
#define BACKGROUND_COLOR [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00]
#define TEXT_COLOR [UIColor blackColor]
#define TEXT_SHADOW_COLOR [UIColor whiteColor]
#define TEXT_SHADOW_OFFSET CGSizeMake(0.0f, 1.0f)
#define BORDER_COLOR [UIColor lightGrayColor].CGColor
#define BORDER_WIDTH 1.0f

@implementation DWTagList

@synthesize view, textArray;
@synthesize tapDelegate;
@synthesize textLabelArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:view];
        self.textLabelArray = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void)setTags:(NSArray *)array
{
    textArray = [[NSArray alloc] initWithArray:array];
    sizeFit = CGSizeZero;
    [self display];
}

- (void)setLabelBackgroundColor:(UIColor *)color
{
    lblBackgroundColor = color;
    [self display];
}

- (void)display
{
    for (UILabel *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    float totalHeight = 0;
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    int tags = 0;
    for (NSString *text in textArray) {
        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:CGSizeMake(self.frame.size.width, 1500) lineBreakMode:UILineBreakModeWordWrap];
        textSize.width += HORIZONTAL_PADDING*2;
        textSize.height += VERTICAL_PADDING*2;
        UILabel *label = nil;
        if (!gotPreviousFrame) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
            totalHeight = textSize.height;
        } else {
            CGRect newRect = CGRectZero;
            if (previousFrame.origin.x + previousFrame.size.width + textSize.width + LABEL_MARGIN > self.frame.size.width) {
                newRect.origin = CGPointMake(0, previousFrame.origin.y + textSize.height + BOTTOM_MARGIN);
                totalHeight += textSize.height + BOTTOM_MARGIN;
            } else {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
            }
            newRect.size = textSize;
            label = [[UILabel alloc] initWithFrame:newRect];
        }
        previousFrame = label.frame;
        gotPreviousFrame = YES;
        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        if (!lblBackgroundColor) {
            [label setBackgroundColor:BACKGROUND_COLOR];
        } else {
            [label setBackgroundColor:lblBackgroundColor];
        }
        [label setBackgroundColor:[UIColor whiteColor]];

        [label setTextColor:[UIColor colorWithRed:101./255. green:180./255. blue:240./255. alpha:1]];
        [label setText:text];
        [label setTextAlignment:NSTextAlignmentCenter];
//        [label setShadowColor:TEXT_SHADOW_COLOR];
//        [label setShadowOffset:TEXT_SHADOW_OFFSET];
        [label.layer setMasksToBounds:YES];
        [label.layer setCornerRadius:CORNER_RADIUS];
        [label.layer setBorderColor:[UIColor colorWithRed:215./255. green:235./255. blue:250./255. alpha:1].CGColor];
        [label.layer setBorderWidth: BORDER_WIDTH];
        label.tag = tags;
        self.tag = tags;
        tags++;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
        [tapRecognizer setNumberOfTapsRequired:1];
        [tapRecognizer setDelegate:self];
        [self setUserInteractionEnabled:YES];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tapRecognizer];
        [self addSubview:label];
        [self.textLabelArray addObject:label];
    }
    sizeFit = CGSizeMake(self.frame.size.width, totalHeight + 1.0f);
}

- (void)gestureAction:(id)sender {
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    [tapDelegate tagsControl:self tappedAtIndex:tapRecognizer.view.tag];
}

- (CGSize)fittedSize
{
    return sizeFit;
}

@end
