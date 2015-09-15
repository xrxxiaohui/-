//
//  SSNewFeatureViewController.m
//  ShunShunLiuXue
//
//  Created by AndyJerry on 15/9/15.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "SSNewFeatureViewController.h"
#import "UIWindow+Extension.h"
@interface SSNewFeatureViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SSNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _scrollView.pagingEnabled = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        for (int i = 0; i < 4; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"NewFeature%d", i+1]];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
            imageView.image = image;
            imageView.left = self.view.width * i;
            [_scrollView addSubview:imageView];
            if (i == 3) { // 最后一个imageView添加按钮
                [self setupLastImageView:imageView];
            }
        }

        _scrollView.contentSize = CGSizeMake(self.view.width * 4, self.view.height);
    }
    return _scrollView;
}


- (void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互功能
    imageView.userInteractionEnabled = YES;

    // 2.开始
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"start_normal"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"start_select"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = self.view.centerX;
    startBtn.bottom = self.view.height - 95;
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}

- (void)startClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window switchRootViewController];
}





@end
