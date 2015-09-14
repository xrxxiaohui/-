//
//  AddressViewController.h
//  HersOutlet
//
//  Created by Lee xiaohui on 12-9-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHBasicViewController.h"

@interface AddressViewController : QHBasicViewController<UIWebViewDelegate,UIGestureRecognizerDelegate>
{
    UIWebView   *m_webView;
    UILabel *titleLabels;
}


-(void)initWithUrl:(NSString *)addressUrl andTitle:(NSString *)titleStr;

@end
