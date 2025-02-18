//
// GMDCircleLoader.h
//
// Copyright (c) 2014 Gabe Morales
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#pragma mark - Definitions
//----------------------------------
// To change the color and frame size of the spinner, simply change the color and frame definition here.
//----------------------------------
#define GMD_SPINNER_COLOR       [UIColor colorWithRed:206./255. green:206./255. blue:206./255. alpha:1.0]
#define GMD_SPINNER_FRAME       CGRectMake(kScreenWidth/2-60-30, 12.0f, 20.0f, 20.0f)
#define GMD_SPINNER_IMAGE       CGRectMake(15, 15,25,25)
#define GMD_IMAGE               [UIImage imageNamed:@"loading"]
#define GMD_SPINNER_LINE_WIDTH  fmaxf(self.frame.size.width * 0.025, 1.f)

#pragma mark - Interface

@interface GMDCircleLoader : UIView

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) UIColor *lineTintColor;

- (void)start;

- (void)stop;

+ (GMDCircleLoader *)setOnView:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated;

+ (BOOL)hideFromView:(UIView *)view animated:(BOOL)animated;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
