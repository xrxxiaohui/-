//
//  Define.h
//  BeautyMakeup
//
//  Created by hers on 13-11-5.
//  Copyright (c) 2013年 hers. All rights reserved.
//

//定义屏幕
#define kScreenBounds          [[UIScreen mainScreen] applicationFrame]
#define kScreenWidth           [[UIScreen mainScreen] applicationFrame].size.width
#define kScreenHeight          [[UIScreen mainScreen] applicationFrame].size.height


//iPhone5 定义
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//iPhone4 定义
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)


#define kConnectUs @"http://app.xjlastmile.com/lxwm/201505/07/t20150507_2132921.shtml"

#define kAboutUs @"http://app.xjlastmile.com/gywm/201505/07/t20150507_2132919.shtml"

#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//判断是否是ios7系统
#define kSystemIsIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

//常用链接
#define Links    @"http://x.watching.cn/"
//接口链接
#define interfaceLinks    @"http://h.watching.cn/"

//#define Links @"http://app.xjlastmile.com/"
#define kIsWifiEnable     [CheckNetwork IsEnableWIFI]


#define kSuggestionUrl @"http://h.watching.cn/last1km/suggest.php?suggestion=%@&email=%@"

//评分for ios 7
#define kAppStoreReviewForIos7  @"itms-apps://itunes.apple.com/app/id762139320"

//版本检查
#define kCheckVersion           @"http://wenda.hers.com.cn/mobile/ios_version"

//应用下载网页链接 （微信）
#define kAppDownloadURL         @"http://wenda.hers.com.cn/mobile/share"

//应用下载网页链接 （新浪微博、腾讯、qq）
#define kAppThirdDownLoadURL    @"http://beauty.hers.com.cn/app.php"

#pragma mark---
#pragma mark--- QQLogin

#define qqAppKey                         @"100584329"  //QQAppID

#define kGifView                         @"gifInfo"                      //登录后返回到登录页面时gif动画重新加载
#define kResponse                        @"kResponse"                    //获取用户个人信息回调key值
#define kUpdateLastedQusetionCount       @"kUpdateLastedQusetionCount"   //更新最新提问数量
#define kUpdateNewMessageCount           @"kUpdateNewMessageCount"       //更新最新提问数量
#define kShowNewestNumber                @"kShowNewestNumber"            //展示最新提问数的条数
#define kUpdateProfile                   @"kUpdateProfile"               //个人资料修改后,更新个人主页

#define kTencentShare_NoPic              @"https://graph.qq.com/t/add_t" //腾讯微博不带图片分享、同步
#define kTencentShare_HavePic            @"https://graph.qq.com/t/add_pic_t"//腾讯微博带图片分享、同步
#define kRegisterPushNotification        @"kRegisterPushNotification"    //注册该用户的推送消息
#define kResetNavigationBarNotification  @"kResetNavigationBarNotification" //金币商城，查看完图片后返回，重新显示bar
#define kRefreshEggsAddressNotification  @"kRefreshEggsAddressNotification" //金蛋地址，修改成功后刷新数据
#define kHideMenuControllerImage  @"kHideMenuControllerImage"               //隐藏menucontroller背景

#pragma mark---
#pragma mark---font

//定义字体
#define kFontArial22 [UIFont fontWithName:@"Arial" size:22]
#define kFontArial17 [UIFont fontWithName:@"Arial" size:17]
#define kFontArial16 [UIFont fontWithName:@"Arial" size:16]
#define kFontArial15 [UIFont fontWithName:@"Arial" size:15]
#define kFontArial14 [UIFont fontWithName:@"Arial" size:14]
#define kFontArial13 [UIFont fontWithName:@"Arial" size:13]
#define kFontArial12 [UIFont fontWithName:@"Arial" size:12]
#define kFontArial11 [UIFont fontWithName:@"Arial" size:11]
#define kFontArial8 [UIFont fontWithName:@"Arial" size:8]

//定义项目红，绿 两种主基调颜色
#define kRedColor [UIColor colorWithRed:255.0f/255.0f green:114.0f/255.0f blue:114.0f/255.0f alpha:1.0f]
#define kGreenColor [UIColor colorWithRed:116.0f/255.0f green:209.0f/255.0f blue:187.0f/255.0f alpha:1.0f]
#define kDarkGreenColor [UIColor colorWithRed:113.0f/255.0f green:138.0f/255.0f blue:130.0f/255.0f alpha:1.0f]
#define kGrayColor  [UIColor colorWithRed:186.0f/255.0f green:189.0f/255.0f blue:196.0f/255.0f alpha:1];
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]


#pragma mark---
#pragma mark---SinaLogin

#define kAppKey          @"2692739356"      //新浪微博3103247767
#define kSinaScheme      @"wb2692739356"    //新浪微博APPSecret
#define kRedirectURI     @"http://bbs.hers.com.cn/xwb.php?m=xwbAuth.authCallBack"         //微博开放平台中授权设置的应用回调页http://
#define kAppSecret       @"bc2bac2e35da7d24f739006b83c769a3" //美妆客户端 appSecret 36aa9a601305cdfc47fbf6688fd5b1e6

#pragma mark
#pragma mark -- Third CallBack 通知

#define kOAuthPrivateKey         @"hers.wenda.mobile.key"   //登录秘钥 md5 key

#define kSinaServeLogin          @"sinaServeLogin"          //sina登录回调

#define kSinaServeBind           @"sinaServeBind"           //sina设置视图绑定回调

#define kSinaShareBind           @"sinaShareBind"           //sina分享绑定回调

#define kSinaSynBind             @"sinaSynBind"             //sina同步绑定回调

#define kSinaInvitedBind         @"sinaInvitedBind"         //sina邀请好友绑定回调




#pragma --mark ============== 统计相关 ==============

//应用首次启动
#define kApplicationInitial     @"http://push.hers.cn/record/initial?app=iphone&type=5&uid=%@&source=%@&version=%@&os=%@&md5=%@"
//应用启动
#define kApplicationRun         @"http://push.hers.cn/record/run?app=iphone&type=5&uid=%@&source=%@&version=%@&os=%@&md5=%@"

//应用停止
#define kApplicationStop        @"http://push.hers.cn/record/stop?app=iphone&type=5&uid=%@&md5=%@"

//应用挂起
#define kApplicationBack        @"http://push.hers.cn/record/back?app=iphone&type=5&uid=%@&md5=%@"

//应用激活
#define kApplicationFront       @"http://push.hers.cn/record/front?app=iphone&type=5&uid=%@&md5=%@"

//统计事件
#define kCountEvents            @"http://push.hers.cn/record/event?app=iphone&type=5&uid=%@&event=%@&md5=%@"


//登陆
//注册
#define kRegist @"/interface.php?mod=register&username=%@&nickname=%@&password=%@&code=%@"
//个人信息
#define kGeRenInfo @"/interface.php?mod=userinfo"
//#define kGeRenInfo @"/interface.php?mod=userinfo&type=me&token=%@";


//根据newsId获取tid
#define kNewsIdToTid @"/interface.php?mod=gettidfromnewsid"
//评论
#define kPingLun @"/interface.php?mod=viewthread&type=reply&tid=%@&page=%@&token=%@&type=levelreply"


#pragma --mark ============== 接口数据请求 ==============
#define avatarUrl     @"http://www.shunshunliuxue.com/uploads/avatar/"

//请求前缀
#define kHeader @"http://api.shunshunliuxue.com"
//#define kHeader @"http://123.57.2.117"

#define kRegister      @"%@/account/api/register_process/?"
#define kLogin         @"%@/account/api/login_process/?"
#define kYanZhengMa    @"%@/account/api/send_sms/?"
#define kCategoryUrl   @"%@/topic/api/topic_catalog/?"

//需要传token
#define kQuestionUrl   @"%@/question/api/question_list/?sort_type=%@&category=%@&page=%@&token=%@"
//点赞 取消点赞
#define kVoteTheAnswer @"%@/question/api/answer_vote/?answer_id=%@&token=%@&value=1"
//问题info
#define kQuestionInfo  @"%@/question/api/question/?id=%@&page=%@&token=%@"
//关注问题
#define kCareQuestion  @"%@/question/api/focus/?question_id=%@&token=%@"
//添加回答  attach_access_key暂时没有写
#define kSaveAnswer    @"%@/question/api/save_answer/?"
//编辑修改回答  attach_access_key meiyou xie
#define kUpdateAnswer  @"%@/question/api/update_answer/?"
//hot_topic
#define kHotTopic      @"%@/topic/api/hot_topics/?"
//focus_topics_list
#define kFocusTopic    @"%@/home/api/focus_topics_list/?page=%@&token=%@"
//focus_question_list
#define kFocusQuestionList  @"%@/home/api/focus_question_list/?"
//get_user_friends
#define kFocusFriendList    @"%@/follow/api/get_user_friends/?"
//我的提问
#define kFocusUserQuestion  @"%@/people/api/user_question/?"
//发布问题
#define kFaBuQuestion @"%@/publish/api/publish_question/?"
//我的回答
#define kFocusUserAnswer  @"%@/people/api/user_answer/?"
//定义请求数据长度
#define kCount @"10"

//爱物美妆 管理员uid
#define kAdministratorUid      @"4162"

//-----------------------------
//关注
#define kGuanzhu @"interface.php?mod=getmyfollow&token=%@"
/*
 获取tid
 */
#define KUid @"interface.php?mod=gettidfromnewsid&news_id=%@&news_title=%@&doctime=%@"

/*
 新闻点赞
 */
#define KDianZan @"interface.php?mod=zan&tid=%@&token=%@"

/*
 用户点赞
 */
#define KUserDZ @"interface.php?mod=zan&pid=%@&token=%@"

//取消关注
#define kQuXiaoGuanZhu @"interface.php?mod=unfollow&zb_id=%@&zb_name=%@&token=%@"
//取消收藏
#define kQuXiaoShouCang @"interface.php?mod=delfavo&news_id=%@&token=%@"

//验证码(注册或者激活时调用)
//检测验证码是否正确
//#define kSureYanZhengMa @"interface.php?mod=verifyphone&type=forget&username=%@"
//忘记密码的接口(忘记密码的时候调用)
#define kForgetPassword @"interface.php?mod=verifyphone&type=forget&username=%@"
#define kGetPassword @"interface.php?mod=forgetpass&username=%@&code=%@"

//修改密码的借口
#define  kChangePassword @"interface.php?mod=changepasswd&token=%@&newpassword=%@&oldpassword=%@"

//修改个人资料的昵称
#define kMyInfo @"interface.php?mod=modifyinfo&token=%@&nickname=%@"
//修改bio
#define kMyInfoBio @"interface.php?mod=modifyinfo&token=%@&bio=%@"
//修改头像
#define kMyImage @"interface.php?mod=modifyinfo&token=%@"

//发表评论
#define kSendRemark @"interface.php?mod=newreply&token=%@"


////增加主播关注
//#define kGuanZhuZhuBo @"interface.php?mod=follow&zb_id=%@&zb_name=%@&token=%@"

//增加主播关注
#define kGuanZhuZhuBo @"interface.php?mod=follow&zb_id=%@&zb_name=%@&avataraddr=%@&token=%@"



//通过newsid获取评论数
#define kGetRemarkFromId @"http://h.watching.cn/interface.php?mod=getreplynum&news_id=%@&news_title=%@&dateline=%@"

//新闻页收藏        NSMutableArray *ShouCangArr = [[NSMutableArray alloc]initWithObjects:_newsId,_titleString,_summaryString,_urlString,_dateString,_imageString,token, nil];

//#define kSaveNews @"interface.php?mod=addfavo&news_id=%@&news_title=%@&news_summary=%@&news_link=%@&dateline=%@&news_page_img=%@&token=%@&type=%@"
#define kSaveNews @"interface.php?mod=addfavo&news_id=%@&news_title=%@&news_summary=%@&news_link=%@&dateline=%@&news_page_img=%@&token=%@&type=%@"
//获取通知
#define kTongZhi @"interface.php?mod=noticelist&token=%@"

//s删除通知
#define kDeleteTongZhi @"interface.php?mod=delnotice&token=%@&uid=%@&gpmid=%@"

//用户未读取通知数目
#define kNoRead @"interface.php?mod=getunread&token=%@"

//有声页面收藏
#define kSaveYouSheng  @"interface.php?mod=addfavo&zb_id=%@&zb_name=%@&summary=%@&video=%@&token=%@&type=%@"

//获取收藏的新闻
#define kGetShouCang @"interface.php?mod=getfavo&token=%@"

//第三方登陆激活接口
#define kOtherLogin @"interface.php?mod=active&userID=%@&username=%@&password=%@&type=%@"

//批量获取赞与评论
#define kMoreLikeAndReviews @"interface.php?mod=getreplynumall&news_id_%d=%@"
/** 发表评论 **/
#define REQUEST_COMMENT @"interface.php?mod=newreply&news_id=%@&token=%@&message=%@&news_title=%@&point=%@"

/** 对评论发表评论 **/
#define REQUEST_COMMENT_COMMENT @"interface.php?mod=newreply&news_id=%@&token=%@&message=%@&news_title=%@&point=%@&reply_pid=%@"

/** 法律信息H5页*/
#define kLawInfo @"http://api.shunshunliuxue.com/m/client/servies/"

/** 关于顺顺H5页*/
#define kAboutShunshun @"http://api.shunshunliuxue.com/m/client/statement/"

/** 意见反馈接口*/
#define kAdviceFeedback @"http://api.shunshunliuxue.com/about/api/feedback/"

#define top_H 64

#define BACK_X 0
#define BACK_Y 5
#define BACK_WEITH 30
#define BACK_HIGHT 30

#define OTHERBTN_X 0
#define OTHERBTN_Y 5
#define OTHERBTN_WEITH 30
#define OTHERBTN_HIGHT 30

#define LOGIN_BG [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg" ofType:@"png"]]

#define LOGIN_BG_568h [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg_568h" ofType:@"png"]]

#define INPUT_BG [UIImage imageNamed:@"input_bg"]//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"input_bg" ofType:@"png"]]

#define INPUT_BG_Text [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"input_bg_text" ofType:@"png"]]

#define ACCOUNT_BG [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"account" ofType:@"png"]]
#define PASSWORD_BG [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"password" ofType:@"png"]]
#define LOGIN_BTN_BG [UIImage imageNamed:@"login_btn_bg"]//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"login_btn_bg" ofType:@"png"]]

#define WINXIN_LOGIN_BG [UIImage imageNamed:@"weixin"]// [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weixin" ofType:@"png"]]
#define QQ_LOGIN_BG [UIImage imageNamed:@"QQ"]//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QQ" ofType:@"png"]]

#define BACK_IMAGE [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"leftReturn" ofType:@"png"]]
#define CANCLE_IMAGE [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"close" ofType:@"png"]]
#define LOGIN_BG [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg" ofType:@"png"]]

#define LOGIN_BG_568h [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg_568h" ofType:@"png"]]

#define INPUT_BG [UIImage imageNamed:@"input_bg"]//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"input_bg" ofType:@"png"]]
#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define INPUT_BG_Text [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"input_bg_text" ofType:@"png"]]

#define ACCOUNT_BG [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"account" ofType:@"png"]]
#define PASSWORD_BG [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"password" ofType:@"png"]]
#define LOGIN_BTN_BG [UIImage imageNamed:@"login_btn_bg"]//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"login_btn_bg" ofType:@"png"]]

#define WINXIN_LOGIN_BG [UIImage imageNamed:@"weixin"]// [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weixin" ofType:@"png"]]
#define QQ_LOGIN_BG [UIImage imageNamed:@"QQ"]//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QQ" ofType:@"png"]]

#define BACK_IMAGE [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"leftReturn" ofType:@"png"]]
#define CANCLE_IMAGE [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"close" ofType:@"png"]]
#define COLOR1(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

//cell accessoryType
#define CellAccessoryNone @"UITableViewCellAccessoryNone"                   // don't show any accessory view
#define CellAccessoryDisclosureIndicator @"UITableViewCellAccessoryDisclosureIndicator"    // regular chevron. doesn't track
#define CellAccessoryDetailDisclosureButton @"UITableViewCellAccessoryDetailDisclosureButton" // blue button w/ chevron. tracks
#define CellAccessoryCheckmark @"UITableViewCellAccessoryCheckmark"

#define kCellSegue @"kCellSegue" //cell要跳转的

