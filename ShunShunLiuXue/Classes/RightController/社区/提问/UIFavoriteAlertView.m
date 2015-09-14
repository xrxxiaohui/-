//
//  UIFavoriteAlertView.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/20.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "UIFavoriteAlertView.h"

#import <QuartzCore/QuartzCore.h>

#define TAG_IMAGEVIE_BKG 11
#define TAG_LABEL  12
#define LABEL_WIDTH  280


@implementation UIFavoriteAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
		
		// 背景图片
		UIImageView *imageviewBkg = [[UIImageView alloc]init];
		[imageviewBkg setTag:TAG_IMAGEVIE_BKG];
		[imageviewBkg setBackgroundColor:[UIColor blackColor]];
		
		[self addSubview:imageviewBkg];
//		[imageviewBkg release];
		
        
		// 提示信息
		UILabel *label = [[UILabel alloc]init];
		[label setTag:TAG_LABEL];
		[label setNumberOfLines:0];
		[label setLineBreakMode:UILineBreakModeClip];
		[label setBackgroundColor:[UIColor clearColor]];
		[label setTextColor:[UIColor whiteColor]];
		[label setFont:[UIFont boldSystemFontOfSize:19]];
		
		[self addSubview:label];
//		[label release];
        
        
		
		self.hidden = YES;
		
         
    }
    return self;
}


- (void)showNoteView
{
	[self setHidden:NO];
	
	UIImageView *imagviewBkg = (UIImageView *)[self viewWithTag:TAG_IMAGEVIE_BKG];
	[imagviewBkg setAlpha:0.6f];
	
	UILabel *labelNote = (UILabel *)[self viewWithTag:TAG_LABEL];
	[labelNote setAlpha:1];
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:3.5f];
	[UIView setAnimationRepeatAutoreverses:NO];
	
	
	[imagviewBkg setAlpha:0];
	[labelNote setAlpha:0];
	
	[UIView commitAnimations];
}


- (CGSize) setNoteText:(NSString*)aText
{
	
	if (aText == nil || [aText length] <= 0)
    {
		return CGSizeMake(0, 0);
	}
	
	UILabel *labelNote = (UILabel *)[self viewWithTag:TAG_LABEL];
	[labelNote setText:aText];
	
	CGSize szNoteText = [labelNote.text sizeWithFont:labelNote.font
                                   constrainedToSize:CGSizeMake(LABEL_WIDTH, MAXFLOAT)
                                       lineBreakMode:UILineBreakModeClip];
	[labelNote setFrame:CGRectMake(15, 10, szNoteText.width, szNoteText.height)];
    
    
   
    
    
	
	UIImageView *imageviewBkg = (UIImageView *)[self viewWithTag:TAG_IMAGEVIE_BKG];
	CGRect imageviewFrame = [imageviewBkg frame];
	imageviewFrame.size.width = szNoteText.width + 30;
	imageviewFrame.size.height = szNoteText.height + 20;
	[imageviewBkg setFrame:imageviewFrame];
    
     imageviewBkg.layer.cornerRadius = 6;
	
	return szNoteText;
    
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
