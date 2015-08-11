//
//  ConstObject.h
//  ChuanDaZhi
//
//  Created by Lee xiaohui on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//#import "TTImagePickerBar.h"
#import <Foundation/Foundation.h>

@interface ConstObject : NSObject{
    BOOL           isLogin;//判断是否登录
    int            clickFrom;//1来自 邀请好友的 新浪微博按钮；2来自 邀请好友的 qq按钮；3来自 邀请好友的 微信按钮 4来自 邀请好友的 通讯录按钮
    BOOL           isFromQQFriendsInvite;//是否来自qq好友邀请
    BOOL           isFromWXFriendsInvite;//是否来自微信好友邀请
    BOOL           isWXFromExchangeGoodsPage;//是否来自兑换商品成功的微信分享
    
    BOOL           isFromExchangeGoodsPage;//来自兑换商品页面
    BOOL           isFromFreeUseDetailPage;//来自试用商品页面
    BOOL           isFromZaShiWuView;//来自砸中实物页面
}

@property (nonatomic, retain) UIViewController *homeViewController;
@property (nonatomic, retain) UINavigationController *messageNavigationController;
@property (nonatomic, assign) int sinaLoginFrom;// 1来自登录页面的新浪微博登录，2来自设置页面绑定 3来自分享页面的绑定 4来自同步页面的绑定 5来自邀请好友页面的绑定
@property (nonatomic, assign) int qqLoginFrom;// 1来自登录页面的QQ登录，2来自设置页面绑定 3来自分享页面的绑定 4来自同步页面的绑定 5来自邀请好友页面的绑定
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) int clickFrom;
@property (nonatomic, assign) BOOL isFromQQFriendsInvite;
@property (nonatomic, assign) BOOL isFromWXFriendsInvite;

@property (nonatomic, assign) BOOL isWXFromExchangeGoodsPage;//是否来自兑换商品成功的微信分享
@property (nonatomic, assign) BOOL isWXFromZaShiWuPage;//是否来自砸中实物成功的微信分享
@property (nonatomic, assign) BOOL isWXFromFreeUseGoodsPage;//是否来自试用商品的微信分享

@property (nonatomic, assign) BOOL isBeforeWXFromFreeUseGoods;//是否是来自 免费试用商品详情页面的申请试用按钮点击（申请试用前要先分享到微信朋友圈才有资格申请试用）

@property (nonatomic, assign) BOOL isFromExchangeGoodsPage;//来自兑换商品页面
@property (nonatomic, assign) BOOL isFromFreeUseDetailPage;//来自试用商品页面
@property (nonatomic, assign) BOOL isFromZaShiWuView;//来自砸中实物页面

@property (nonatomic, retain) NSString *questionCount;//最新提问的数量
@property (nonatomic, retain) NSString *messageCount;//最新消息的数量
@property (nonatomic, retain) NSString *eggCoinCount;//金蛋激励数量
@property (nonatomic, assign) BOOL isHavePic;//提问问题时 是否有图片
@property (nonatomic, assign) BOOL  isHomePage;//标记当前页面是否停留在首页，用于控制新提问数字提醒 偶尔出现的财富榜页
@property (nonatomic, retain) NSString *coinNumber;//金币数
@property (nonatomic, retain) NSString *jinDanPic;
@property (nonatomic, retain) NSString *jinDanTitle;

@property (nonatomic, retain) NSString *DanImageString;
@property (nonatomic, retain) NSString *afterImageString;
@property (nonatomic, retain) NSString *tipString;

@property (nonatomic, retain) NSString *upgradeGifString;//升级动画

@property (nonatomic, assign) BOOL reLoadHomeData,reLoadMessageData,reLoadWealthData,reLoadFreeUseData,reLoadMallData,reLoadSetData,reLoadProfileData;//左侧菜单的帅新控制标量
@property (nonatomic, assign) BOOL isReloadCoins;//是否刷新金币数
@property (nonatomic, assign) BOOL isReloadData_MyFreeUsePage;//我的试用列表刷新数据

@property (nonatomic, assign) BOOL isAddCoins_ExchangeGoodsWXShare;//兑换实物分享到微信是否需要加金币（只是第一次分享加金币）
@property (nonatomic, assign) BOOL isAddCoins_ExchangeGoodsSinaShare;//兑换实物分享到新浪微博是否需要加金币（只是第一次分享加金币）
@property (nonatomic, assign) BOOL isAddCoins_ExchangeGoodsTencentShare;//兑换实物分享到腾讯微博是否需要加金币（只是第一次分享加金币）

@property (nonatomic, assign) BOOL isAddCoins_ZaShiWuWXShare;//砸中实物金蛋分享微信是否需要加金币（只是第一次分享加金币）
@property (nonatomic, assign) BOOL isAddCoins_ZaShiWuSinaShare;//砸中实物金蛋分享新浪微博是否需要加金币（只是第一次分享加金币）
@property (nonatomic, assign) BOOL isAddCoins_ZaShiWuTencentShare;//砸中实物金蛋分享腾讯微博是否需要加金币（只是第一次分享加金币）

@property (nonatomic, assign) BOOL isAddCoins_FreeUseGoodsWXShare;//试用分享到微信和砸中金蛋分享微信是否需要加金币（只是第一次分享加金币）
@property (nonatomic, assign) BOOL isAddCoins_FreeUseGoodsSinaShare;//试用分享到新浪微博和砸中金蛋分享新浪微博是否需要加金币（只是第一次分享加金币）
@property (nonatomic, assign) BOOL isAddCoins_FreeUseGoodsTencentShare;//试用分享到腾讯微博和砸中金蛋分享腾讯微博是否需要加金币（只是第一次分享加金币）

@property (nonatomic, assign) BOOL isReloadProductDetailData;//刷新“产品详情”列表

@property (nonatomic, assign) BOOL photoRectFromZero;//相册第一个视图开始位置

@property (nonatomic, assign) BOOL isNewUser;//是否新用户

//@property (nonatomic, retain) TTImagePickerBar *imagePickerBar;//相册选多图的底部bar

@property (nonatomic, retain) NSMutableArray *urlArray;//记录已选图片地址

@property (nonatomic, assign) int totalSelectedCount;//选的图片总数

@property (nonatomic, assign) int returnToWhichPage;//记录相册

@property (nonatomic, assign) BOOL rectFromZero;//相册第一行是否从0位置排版

@property (nonatomic, retain) UIButton *photoTipButton;//相册多选图片数提示

@property (nonatomic, retain) UIScrollView *rootScrollView;

@property (nonatomic,assign) BOOL hasAlertLogin;//已经提示掉线登录

@property (nonatomic,assign) BOOL networkIsAvailable;//当前网络是否可用

@property (nonatomic,assign) BOOL isReloadDiaryList;//刷新心情日记列表

@property (nonatomic,assign) BOOL questionDetailWXShare;//提问详情微信分享提示

@property (nonatomic,assign) BOOL isQuestionDeatailQQShare;//来自 提问详情 的 qq分享（区分 产品详情）

@property (nonatomic,assign) BOOL isQuestionDeatailWXFriOrWXCircleShare;//来自 提问详情 的 微信好友还是微信朋友圈分享 yes:微信好友 no 微信朋友圈

@property (nonatomic,assign) BOOL isSystemMessTitle_TQRichTextView;//“消息”页面区分是不是有 &&关键字区分
@property (nonatomic,assign) BOOL isSystemMess_TQRichTextView;//区分是“消息”页面还是其他页面调用的TQRichTextView，做&&关键字区分
@property (nonatomic, retain) UIViewController  *presentLoginController;//需要登录的controller

@property (nonatomic,assign) BOOL noShareWX_FreeUseApply;//申请试用前如果分享过微信朋友圈后下次就不再弹出分享提示框

@property (nonatomic,retain) NSString *userLocationInfo;//用户当前的地理位置

@property (nonatomic,assign) BOOL removeTQTextDelegate;//删除主视图点击内容行响应事情通知（更换账号登录时 点击左侧栏的“首页” 进主视图 点击帖子进详情会push两次问题）

//单例
+ (id)instance;

//获取文件目录
- (NSString*)fileTextPath:(NSString*)fileName;

@end
