//
//  CustomAlertViewController.h
//  BeautyMakeup
//
//  Created by nuohuan on 14-3-18.
//  Copyright (c) 2014年 hers. All rights reserved.
//

#import "UITempletViewController.h"

#import "TencentOpenAPI/QQApiInterface.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import "WXApi.h"
#import "SinaWeiboRequest.h"
#import "SinaWeibo.h"
#import "WeiboSDK.h"

#import "UIImage+Resize.h"

@protocol CloseAlertViewDelegate <NSObject>

- (void)closeAlertView;//关闭弹出框

@end

@interface CustomAlertViewController : UITempletViewController<TencentSessionDelegate,WXApiDelegate,TCAPIRequestDelegate,SinaWeiboRequestDelegate,SinaWeiboDelegate,WBHttpRequestDelegate>{
    TencentOAuth        *_oauth;//qq分享
    enum WXScene        _scene;//微信分享
    SinaWeiboRequest    *sinaRequest;//新浪微博分享
    BOOL                _isLogined;//QQ是否登录
    SinaWeibo           *sinaWeiboApi;//新浪微博api
    NSString            *appDownLoadUrlString;//分享的 下载应用链接 （微信）
    NSString            *fullURL;//新浪微博分享API链接
    NSDictionary        *param;//新浪微博分享内容字典
    UIButton            *sinaShareButton;//新浪微博分享按钮
    UIButton            *tencentShareButton;//腾讯微博分享按钮
    BOOL                isToShare_Sina;//是否需要新浪新浪微博分享
    NSString            *sinaShareContent;//新浪微博分享的内容
    BOOL                isFromExchangeGoodsPage;//来自兑换商品页面
    BOOL                isFromFreeUseGoodsView;//来自试用商品页面
    BOOL                isFromZaShiWuView;//来自砸中实物页面
    NSString            *freeUsePicString;//试用商品图片
}

@property (nonatomic,retain) id<CloseAlertViewDelegate> delegate;
@property (nonatomic,retain) NSString *exchangeGoodsName;//兑换的商品名称
@property (nonatomic,assign) BOOL isFromExchangeGoodsPage;//来自兑换商品页面
@property (nonatomic,assign) BOOL isFromFreeUseGoodsView;//来自试用商品页面
@property (nonatomic,assign) BOOL isFromZaShiWuView;//来自砸中实物页面
@property (nonatomic,retain) NSString *freeUsePicString;//试用商品图片

- (void)initWithShowMess:(NSDictionary *) dic;//初始化弹出框的内容

@end
