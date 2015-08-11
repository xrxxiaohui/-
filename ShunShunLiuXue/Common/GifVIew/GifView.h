//
//  GifView.h
//  BeautyMakeup
//
//  Created by nuohuan on 13-11-18.
//  Copyright (c) 2013年 hers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GifView : UIView{
    NSMutableArray *_frames;
    NSMutableArray *_frameDelayTimes;
    CGFloat         _totalTime;         // seconds
    CGFloat         _width;
    CGFloat         _height;
}

- (id)initWithCenter:(CGPoint)center fileURL:(NSURL*)fileURL;

- (void)startGif;

@end
