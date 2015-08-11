//
//  Define.h
//  BeautyMakeup
//
//  Created by hers on 13-11-5.
//  Copyright (c) 2013年 hers. All rights reserved.
//

//定义屏幕
#define kScreenBounds          [[UIScreen mainScreen] applicationFrame]

//iPhone5 定义
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否是ios7系统
#define kSystemIsIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0000

//判断系统是否是6系统以上
#define kSystemIsAboveIOS6 [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.000

//判断手机尺寸是否是iPhone5以上
#define iphoneTypeAbove5  [[UIScreen mainScreen] currentMode].size.height >= 1136

//appStore 地址
#define kAppStore               @"https://itunes.apple.com/cn/app/mei-zhuang-wen-da-5fen-zhong/id762139320?mt=8"

//评分
#define kAppStoreReview         @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=762139320"

//评分for ios 7
#define kAppStoreReviewForIos7  @"itms-apps://itunes.apple.com/app/id762139320"

//版本检查
#define kCheckVersion           @"http://wenda.hers.com.cn/mobile/ios_version"

//应用下载网页链接 （微信）
#define kAppDownloadURL         @"http://wenda.hers.com.cn/mobile/share"

//应用下载网页链接 （新浪微博、腾讯、qq）
#define kAppThirdDownLoadURL    @"http://beauty.hers.com.cn/app.php"

//爱奇艺AppKey
#define kQIYIAppKey @"f0720bf8314d494a93b28e9c8a6ca231"

//爱奇艺AppSecret
#define kQIYIAppSecret @"cab0a2e05c7ba98fc7d5aeb8a6c23dc0"

//上传视频时在主页面更新进度条
#define kChangeProgress @"changeProgressNum"

//上传视频完成后 隐藏进度条
#define kHideProgress   @"hideProgress"

//上传视频
#define kUploadVideo    @"uploadVideo"

//签到
#define kCheckinRemark  @"checkinRemark"

//签到成功左侧栏 签到改为已签到
#define kCheckined      @"checkined"

//发帖成功弹出框
#define kShowFatieRemind @"showFatieRemind"

//主视图发帖成功后 升级动画 显示
#define kShowUpgradeGif_HomePage    @"showUpgradeGif_HomePage"

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
#define kPhotoFromCamera                 @"kPhotoFromCamera"               //选取图片来自相机
#define kDeletePhotoFromBrowser          @"kDeletePhotoFromBrowser"        //从图片浏览器删除图片
#define kNetWorkTimeOutNotification      @"kNetWorkTimeOut"
#define kShowGoldEggForUsersNotification @"kShowGoldEggForUsersNotification"   //针对不登录/登录只浏览，不做交互的用户金蛋奖励机制
#define kShowGoldEggForUsersLoginNotification @"kShowGoldEggForUsersLoginNotification"   //针对机制登录后，用户金蛋奖励机制

#pragma mark---
#pragma mark---font

//定义字体
#define kFontArial22 [UIFont fontWithName:@"Arial" size:22]
#define kFontArial19 [UIFont fontWithName:@"Arial" size:19]
#define kFontArial18 [UIFont fontWithName:@"Arial" size:18]
#define kFontArial17 [UIFont fontWithName:@"Arial" size:17]
#define kFontArial16 [UIFont fontWithName:@"Arial" size:16]
#define kFontArial15 [UIFont fontWithName:@"Arial" size:15]
#define kFontArial14 [UIFont fontWithName:@"Arial" size:14]
#define kFontArial13 [UIFont fontWithName:@"Arial" size:13]
#define kFontArial12 [UIFont fontWithName:@"Arial" size:12]
#define kFontArial11 [UIFont fontWithName:@"Arial" size:11]
#define kFontArial10 [UIFont fontWithName:@"Arial" size:10]
#define kFontArial9  [UIFont fontWithName:@"Arial" size:9]

//定义粗体字体
#define kFontArialBoldMT22 [UIFont fontWithName:@"Arial-BoldMT" size:22]
#define kFontArialBoldMT19 [UIFont fontWithName:@"Arial-BoldMT" size:19]
#define kFontArialBoldMT18 [UIFont fontWithName:@"Arial-BoldMT" size:18]
#define kFontArialBoldMT17 [UIFont fontWithName:@"Arial-BoldMT" size:17]
#define kFontArialBoldMT16 [UIFont fontWithName:@"Arial-BoldMT" size:16]
#define kFontArialBoldMT15 [UIFont fontWithName:@"Arial-BoldMT" size:15]
#define kFontArialBoldMT14 [UIFont fontWithName:@"Arial-BoldMT" size:14]
#define kFontArialBoldMT13 [UIFont fontWithName:@"Arial-BoldMT" size:13]
#define kFontArialBoldMT12 [UIFont fontWithName:@"Arial-BoldMT" size:12]
#define kFontArialBoldMT11 [UIFont fontWithName:@"Arial-BoldMT" size:11]

//定义项目红，绿 两种主基调颜色
#define kRedColor [UIColor colorWithRed:255.0f/255.0f green:139.0f/255.0f blue:169.0f/255.0f alpha:1.0f]
#define kGreenColor [UIColor colorWithRed:114.0f/255.0f green:221.0f/255.0f blue:195.0f/255.0f alpha:1.0f]
#define kDarkGreenColor [UIColor colorWithRed:113.0f/255.0f green:138.0f/255.0f blue:130.0f/255.0f alpha:1.0f]
#define kGrayColor  [UIColor colorWithRed:133.0f/255.0f green:120.0f/255.0f blue:122.0f/255.0f alpha:1];

//黄绿色用户名等
#define kUserNameColor [UIColor colorWithRed:170.0f/255.0f green:183.0f/255.0f blue:77.0f/255.0f alpha:1.0f]

//鲜艳的绿色 圈子关注等
#define kFreshGreenColor [UIColor colorWithRed:146.0f/255.0f green:209.0f/255.0f blue:94.0f/255.0f alpha:1.0f]

//正文黑色
#define kContentColor [UIColor colorWithRed:61.0f/255.0f green:52.0f/255.0f blue:54.0f/255.0f alpha:1.0f]

//左侧栏 黑色
#define kLeftContentColor [UIColor colorWithRed:71.0f/255.0f green:71.0f/255.0f blue:71.0f/255.0f alpha:1.0f]

//年龄、时间、评论数等属性浅灰色
#define kLightGrayColor [UIColor colorWithRed:133.0f/255.0f green:120.0f/255.0f blue:122.0f/255.0f alpha:1.0f]

//肤质测试结果标题红色
#define kSkinRedColor   [UIColor colorWithRed:248.0f/255.0f green:159.0f/255.0f blue:185.0f/255.0f alpha:1.0f]

//设置个人资料标题深灰色
#define kSetProfileDarkGrayColor   [UIColor colorWithRed:148.0f/255.0f green:136.0f/255.0f blue:138.0f/255.0f alpha:1.0f]

//金币商城“我的金币数”深蓝色
#define kCoinsMailDarkBlueColor   [UIColor colorWithRed:107.0f/255.0f green:209.0f/255.0f blue:188.0f/255.0f alpha:1.0f]

//金币商城商品金币数玫红色
#define kCoinsMailDarkRedColor   [UIColor colorWithRed:255.0f/255.0f green:140.0f/255.0f blue:175.0f/255.0f alpha:1.0f]

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

#define kSinaShareBind_ExchangeGoods @"sinaShareBind_ExchangeGoods" //“兑换商品”sina分享绑定回调

#define kChangeInvitedFriendsNum @"changeNum"               //邀请好友的数目更改

#define kAddLoginView            @"toAddLoginView"          //添加登录视图

#define kRemoveLoginView         @"toRemoveLoginView"       //移除登录视图

#define kGetLoginUserInfo        @"getLoginUserInfo"        //拿到登录用户信息

#define kShowLoginSucceedTips    @"ShowLoginSucceedTips"        //显示登录成功提示

#define kReloadData              @"ReloadData"              //详情页重新加载数据

#define kReloadData_FreeUseDetailPage  @"reloadData_FreeUseDetailPage"  //试用商品详情重新加载数据

#define kReloadData_AuditQuery  @"reloadData_AuditQuery"    //审核进程信息重新加载数据

#define kGetJinDan               @"kGetJinDan"              //得到金蛋

#define kGetShiWu                @"kGetShiWu"               //得到实物

#define ktoDisappearTheView      @"ktoDisappearTheView"    //让金蛋消失

#define kHiddenNavigationBar     @"kHiddenNavigationBar"    //隐藏系统上导航

#define kReloadSystemData        @"kReloadSystemData"      //systemdata页加载数据

#define kUpgradeGif              @"kUpgradeGif"           //回复成功后升级动画

#define ktoTopRefreshWenDaPageData         @"toTopRefreshData0"    //刷新问答数据并回到顶部
#define ktoTopRefreshFirstXiuData          @"toTopRefreshData1"    //刷新秀数据并回到顶部
#define ktoTopRefreshCheDanPageData        @"toTopRefreshData2"    //刷新扯淡数据并回到顶部
#define ktoTopRefreshReMenPageData         @"toTopRefreshData3"     //刷新热门数据并回到顶部
#define ktoTopRefreshQiangDaPageData       @"toTopRefreshData4"     //刷新抢答数据并回到顶部

#define ktimeAfter                         @"10"                   //刷新数据的时间间隔
#define kalwaysRefreshFirstPageData        @"kalwaysRefreshFirstPageData"    //没有时间限制刷新最新页数据并回到顶部
#define kalwaysRefreshFourthPageData       @"kalwaysRefreshFourthPageData"    //没有时间限制刷新抢答页数据并回到顶部

#define kGetJinDan0               @"kGetJinDan0"              //问答提问得到金蛋

#define kGetJinDan1               @"kGetJinDan1"              //美妆提问得到金蛋

#define kGetJinDan2               @"kGetJinDan2"              //秀提问得到金蛋

#define kGetJinDan3               @"kGetJinDan3"              //私房话提问得到金蛋

#define kGetJinDan4               @"kGetJinDan4"              //热门提问得到金蛋

#define kGetJinDan5               @"kGetJinDan5"              //抢答提问得到金蛋

#define kTransferPostNotification           @"kTransferPostNotification"             //发帖成功后，转移通知
#define kRefreshTransferPageNotification    @"kRefreshTransferPageNotification"      //发帖成功后，转移到的页面刷新数据

//ZBMessage ToolBar 事件消息
#define kZBMessageKeyBoardNotification     @"kZBMessageKeyBoardNotification"   //键盘
#define kZBMessageFaceNotification         @"kZBMessageFaceNotification"       //表情
#define kZBMessagePictureNotification      @"kZBMessagePictureNotification"    //图片
#define kZBMessageVoiceNotification        @"kZBMessageVoiceNotification"      //语音



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

//精品应用推荐
#define kCommandUrl             @"http://push.hers.cn/record/recommends?app=iphone&type=5"

#pragma --mark ============== 接口数据请求 ==============

//定义请求数据长度
#define kCount @"20"

//爱物美妆 管理员uid
#define kAdministratorUid      @"4162"

//启动收集若干用户信息
#define kGatherUserInformation  @"http://wenda.hers.com.cn/mobile/gather"

//首页 最新
#define kHomePageNeweest        @"http://wenda.hers.com.cn/mobile/questions?type=%@&page=%@&pagesize=%@&maxid=%@&version=1"

//首页的最热 关注 抢答
#define kHomePageOtherThree     @"http://wenda.hers.com.cn/mobile/questions?type=%@&page=%@&pagesize=%@&maxid=%@&version=1"

//系统消息
#define kSystemMessage          @"http://wenda.hers.com.cn/mobile/system_message?id=%@&page=%@&pagesize=%@"

//问题详情
#define kQuestionDetail         @"http://wenda.hers.com.cn/mobile/question?id=%@&owner=%@&page=%@&pagesize=%@"

//取消对问题赞
#define kCancleVoteTheQuestion  @"http://wenda.hers.com.cn/mobile/unvote?id=%@"

//对问题赞
#define kVoteTheQuestion        @"http://wenda.hers.com.cn/mobile/vote?type=%@&id=%@"

//收藏接口
#define kStoreQuestion          @"http://wenda.hers.com.cn/mobile/collect?id=%@"

//砸蛋接口
#define kZaDan                  @"http://wenda.hers.com.cn/mobile/hitegg"

//金币商城砸蛋接口
#define kMallZaDan              @"http://wenda.hers.com.cn/mobile/hitpegg?id=%@"

//取消收藏接口
#define kCancelStoreQuestion    @"http://wenda.hers.com.cn/mobile/uncollect?id=%@"

//提问删除
#define kDeleteTheQuestion      @"http://wenda.hers.com.cn/mobile/questiondel?id=%@"

//回答删除
#define kDeleteTheAnswer        @"http://wenda.hers.com.cn/mobile/answerdel?id=%@"

//个人主页
#define kProfile                @"http://wenda.hers.com.cn/mobile/profile?uid=%@"

//编辑个人资料
#define kModifyProfile          @"http://wenda.hers.com.cn/mobile/update_profile"

//回答问题
#define kAnswerQuestion         @"http://wenda.hers.com.cn/mobile/answer"

//对回答的回复
#define kReplyAnswerQuestion    @"http://wenda.hers.com.cn/mobile/reply"

//提问问题
#define kAskQuestion            @"http://wenda.hers.com.cn/mobile/ask"

//第三方登录
#define kThirdLogin             @"http://wenda.hers.com.cn/mobile/login?type=%@"

//第三方互绑
#define kThirdBind              @"http://wenda.hers.com.cn/mobile/bind?target=%@"

//第三方退出
#define kThirdLoginout          @"http://wenda.hers.com.cn/mobile/logout"

//返回个人信息
#define kReturnUserInfo         @"http://wenda.hers.com.cn/mobile/account"

//解绑
#define kRemoveBind             @"http://wenda.hers.com.cn/mobile/unbind"

//返回微博好友列表
#define kSinaFriendsList        @"http://wenda.hers.com.cn/mobile/tweibofriends?page=%@&pagesize=%@"//@"http://wenda.hers.com.cn/mobile/weibofriends?page=%@&pagesize=%@"

//新浪微博好友邀请
#define kSinaFriendsInvite      @"http://wenda.hers.com.cn/mobile/weiboinvite?sinaids=%@&action=%@"

//QQ或者微信好友邀请
#define kQQOrWeixinFriendsInvite @"http://wenda.hers.com.cn/mobile/txinvite?type=%@"

//财富榜
#define kTotalWealth            @"http://wenda.hers.com.cn/mobile/wealth?type=%@"

//金币详情
#define kCoinsDetail            @"http://wenda.hers.com.cn/mobile/coindetail"

//个人消息
#define kMessages               @"http://wenda.hers.com.cn/mobile/messages?page=%@&pagesize=%@"

//我的提问
#define kMyQuestions            @"http://wenda.hers.com.cn/mobile/myquestions?page=%@&pagesize=%@"

//TA的提问
#define kOtherQuestions         @"http://wenda.hers.com.cn/mobile/myquestions?uid=%@&page=%@&pagesize=%@"

//我的回答
#define kMyAnswers              @"http://wenda.hers.com.cn/mobile/myanswers?page=%@&pagesize=%@"

//TA的回答
#define kOtherAnswers           @"http://wenda.hers.com.cn/mobile/myanswers?uid=%@&page=%@&pagesize=%@"

//我的赞同
#define kMyLover                @"http://wenda.hers.com.cn/mobile/myvotes?page=%@&pagesize=%@"

//TA的赞同
#define kOtherLover             @"http://wenda.hers.com.cn/mobile/myvotes?uid=%@&page=%@&pagesize=%@"

//赞同我的
#define kLoverMe                @"http://wenda.hers.com.cn/mobile/myvoted?page=%@&pagesize=%@"

//赞同TA的
#define kOtherLoverMe           @"http://wenda.hers.com.cn/mobile/myvoted?uid=%@&page=%@&pagesize=%@"


//最新提问数量
#define kNewestCount            @"http://wenda.hers.com.cn/mobile/newcount?lastid=%@&udid=%@"

//举报问题
#define kReport                 @"http://wenda.hers.com.cn/mobile/report?id=%@"

//收藏列表
#define kStoreList              @"http://wenda.hers.com.cn/mobile/mycollects?page=%@&pagesize=%@"

//关注/取消关注用户
#define kFollowUser             @"http://wenda.hers.com.cn/mobile/follow?target=%@"

//关注/粉丝列表
#define KAttentionOrFanList     @"http://wenda.hers.com.cn/mobile/relations?uid=%@&type=%@&page=%@&pagesize=%@"

//删除消息
#define kDeleteMessage          @"http://wenda.hers.com.cn/mobile/messagedel?ids=%@"

//获取金蛋记录
#define kEggsRecord             @"http://wenda.hers.com.cn/mobile/egg_orders?uid=%@&page=%@&pagesize=%@"

//金币商城中兑换商品的列表
#define kExchageGoodsList       @"http://wenda.hers.com.cn/mobile/products?type=%@&page=%@&pagesize=%@&version=1"

//用户的兑换记录
#define kExchangeRecord         @"http://wenda.hers.com.cn/mobile/mall_orders?page=%@&pagesize=%@"

//兑换商品
#define kExchangeGoods          @"http://wenda.hers.com.cn/mobile/exchange?id=%@"

//用户最近使用的收货地址
#define kRecentlyReceiveAddress @"http://wenda.hers.com.cn/mobile/get_address"

//更新订单地址
#define kChangeOrderAddress     @"http://wenda.hers.com.cn/mobile/address"

//分享和同步到第三方的问题详情链接
#define kShareQuestionUrl       @"http://wenda.hers.com.cn/mobile/sharequestion?id=%@"

//获取最新的金蛋提提醒
#define kNewestEggTips          @"http://wenda.hers.com.cn/mobile/newegg"

//分类信息列表
#define kCategoryInfo           @"http://wenda.hers.com.cn/mobile/categories"

//具体分类列表
#define kCategoryList           @"http://wenda.hers.com.cn/mobile/questions?type=%@&category=%@&tag=%@&page=%@&pagesize=%@&version=1"

//兑换商品成功的分享加金币和 砸中实物金蛋的分享加金币
#define kShareAddCoins          @"http://wenda.hers.com.cn/mobile/sharecoin"

//试用商品列表
#define kUseGoodsList           @"http://wenda.hers.com.cn/mobile/trial_products?page=%@&pagesize=%@"

//申请试用
#define kApplyFreeUse           @"http://wenda.hers.com.cn/mobile/apply?id=%@"

//试用商品详情页
#define kFreeUseDetail          @"http://wenda.hers.com.cn/mobile/trial_product?id=%@"

//试用商品审核查询
#define kAuditQuery             @"http://wenda.hers.com.cn/mobile/applydetail?id=%@"

//品牌商品详情
#define kProductDetail          @"http://wenda.hers.com.cn/mobile/brand_product?id=%@&page=%@&pagesize=%@"

//我的试用
#define kMyFreeUse              @"http://wenda.hers.com.cn/mobile/trial_orders?type=%@&page=%@&pagesize=%@"

//品牌商品详情
#define kBrandProductDetail     @"http://wenda.hers.com.cn/mobile/brand_product?id=%@&type=%@&page=%@&pagesize=%@"

//等级定义页面地址
#define kLevelUrl               @"http://wenda.hers.com.cn/level.htm"

//点评
#define kCommentProduct         @"http://wenda.hers.com.cn/mobile/comment"

//我的点评
#define kMyComment              @"http://wenda.hers.com.cn/mobile/mycomments?page=%@&pagesize=%@"

//品牌商品列表
#define kProductList            @"http://wenda.hers.com.cn/mobile/brand_products?brand=%@&cat1=%@&cat2=%@&order=%@&page=%@&pagesize=%@"

//品牌分类
#define kBrandCategory          @"http://wenda.hers.com.cn/mobile/brand_categories"

//对“产品详情”页面点评投票
#define kVote_Comment           @"http://wenda.hers.com.cn/mobile/comment_vote?id=%@"

//产品详情的点评删除
#define kComment_Delete         @"http://wenda.hers.com.cn/mobile/commentdel?id=%@"

//设置取消最佳答案
#define kSetBestAnswer          @"http://wenda.hers.com.cn/mobile/setbest?id=%@"

//邀请金蛋
#define kInviteEgg              @"http://wenda.hers.com.cn/mobile/inviteegg?target=%@&token=%@"

//砸邀请金蛋
#define kHitInviteEgg           @"http://wenda.hers.com.cn/mobile/hit_activity_egg?target=%@"

//首页列表带二级筛选
#define kHomeList               @"http://wenda.hers.com.cn/mobile/questions?type=%@&sub=%@&category=%@&essence=%@&maxid=%@&page=%@&pagesize=%@&version=1"

//关注/取消关注圈子
#define kAttentionCircle        @"http://wenda.hers.com.cn/mobile/watch?type=%@&category=%@"

//写心情日记
#define kWriteDiary             @"http://wenda.hers.com.cn/mobile/write_diary"

//心情日记列表
#define kDiaryList              @"http://wenda.hers.com.cn/mobile/diaries?uid=%@&page=%@&pagesize=%@"

//问题分享记录
#define kQuestionShareRecord    @"http://wenda.hers.com.cn/mobile/questionshare?id=%@&type=%@"

//用户签到
#define kUserCheckin            @"http://wenda.hers.com.cn/mobile/checkin"

//用户今日所获金币详情
#define kTodayCoinsDetail       @"http://wenda.hers.com.cn/mobile/todaycoindetail"

