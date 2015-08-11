//
//  CustomAlertViewController.m
//  BeautyMakeup
//
//  Created by nuohuan on 14-3-18.
//  Copyright (c) 2014年 hers. All rights reserved.
//

#import "CustomAlertViewController.h"

@interface CustomAlertViewController ()

- (void)shareButtonStatus;//分享按钮绑定后状态更改

@end

@implementation CustomAlertViewController

@synthesize delegate;
@synthesize exchangeGoodsName = _exchangeGoodsName;
@synthesize isFromExchangeGoodsPage,isFromFreeUseGoodsView,isFromZaShiWuView;
@synthesize freeUsePicString = _freeUsePicString;

#define shareButtonGapW  18.0f  //分享按钮间隔宽

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //qq登录 初始化授权登录对象
    NSString *appid = qqAppKey;
    _oauth = [[TencentOAuth alloc] initWithAppId:appid
                                     andDelegate:self];
    
    //向新浪微博APP注册本应用信息
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    [self shareDownLoadAppUrl];
    
    //新浪微博 分享绑定sdk回调通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fetchSinaBind_ExchangeGoods)
                                                 name:kSinaShareBind_ExchangeGoods
                                               object:nil];
    // Do any additional setup after loading the view.
}

#pragma mark
#pragma mark -- Functions

- (void)initViews:(NSDictionary *)dic{
    UIView *modelView = [[UIView alloc] init];
    modelView.frame = CGRectMake(kScreenBounds.origin.x, kScreenBounds.origin.y-20.0f, kScreenBounds.size.width ,kScreenBounds.size.height+20);
    
    modelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [modelView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    modelView.userInteractionEnabled = YES;
    [self.view addSubview:modelView];
    [modelView release];
    
    //点击灰色背景弹出框消失
    UIButton *hideAlertViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hideAlertViewButton.frame = CGRectMake(kScreenBounds.origin.x, kScreenBounds.origin.y-20.0f, kScreenBounds.size.width ,kScreenBounds.size.height+20);
    hideAlertViewButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:hideAlertViewButton];
    hideAlertViewButton.hidden = YES;
    [hideAlertViewButton addTarget:self action:@selector(closeAlertView) forControlEvents:UIControlEventTouchUpInside];
    
    //弹出框背景图片
    UIImage *bgImage = [UIImage imageNamed:@"alertBgView.png"];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenBounds.size.width - bgImage.size.width)/2, 120.0f , bgImage.size.width, bgImage.size.height)];
    [bgImageView setImage:bgImage];
    bgImageView.userInteractionEnabled = YES;
    [modelView addSubview:bgImageView];
    
    //关闭弹出框按钮
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeImage = [UIImage imageNamed:@"closeAlertVIew.png"];
    closeButton.frame = CGRectMake(bgImageView.frame.size.width - 50.0f, bgImageView.frame.origin.y - 18.0f, closeImage.size.width, closeImage.size.height);
    [closeButton setImage:closeImage forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeAlertView) forControlEvents:UIControlEventTouchUpInside];
    [modelView addSubview:closeButton];
    
    //弹出框标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((bgImageView.frame.size.width - 150.0f)/2, 13.0f, 150.0f, 20.0f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = kFontArialBoldMT15;
    titleLabel.textColor = kCoinsMailDarkBlueColor;
    titleLabel.text = [dic objectForKey:@"title"];//@"提交成功";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgImageView addSubview:titleLabel];
    [titleLabel release];
    
    //提示内容
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, titleLabel.frame.origin.y + titleLabel.frame.size.height+5.0f, bgImageView.frame.size.width - 20.0f, 40)];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.textColor = kContentColor;
    contentLabel.font = kFontArialBoldMT14;
    contentLabel.lineBreakMode = UILineBreakModeWordWrap;
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.text = [dic objectForKey:@"content"];//@"告诉小伙伴你的战利品告诉小伙伴你的战利品";
    [bgImageView addSubview:contentLabel];
    [contentLabel release];
    
    //分割线
    UIImageView *lineImageView = [[UIImageView alloc] init];
    lineImageView.frame = CGRectMake(10.0f, contentLabel.frame.origin.y + contentLabel.frame.size.height+12.0f, bgImageView.frame.size.width - 20.0f, 1.0f);
    [lineImageView setImage:[UIImage imageNamed:@"separatorLine.png"]];
    [bgImageView addSubview:lineImageView];
    [lineImageView release];
    
    //分享得到的金币
    UILabel *getCoinNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, contentLabel.frame.origin.y + contentLabel.frame.size.height+30.0f, bgImageView.frame.size.width - 10.0f, 20)];
    getCoinNumLabel.backgroundColor = [UIColor clearColor];
    getCoinNumLabel.font = kFontArialBoldMT14;
    getCoinNumLabel.textAlignment = NSTextAlignmentCenter;
    [bgImageView addSubview:getCoinNumLabel];
    getCoinNumLabel.text = @"分享可获+10金币";
    getCoinNumLabel.textColor = kContentColor;
    [getCoinNumLabel release];
    
    //设置颜色
    NSMutableAttributedString *textString = [[getCoinNumLabel attributedText]mutableCopy];
    NSRange range = NSMakeRange(4, 3);
    [textString beginEditing];
    [textString addAttribute:NSForegroundColorAttributeName value:kCoinsMailDarkRedColor range:range];
    [textString addAttribute:NSFontAttributeName value:kFontArial17 range:range];
    
    [getCoinNumLabel setAttributedText:textString];
    [textString endEditing];
    [getCoinNumLabel setAttributedText:textString];
    
    // -- 分享到第三方的按钮 --
    //微信朋友圈
    UIButton *weixinFriCircleShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *weixinFriCircleShareImage = [UIImage imageNamed:@"weixinFriCircleShareLighted.png"];
    [weixinFriCircleShareButton setImage:weixinFriCircleShareImage forState:UIControlStateNormal];
    [weixinFriCircleShareButton setImage:[UIImage imageNamed:@"weixinFriCircleShareLighted.png"] forState:UIControlStateHighlighted];
    [weixinFriCircleShareButton addTarget:self action:@selector(weixinFriCircleShare) forControlEvents:UIControlEventTouchUpInside];
    weixinFriCircleShareButton.frame = CGRectMake(shareButtonGapW, getCoinNumLabel.frame.origin.y+getCoinNumLabel.frame.size.height+20.0f, weixinFriCircleShareImage.size.width, weixinFriCircleShareImage.size.height);
    [bgImageView addSubview:weixinFriCircleShareButton];
    //新浪微博
    sinaShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *sinaShareImage = [UIImage imageNamed:@"sinaShare.png"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaIsLoginSucceed"] integerValue] == 1 || !([[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaBinded_uid"] rangeOfString:@"(null)"].location != NSNotFound)){
        [sinaShareButton setImage:[UIImage imageNamed:@"sinaShareLighted.png"] forState:UIControlStateNormal];
    }else{
        [sinaShareButton setImage:sinaShareImage forState:UIControlStateNormal];
    }
    
    [sinaShareButton addTarget:self action:@selector(isSinaBind) forControlEvents:UIControlEventTouchUpInside];
    sinaShareButton.frame = CGRectMake(weixinFriCircleShareButton.frame.origin.x+weixinFriCircleShareButton.frame.size.width+shareButtonGapW, weixinFriCircleShareButton.frame.origin.y, sinaShareImage.size.width, sinaShareImage.size.height);
    [bgImageView addSubview:sinaShareButton];
    //腾讯微博
    tencentShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *tencentShareImage = [UIImage imageNamed:@"tencentShare.png"];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"qqIsLoginSucceed"] integerValue] == 1 || !([[[NSUserDefaults standardUserDefaults] objectForKey:@"qqBind_openId"] rangeOfString:@"(null)"].location != NSNotFound)){
        [tencentShareButton setImage:[UIImage imageNamed:@"tencentShareLighted.png"] forState:UIControlStateNormal];
    }else{
        [tencentShareButton setImage:tencentShareImage forState:UIControlStateNormal];
    }
    
    [tencentShareButton addTarget:self action:@selector(tencentShare) forControlEvents:UIControlEventTouchUpInside];
    tencentShareButton.frame = CGRectMake(sinaShareButton.frame.origin.x+sinaShareButton.frame.size.width+shareButtonGapW, sinaShareButton.frame.origin.y, tencentShareImage.size.width, tencentShareImage.size.height);
    [bgImageView addSubview:tencentShareButton];
}

- (void)closeAlertView{
    if ([delegate respondsToSelector:@selector(closeAlertView)]){
        [delegate closeAlertView];
    }
}

- (void)initWithShowMess:(NSDictionary *) dic{
    self.exchangeGoodsName = [dic objectForKey:@"goodsName"];
    [self initViews:dic];
}

- (void)shareButtonStatus{
    UIImage *tencentShareImage = [UIImage imageNamed:@"tencentShare_win.png"];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"qqIsLoginSucceed"] integerValue] == 1 || !([[[NSUserDefaults standardUserDefaults] objectForKey:@"qqBind_openId"] rangeOfString:@"(null)"].location != NSNotFound)){
        [tencentShareButton setImage:[UIImage imageNamed:@"tencentShareLighted_win.png"] forState:UIControlStateNormal];
    }else{
        [tencentShareButton setImage:tencentShareImage forState:UIControlStateNormal];
    }
    
    UIImage *sinaShareImage = [UIImage imageNamed:@"sinaShare_win.png"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaIsLoginSucceed"] integerValue] == 1 || !([[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaBinded_uid"] rangeOfString:@"(null)"].location != NSNotFound)){
        [sinaShareButton setImage:[UIImage imageNamed:@"sinaShareLighted_win.png"] forState:UIControlStateNormal];
    }else{
        [sinaShareButton setImage:sinaShareImage forState:UIControlStateNormal];
    }
}

- (void)fetchShareData{
    //需要访问服务端接口（试用申请成功分享加金币）
    [super showMBProgressHUD:@"分享中..."];
    [commonModel requestShareAddCoins:@selector(userAddCoinsSucceed:) httpRequestFailed:@selector(userAddCoinsFailed:)];
}

#pragma mark -- ASI CallBack

//试用申请成功后分享给用户添加金币
- (void)userAddCoinsSucceed:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
    NSDictionary *addCoinsDic = [super parseJsonRequest:request];
    NSLog(@"addCoinsDic=%@",addCoinsDic);
    if ([[addCoinsDic objectForKey:@"status"] intValue] == 0) {
        [[LoadingView sharedManager] showView:self.view message:[NSString stringWithFormat:@"😄分享成功\n获得+%@金币奖励",[addCoinsDic objectForKey:@"number"]] originX:100.0f originY:150.0f delay:2.0f];
        //分享过第三方任何一个 下次分享不再添加金币
        if (isFromExchangeGoodsPage) {
            [[ConstObject instance] setIsAddCoins_ExchangeGoodsTencentShare:NO];
            [[ConstObject instance] setIsAddCoins_ExchangeGoodsSinaShare:NO];
            [[ConstObject instance] setIsAddCoins_ExchangeGoodsWXShare:NO];
        }else if (isFromZaShiWuView){
            [[ConstObject instance] setIsAddCoins_ZaShiWuSinaShare:NO];
            [[ConstObject instance] setIsAddCoins_ZaShiWuTencentShare:NO];
            [[ConstObject instance] setIsAddCoins_ZaShiWuWXShare:NO];
        }else if (isFromFreeUseGoodsView){
            [[ConstObject instance] setIsAddCoins_FreeUseGoodsWXShare:NO];
            [[ConstObject instance] setIsAddCoins_FreeUseGoodsSinaShare:NO];
            [[ConstObject instance] setIsAddCoins_FreeUseGoodsTencentShare:NO];
        }else{
            NSLog(@"来自其他视图调用的自定义分享框");
        }
    }else{
        [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:1.5f];
    }
}

- (void)userAddCoinsFailed:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
    [[LoadingView sharedManager] showView:self.view message:@"分享失败" originX:100.0f originY:150.0f delay:1.5f];
}

#pragma mark
#pragma mark -- ShareFunctions

- (void)tencentShare{
    [MobClick event:@"detai_tencent_microblog_count"];
    //判断下 qq是否绑定过
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"qqIsLoginSucceed"] integerValue] == 1 || !([[[NSUserDefaults standardUserDefaults] objectForKey:@"qqBind_openId"] rangeOfString:@"(null)"].location != NSNotFound)){
        
        [super showMBProgressHUD:@"分享中..."];
        
        NSDictionary *paramm;
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"qqIsLoginSucceed"] integerValue] == 1 ) {
            
            //区分是 兑换商品、砸中实物金蛋、试用商品 的分享
            UIImage *shareImage_ExchangeGoods = [UIImage imageNamed:@"exchangeGoodsShareImage.png"];
            UIImage *shareImage_ZaDan = [UIImage imageNamed:@"zaDanShareImage.png"];
            NSString *picStr = [NSString stringWithFormat:@"%@",self.freeUsePicString];
            UIImage *picImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picStr]]];
            if (!picImage) {
                picImage = shareImage_ExchangeGoods;
            }
            if (isFromFreeUseGoodsView) { //免费试用商品
                
                paramm = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"qq_accessToken"],@"access_token",qqAppKey,@"oauth_consumer_key",[[NSUserDefaults standardUserDefaults] objectForKey:@"qq_openId"],@"openid",[NSString stringWithFormat:@"小伙伴们快来呀，#美人帮#应用 赠送 %@，免费试用，先到先得！下载地址：http://beauty.hers.com.cn/app.php",self.exchangeGoodsName],@"content", nil]; //status 内容不超过140个汉字
                [commonModel requsetTencent_HavePic:paramm data:UIImageJPEGRepresentation(picImage, 0.8) httpRequestSucceed:@selector(tencentShareSucceed:) httpRequestFailed:@selector(tencentShareFailed:)];
            }else if (isFromExchangeGoodsPage){ //兑换商品
                paramm = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"qq_accessToken"],@"access_token",qqAppKey,@"oauth_consumer_key",[[NSUserDefaults standardUserDefaults] objectForKey:@"qq_openId"],@"openid",[NSString stringWithFormat:@"玩#美人帮#免费拿奖品，最近很火的美容护肤社区，我刚刚成功获得了 %@，心动就赶紧行动吧！+http://beauty.hers.com.cn/app.php",self.exchangeGoodsName],@"content", nil]; //status 内容不超过140个汉字
                [commonModel requsetTencent_HavePic:paramm data:UIImageJPEGRepresentation(picImage, 0.8) httpRequestSucceed:@selector(tencentShareSucceed:) httpRequestFailed:@selector(tencentShareFailed:)];
            }else if (isFromZaShiWuView){ //砸中实物金蛋
                paramm = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"qq_accessToken"],@"access_token",qqAppKey,@"oauth_consumer_key",[[NSUserDefaults standardUserDefaults] objectForKey:@"qq_openId"],@"openid",[NSString stringWithFormat:@"中奖概率好高呀！在玩美容护肤应用 #美人帮#，刚刚中了幸运大奖哦！小伙们一块来参与吧！http://beauty.hers.com.cn/app.php"],@"content", nil]; //status 内容不超过140个汉字
                [commonModel requsetTencent_HavePic:paramm data:UIImageJPEGRepresentation(shareImage_ZaDan, 0.8) httpRequestSucceed:@selector(tencentShareSucceed:) httpRequestFailed:@selector(tencentShareFailed:)];
            }else{
                NSLog(@"来自其他调用自定义分享框 分享内容到第三方的视图");
            }
        }else{
            //区分是 兑换商品、砸中实物金蛋、试用商品 的分享
            UIImage *shareImage_ExchangeGoods = [UIImage imageNamed:@"exchangeGoodsShareImage.png"];
            UIImage *shareImage_ZaDan = [UIImage imageNamed:@"zaDanShareImage.png"];
            NSString *picStr = [NSString stringWithFormat:@"%@",self.freeUsePicString];
            UIImage *picImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picStr]]];
            if (!picImage) {
                picImage = shareImage_ExchangeGoods;
            }
            if (isFromFreeUseGoodsView){ //免费试用商品
                
                paramm = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"qqBind_accessToken"],@"access_token",qqAppKey,@"oauth_consumer_key",[[NSUserDefaults standardUserDefaults] objectForKey:@"qqBind_openId"],@"openid",[NSString stringWithFormat:@"小伙伴们快来呀，#美人帮#应用 赠送 %@，免费试用，先到先得！下载地址：http://beauty.hers.com.cn/app.php",self.exchangeGoodsName],@"content", nil]; //status 内容不超过140个汉字
                [commonModel requsetTencent_HavePic:paramm data:UIImageJPEGRepresentation(picImage, 0.8) httpRequestSucceed:@selector(tencentShareSucceed:) httpRequestFailed:@selector(tencentShareFailed:)];
            }else if (isFromExchangeGoodsPage){ //兑换商品
                paramm = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"qqBind_accessToken"],@"access_token",qqAppKey,@"oauth_consumer_key",[[NSUserDefaults standardUserDefaults] objectForKey:@"qqBind_openId"],@"openid",[NSString stringWithFormat:@"玩#美人帮#免费拿奖品，最近很火的美容护肤社区，我刚刚成功获得了 %@，心动就赶紧行动吧！+http://beauty.hers.com.cn/app.php",self.exchangeGoodsName],@"content", nil]; //status 内容不超过140个汉字
                [commonModel requsetTencent_HavePic:paramm data:UIImageJPEGRepresentation(picImage, 0.8) httpRequestSucceed:@selector(tencentShareSucceed:) httpRequestFailed:@selector(tencentShareFailed:)];
            }else if (isFromZaShiWuView){ //砸中实物金蛋
                paramm = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"qqBind_accessToken"],@"access_token",qqAppKey,@"oauth_consumer_key",[[NSUserDefaults standardUserDefaults] objectForKey:@"qqBind_openId"],@"openid",[NSString stringWithFormat:@"中奖概率好高呀！在玩美容护肤应用 #美人帮#，刚刚中了幸运大奖哦！小伙们一块来参与吧！http://beauty.hers.com.cn/app.php"],@"content", nil]; //status 内容不超过140个汉字
                [commonModel requsetTencent_HavePic:paramm data:UIImageJPEGRepresentation(shareImage_ZaDan, 0.8) httpRequestSucceed:@selector(tencentShareSucceed:) httpRequestFailed:@selector(tencentShareFailed:)];
            }else{
                NSLog(@"来自其他调用自定义分享框 分享内容到第三方的视图");
            }
        }
    }else{
        //判断客户端是否安装QQ
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
            NSLog(@"已经安装QQ");
            [[ConstObject instance] setQqLoginFrom:3];
            NSArray *permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_ADD_TOPIC,
                                    kOPEN_PERMISSION_ADD_ONE_BLOG,
                                    kOPEN_PERMISSION_ADD_SHARE,
                                    kOPEN_PERMISSION_ADD_PIC_T,
                                    kOPEN_PERMISSION_GET_INFO,
                                    kOPEN_PERMISSION_GET_OTHER_INFO,
                                    kOPEN_PERMISSION_GET_FANSLIST,
                                    kOPEN_PERMISSION_ADD_IDOL,
                                    kOPEN_PERMISSION_GET_USER_INFO,
                                    kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,nil];
            [_oauth authorize:permissions inSafari:NO];
        }else{
            NSLog(@"没有安装QQ");
            [[LoadingView sharedManager] showView:self.view message:@"您没有安装最新QQ，请先下载" originX:130 originY:260  delay:2.5f];
        }
    }
}

- (void)weixinFriCircleShare{
    [MobClick event:@"detai_weixin_friend_circle_count"];
    _scene = WXSceneTimeline;
    [[ConstObject instance] setIsFromWXFriendsInvite:NO];
    
    //区分是 兑换商品 、砸中实物金蛋、试用商品 的分享
    if (isFromFreeUseGoodsView){ //免费试用商品
        [[ConstObject instance] setIsWXFromFreeUseGoodsPage:YES];
    }else if (isFromExchangeGoodsPage) { //兑换商品
        [[ConstObject instance] setIsWXFromExchangeGoodsPage:YES];
    }else if (isFromZaShiWuView){ //砸中实物
        [[ConstObject instance] setIsWXFromZaShiWuPage:YES];
    }else{
        NSLog(@"来自其他调用分享框页面");
    }
    
    BOOL isInstalled = [WXApi isWXAppInstalled];
    if (!isInstalled) {
        [[LoadingView sharedManager] showView:self.view message:@"你还没有下载微信哦~" originX:80 originY:150 delay:2.0f];
    }else{
        WXMediaMessage *message = [WXMediaMessage message];
        //区分是 兑换商品、砸中实物金蛋、试用商品 的分享
        if (isFromFreeUseGoodsView) { //免费试用商品
            message.title = @"免费领化妆品啦！《美人帮》天天都能领正品化妆品。";
            message.description = @"免费领化妆品啦！《美人帮》天天都能领正品化妆品。";
        }else if (isFromExchangeGoodsPage){ //兑换商品
            message.title = @"刚刚拿妆品啦！我在玩最火的女生应用《美人帮》";
            message.description = @"我在玩《美人帮》，刚刚成功兑换了免费妆品，一起来玩吧！";
        }else if (isFromZaShiWuView){ //砸中实物
            message.title = @"中了幸运大奖！我在玩最火的美容护肤应用《美人帮》";
            message.description = @"我在玩最火的美容护肤应用 #美人帮#，还砸中了幸运大奖！";
        }else{
           NSLog(@"来自其他调用分享框页面");
        }
        
        [message setThumbImage:[UIImage imageNamed:@"Icon.png"]];
        if (!appDownLoadUrlString) {
            appDownLoadUrlString = @"http://wenda.hers.com.cn/mobile/weixinshare";
        }
        NSString *sinaShareUrl = appDownLoadUrlString;
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = sinaShareUrl;
        message.mediaObject = ext;
        
        SendMessageToWXReq *reqq = [[[SendMessageToWXReq alloc] init]autorelease];
        reqq.bText = NO;
        reqq.message = message;
        reqq.scene = _scene;
        
        [WXApi sendReq:reqq];
    }
}

- (void)isSinaBind{
    //判断下新浪微博是否绑定过
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaIsLoginSucceed"] integerValue] == 1 ||!([[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaBinded_uid"] rangeOfString:@"(null)"].location != NSNotFound)){
        
        [self sinaShare];
    }else{
        [[ConstObject instance] setSinaLoginFrom:5];
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = kRedirectURI;
        request.scope = @"all";
        request.userInfo = @{@"SSO_From": @"LoginViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        [WeiboSDK sendRequest:request];
    }
}

- (void)sinaShare{
    [MobClick event:@"detai_sina_microblog_count"];
    [super showMBProgressHUD:@"分享中..."];
    
    fullURL = @"https://upload.api.weibo.com/2/statuses/upload.json";
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaIsLoginSucceed"] integerValue] == 1){
        //区分是 兑换商品 、砸中实物金蛋 、试用商品 的分享
        UIImage *shareImage_ExchangeGoods = [UIImage imageNamed:@"exchangeGoodsShareImage.png"];
        UIImage *shareImage_ZaDan = [UIImage imageNamed:@"zaDanShareImage.png"];
        NSString *picStr = [NSString stringWithFormat:@"%@",self.freeUsePicString];
        UIImage *picImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picStr]]];
        if (!picImage) {
            picImage = shareImage_ExchangeGoods;
        }

        if (isFromFreeUseGoodsView) {
            
            sinaShareContent = [NSString stringWithFormat:@"小伙伴们快来呀，#美人帮#应用 赠送 %@,免费试用，先到先得！下载地址：http://beauty.hers.com.cn/app.php @美人帮",self.exchangeGoodsName];
            param = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"sina_token"],@"access_token",sinaShareContent,@"status",picImage,@"pic", nil]; //status 内容不超过140个汉字
        }else if (isFromExchangeGoodsPage){
            sinaShareContent = [NSString stringWithFormat:@"玩#美人帮#免费拿奖品，最近很火的美容护肤社区，我刚刚成功获得了 %@,心动就赶紧行动吧！@美人帮 http://beauty.hers.com.cn/app.php",self.exchangeGoodsName];
            param = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"sina_token"],@"access_token",sinaShareContent,@"status",picImage,@"pic", nil]; //status 内容不超过140个汉字
        }else if (isFromZaShiWuView){
            sinaShareContent = [NSString stringWithFormat:@"中奖概率好高呀！在玩美容护肤应用 #美人帮#，刚刚中了幸运大奖哦！小伙们一块来参与吧！@美人帮 http://beauty.hers.com.cn/app.php +图片"];
            param = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"sina_token"],@"access_token",sinaShareContent,@"status",shareImage_ZaDan,@"pic", nil]; //status 内容不超过140个汉字
        }else{
            NSLog(@"来自其他调用自定义分享框 分享内容到第三方的视图");
        }
    }
    if (!([[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaBinded_uid"] rangeOfString:@"(null)"].location != NSNotFound)){
        //区分是 兑换商品 还是 砸中实物金蛋 的分享
        UIImage *shareImage_ExchangeGoods = [UIImage imageNamed:@"exchangeGoodsShareImage.png"];
        UIImage *shareImage_ZaDan = [UIImage imageNamed:@"zaDanShareImage.png"];
        NSString *picStr = [NSString stringWithFormat:@"%@",self.freeUsePicString];
        UIImage *picImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picStr]]];
        if (!picImage) {
            picImage = shareImage_ExchangeGoods;
        }
        if (isFromFreeUseGoodsView) {
            
            sinaShareContent = [NSString stringWithFormat:@"小伙伴们快来呀，#美人帮#应用 赠送 %@,免费试用，先到先得！下载地址：http://beauty.hers.com.cn/app.php @美人帮",self.exchangeGoodsName];
            param = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaBind_token"],@"access_token",sinaShareContent,@"status",picImage,@"pic", nil]; //status 内容不超过140个汉字
        }else if (isFromExchangeGoodsPage){
            sinaShareContent = [NSString stringWithFormat:@"玩#美人帮#免费拿奖品，最近很火的美容护肤社区，我刚刚成功获得了 %@,心动就赶紧行动吧！@美人帮 http://beauty.hers.com.cn/app.php",self.exchangeGoodsName];
            param = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaBind_token"],@"access_token",picImage,@"status",shareImage_ExchangeGoods,@"pic", nil]; //status 内容不超过140个汉字
        }else if (isFromZaShiWuView){
            sinaShareContent = [NSString stringWithFormat:@"中奖概率好高呀！在玩美容护肤应用 #美人帮#，刚刚中了幸运大奖哦！小伙们一块来参与吧！@美人帮 http://beauty.hers.com.cn/app.php +图片"];
            param = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaBind_token"],@"access_token",sinaShareContent,@"status",shareImage_ZaDan,@"pic", nil]; //status 内容不超过140个汉字
        }else{
            NSLog(@"来自其他调用自定义分享框 分享内容到第三方的视图");
        }
    }
    
    sinaRequest = [SinaWeiboRequest requestWithURL:fullURL
                                        httpMethod:@"POST"
                                            params:param
                                          delegate:self];
    [sinaRequest connect];
    
}

#pragma mark
#pragma mark -- FetchThridBindFunctions
- (void)fetchSinaBind_ExchangeGoods{
    NSString *requestString = [NSString stringWithFormat:@"%@&sina_uid=%@&username=%@&auth=%@&secret=%@",@"weibo",[[NSUserDefaults standardUserDefaults] objectForKey:@"sinaBind_uid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"screen_username"],[[NSUserDefaults standardUserDefaults] objectForKey:@"sina_token"],kAppSecret];
    [super showMBProgressHUD:@"绑定中..."];
    [commonModel requestThirdBind:requestString httpRequestSucceed:@selector(requestSinaShareBindSucceed:) httpRequestFailed:@selector(requestSinaShareBindFailed:)];
}

- (void)fetchQQBind:(NSString *)requsetString{
    [super showMBProgressHUD:@"绑定中..."];
    [commonModel requestThirdBind:requsetString httpRequestSucceed:@selector(requestQQShareBindSucceed:) httpRequestFailed:@selector(requestQQShareBindFailed:)];
}

- (void)getUserInfo_sharePopView{
    [commonModel requestReturnUserInfo:@selector(sharePopView_getUserInfoSucceed:) httpRequestFailed:@selector(sharePopView_getUserInfoFailed:)];
}

#pragma mark
#pragma mark -- GetUserInfo CallBack
- (void)sharePopView_getUserInfoSucceed:(ASIHTTPRequest *)request{
    NSDictionary *getUserInfoDic = [super parseJsonRequest:request];
    if ([[getUserInfoDic objectForKey:@"status"] integerValue] == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kGetLoginUserInfo object:nil userInfo:getUserInfoDic];
    }else{
        //获得个人信息失败
    }
    //新浪微博已绑定 绑定成功后直接去分享
    if (isToShare_Sina) {
        [self sinaShare];
    }
    //腾讯微博已绑定 绑定成功后直接去分享
    if (_isLogined) {
        [self tencentShare];
    }
    [self shareButtonStatus];
}

- (void)sharePopView_getUserInfoFailed:(ASIHTTPRequest *)request{
    
}

#pragma mark
#pragma mark -- ASIHTTPRequest CallBack (SinaBind)
- (void)requestSinaShareBindSucceed:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
    NSDictionary *sinaBindDic = [super parseJsonRequest:request];
    NSLog(@"sinaBindDic=%@",sinaBindDic);
    if (!sinaBindDic) {
        [[LoadingView sharedManager] showView:self.view message:@"绑定失败" originX:100 originY:150 delay:1.5f];
        return;
    }
    //记录下 绑定的用户信息 和登录的用户的本地信息区分开
    if ([[sinaBindDic objectForKey:@"status"] integerValue] == 0){
        [sinaShareButton setImage:[UIImage imageNamed:@"sinaShareLighted_win.png"] forState:UIControlStateNormal];
        
        isToShare_Sina = YES;
        [self getUserInfo_sharePopView];
        NSLog(@"绑定新浪微博账号成功");
    }else{
        NSString *errorMess = [sinaBindDic objectForKey:@"error"];
        [super showMessageBox:nil
                        title:@"绑定失败"
                      message:errorMess
                       cancel:@"好的"
                      confirm:nil];
    }
}

- (void)requestSinaShareBindFailed:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
    NSDictionary *sinaBindDic = [super parseJsonRequest:request];
    NSLog(@"sinaBindDic=%@",sinaBindDic);
}

#pragma mark -- SinaSDKLogin CallBack (模拟器微博登录成功回调)
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    [[NSUserDefaults standardUserDefaults]setValue:sinaweibo.userID forKey:@"sinaBind_uid"];
    [[NSUserDefaults standardUserDefaults]setValue:sinaweibo.accessToken forKey:@"sina_token"];
    //拿到新浪微博用户信息
    NSString *fullApiURL = @"https://api.weibo.com/2/users/show.json";
    NSDictionary *sinaParam = [NSDictionary dictionaryWithObjectsAndKeys:sinaweibo.accessToken,@"access_token",sinaweibo.userID,@"uid", nil];
    sinaRequest = [SinaWeiboRequest requestWithURL:fullApiURL
                                        httpMethod:@"GET"
                                            params:sinaParam
                                          delegate:self];
    [sinaRequest connect];
}

#pragma mark -- SinaWeiboRequestDelegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    [super hideMBProgressHUD];
    if ([result isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = (NSDictionary *)result;
        //绑定新浪微博
        if ([dict objectForKey:@"screen_name"]){
            [[NSUserDefaults standardUserDefaults]setValue:[dict objectForKey:@"screen_name"] forKey:@"screen_username"];
            [self fetchSinaBind_ExchangeGoods];
        }
        //新浪微博分享成功
        else if ([dict objectForKey:@"id"]){
            //兑换商品、砸中实物金蛋、试用申请成功 分享成功是否需要加金币
            if (isFromFreeUseGoodsView) {
                if ([[ConstObject instance] isAddCoins_FreeUseGoodsSinaShare]) {
                    if (![[ConstObject instance] isAddCoins_FreeUseGoodsTencentShare] || ![[ConstObject instance] isAddCoins_FreeUseGoodsWXShare]) {
                        [self fetchShareData];
                    }else if ([[ConstObject instance] isAddCoins_FreeUseGoodsTencentShare] && [[ConstObject instance] isAddCoins_FreeUseGoodsWXShare]){
                        [self fetchShareData];
                    }
                    else{
                        [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                    }
                }else{
                    [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                }
            }else if (isFromExchangeGoodsPage){
                if ([[ConstObject instance] isAddCoins_ExchangeGoodsSinaShare]){
                    if (![[ConstObject instance] isAddCoins_ExchangeGoodsTencentShare] || ![[ConstObject instance] isAddCoins_ExchangeGoodsWXShare]) {
                        [self fetchShareData];
                    }else if ([[ConstObject instance] isAddCoins_ExchangeGoodsTencentShare] && [[ConstObject instance] isAddCoins_ExchangeGoodsWXShare]) {
                        [self fetchShareData];
                    }else
                    {
                        [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                    }
                }else{
                    [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                }
            }else if (isFromZaShiWuView){
                if ([[ConstObject instance] isAddCoins_ZaShiWuSinaShare]){
                    if (![[ConstObject instance] isAddCoins_ZaShiWuTencentShare] || ![[ConstObject instance] isAddCoins_ZaShiWuWXShare]) {
                        [self fetchShareData];
                    }else if ([[ConstObject instance] isAddCoins_ZaShiWuTencentShare] && [[ConstObject instance] isAddCoins_ZaShiWuWXShare]){
                       [self fetchShareData];
                    }
                    else{
                        [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                    }
                }else{
                    [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                }
            }
            else{
                [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
            }
        }else{
            [[LoadingView sharedManager] showView:self.view message:[dict objectForKey:@"error"] originX:20 originY:150 delay:2.0f];
        }
    }else{
        [[LoadingView sharedManager] showView:self.view message:@"新浪微博分享失败" originX:90 originY:150 delay:1.5f];
    }
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo{
    [super hideMBProgressHUD];
}

#pragma mark -- GetQQUserInfoFunction
- (void)getUserInfoResponse:(APIResponse*) response{
    if (response){
        if (URLREQUEST_SUCCEED == response.retCode && kOpenSDKErrorSuccess == response.detailRetCode){
            NSMutableString *str=[NSMutableString stringWithFormat:@""];
            for (id key in response.jsonResponse){
                [str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
            }
            NSLog(@"%@",[response.jsonResponse objectForKey:@"nickname"]);
            [[NSUserDefaults standardUserDefaults]setValue:[response.jsonResponse objectForKey:@"nickname"] forKey:@"qq_username"];
            
            NSString *requestString = [NSString stringWithFormat:@"%@&openid=%@&nickname=%@&token=%@&expired=%@",@"qq",[[NSUserDefaults standardUserDefaults] objectForKey:@"qq_openId"],[response.jsonResponse objectForKey:@"nickname"],[[NSUserDefaults standardUserDefaults] objectForKey:@"qq_accessToken"],[[NSUserDefaults standardUserDefaults] objectForKey:@"qq_expirationDate"]];
            [self fetchQQBind:requestString];
        }else
        {
            
        }
    }
}

#pragma mark -- TCAPIRequestDelegate (腾讯微博分享成功回调)
- (void)cgiRequest:(TCAPIRequest *)request didResponse:(APIResponse *)response
{
    [super hideMBProgressHUD];
    if (URLREQUEST_SUCCEED == response.retCode && kOpenSDKErrorSuccess == response.detailRetCode)
    {
        NSMutableString *str=[NSMutableString stringWithFormat:@""];
        for (id key in response.jsonResponse)
        {
            [str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
        }
        if ([[response.jsonResponse  objectForKey:@"errcode"] integerValue] == 0){
            //兑换商品、砸中实物金蛋、试用申请成功 分享成功是否需要加金币
            if (isFromExchangeGoodsPage) {
                if ([[ConstObject instance] isAddCoins_ExchangeGoodsTencentShare]) {
                    if (![[ConstObject instance] isAddCoins_ExchangeGoodsSinaShare] || ![[ConstObject instance] isAddCoins_ExchangeGoodsWXShare]) {
                        [self fetchShareData];
                    }else if ([[ConstObject instance] isAddCoins_ExchangeGoodsSinaShare] && [[ConstObject instance] isAddCoins_ExchangeGoodsWXShare]){
                        [self fetchShareData];
                    }
                    else{
                        [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                    }
                }else{
                    [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                }
            }else if (isFromFreeUseGoodsView){
                if ([[ConstObject instance] isAddCoins_FreeUseGoodsTencentShare]){
                    if (![[ConstObject instance] isAddCoins_FreeUseGoodsSinaShare] || ![[ConstObject instance] isAddCoins_FreeUseGoodsWXShare]) {
                        [self fetchShareData];
                    }else if ([[ConstObject instance] isAddCoins_FreeUseGoodsSinaShare] && [[ConstObject instance] isAddCoins_FreeUseGoodsWXShare]){
                        [self fetchShareData];
                    }
                    else{
                        [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                    }
                }else{
                    [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                }
            }else if (isFromZaShiWuView){
                if ([[ConstObject instance] isAddCoins_ZaShiWuTencentShare]){
                    if (![[ConstObject instance] isAddCoins_ZaShiWuSinaShare] || ![[ConstObject instance] isAddCoins_ZaShiWuWXShare]) {
                        [self fetchShareData];
                    }else if ([[ConstObject instance] isAddCoins_ZaShiWuSinaShare] && [[ConstObject instance] isAddCoins_ZaShiWuWXShare]){
                        [self fetchShareData];
                    }
                    else{
                        [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                    }
                }else{
                    [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                }
            }
            else{
                [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
            }
        }else{
            [[LoadingView sharedManager] showView:self.view message:@"您已分享过了~~" originX:100 originY:150 delay:1.5f];
        }
    }
}

#pragma mark -- ASIHTTPRequest CallBack (QQBind)
- (void)requestQQShareBindSucceed:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
    NSDictionary *qqLoginDic = [super parseJsonRequest:request];
    NSLog(@"%@",qqLoginDic);
    if (!qqLoginDic) {
        [[LoadingView sharedManager] showView:self.view message:@"绑定失败" originX:130 originY:150 delay:1.5f];
        return;
    }
    if ([[qqLoginDic objectForKey:@"status"] integerValue] == 0) {
        [tencentShareButton setImage:[UIImage imageNamed:@"tencentShareLighted_win.png"] forState:UIControlStateNormal];
        [self getUserInfo_sharePopView];
        NSLog(@"分享绑定qq成功");
    }else{
        NSString *errorMess = [qqLoginDic objectForKey:@"error"];
        [super showMessageBox:nil
                        title:@"绑定失败"
                      message:errorMess
                       cancel:@"好的"
                      confirm:nil];
    }
}

- (void)requestQQShareBindFailed:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
    NSLog(@"分享绑定qq失败");
}

#pragma mark -- ASIHTTPRequest CallBack (TencentShare)
- (void)tencentShareSucceed:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
    NSDictionary *getUserInfoDic = [super parseJsonRequest:request];
    NSLog(@"%@",getUserInfoDic);
    if ([[getUserInfoDic objectForKey:@"ret"] integerValue] == 0) {
        //兑换商品、砸中实物金蛋、试用申请成功 分享成功是否需要加金币
        if (isFromExchangeGoodsPage) {
            if ([[ConstObject instance] isAddCoins_ExchangeGoodsTencentShare]) {
                if (![[ConstObject instance] isAddCoins_ExchangeGoodsSinaShare] || ![[ConstObject instance] isAddCoins_ExchangeGoodsWXShare]) {
                    [self fetchShareData];
                }else if ([[ConstObject instance] isAddCoins_ExchangeGoodsSinaShare] && [[ConstObject instance] isAddCoins_ExchangeGoodsWXShare]){
                    [self fetchShareData];
                }
                else{
                    [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                }
            }else{
                [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
            }
        }else if (isFromFreeUseGoodsView){
            if ([[ConstObject instance] isAddCoins_FreeUseGoodsTencentShare]){
                if (![[ConstObject instance] isAddCoins_FreeUseGoodsSinaShare] || ![[ConstObject instance] isAddCoins_FreeUseGoodsWXShare]) {
                    [self fetchShareData];
                }else if ([[ConstObject instance] isAddCoins_FreeUseGoodsSinaShare] && [[ConstObject instance] isAddCoins_FreeUseGoodsWXShare]){
                    [self fetchShareData];
                }
                else{
                    [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                }
            }else{
                [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
            }
        }else if (isFromZaShiWuView){
            if ([[ConstObject instance] isAddCoins_ZaShiWuTencentShare]){
                if (![[ConstObject instance] isAddCoins_ZaShiWuSinaShare] || ![[ConstObject instance] isAddCoins_ZaShiWuWXShare]) {
                    [self fetchShareData];
                }else if ([[ConstObject instance] isAddCoins_ZaShiWuSinaShare] && [[ConstObject instance] isAddCoins_ZaShiWuWXShare]){
                    [self fetchShareData];
                }
                else{
                    [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
                }
            }else{
                [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
            }
        }
        else{
           [[LoadingView sharedManager] showView:self.view message:@"😄分享成功" originX:100.0f originY:150.0f delay:2.0f];
        }
    }else{
        [[LoadingView sharedManager] showView:self.view message:@"您已分享过了~~" originX:100 originY:150 delay:1.5f];
    }
}

- (void)tencentShareFailed:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
    [[LoadingView sharedManager] showView:self.view message:@"分享失败" originX:100 originY:150 delay:1.5f];
}

//接收发送的分享信息到QQApiInterface回调的错误的信息
- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            [[LoadingView sharedManager] showView:self.view message:@"App未注册" originX:115 originY:150 delay:1.5f];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            [[LoadingView sharedManager] showView:self.view message:@"发送参数错误" originX:110 originY:150 delay:1.5f];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            [[LoadingView sharedManager] showView:self.view message:@"未安装手Q" originX:115 originY:150 delay:1.5f];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            [[LoadingView sharedManager] showView:self.view message:@"API接口不支持" originX:90 originY:150 delay:1.5f];
            break;
        }
        case EQQAPISENDFAILD:
        {
            [[LoadingView sharedManager] showView:self.view message:@"发送失败" originX:130 originY:150 delay:1.5f];
            break;
        }
        default:
        {
            break;
        }
    }
}

#pragma mark -- TencentLoginDelegate
/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    if (NO == _isLogined){
        _isLogined = YES;
    }
    if (NO == [_oauth getUserInfo]) {
        [super showMessageBox:nil
                        title:@"绑定失败"
                      message:@"请从后台退出本应用并更新QQ到最新版本"
                       cancel:@"OK"
                      confirm:nil];
    }
    [[NSUserDefaults standardUserDefaults] setObject:_oauth.accessToken forKey:@"qq_accessToken"];
    [[NSUserDefaults standardUserDefaults] setObject:_oauth.openId forKey:@"qq_openId"];
    [[NSUserDefaults standardUserDefaults] setObject:_oauth.expirationDate forKey:@"qq_expirationDate"];
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    
}

#pragma mark -- TencentApiInterfaceDelegate

/**
 * 请求获得内容 当前版本只支持第三方相应腾讯业务请求
 */
- (BOOL)onTencentReq:(TencentApiReq *)req{
    return YES;
}

/**
 * 响应请求答复 当前版本只支持腾讯业务相应第三方的请求答复
 */
- (BOOL)onTencentResp:(TencentApiResp *)resp{
    return YES;
}

#pragma mark
#pragma mark -- ASI CallBack
- (void)shareDownLoadAppUrl{
    [commonModel requestAppDownLoadUrl:@selector(requestAppDownLoadUrlSuccess:) httpRequestFailed:@selector(requestAppDownLoadUrlFailed:)];
}

#pragma mark
#pragma mark -- ASIHTTPRequest CallBack
- (void)requestAppDownLoadUrlSuccess:(ASIHTTPRequest *)request{
    NSDictionary *appDownLoadUrlDic = [super parseJsonRequest:request];
    NSLog(@"appDownLoadUrlDic= %@",appDownLoadUrlDic);
    appDownLoadUrlString = [[appDownLoadUrlDic objectForKey:@"url"] retain];
}

- (void)requestAppDownLoadUrlFailed:(ASIHTTPRequest *)request{
    appDownLoadUrlString = @"http://wenda.hers.com.cn/mobile/weixinshare";
}

- (void)dealloc{
    [_oauth release];
    [sinaWeiboApi release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kSinaShareBind
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kSinaShareBind_ExchangeGoods
                                                  object:nil];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
