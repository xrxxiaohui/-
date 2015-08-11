//
//  CommonModel.h
//  ChuanDaZhi
//
//  Created by hers on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FatherModel.h"
#import "Define.h"
#import "ConstObject.h"

@interface CommonModel : FatherModel

- (id)initWithTarget:(id)aDelegate;

//启动收集若干用户信息
- (void)requestGatherUserInformation:(NSDictionary *)aParameter
                  httpRequestSucceed:(SEL)httpRequestSucceed
                   httpRequestFailed:(SEL)httpRequestFailed;

//首页最新
- (void)requestNeweest:(NSArray *)anArray
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed;

//个人主页
- (void)requestProfile:(NSString *)anUid
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed;

//首页的最热 关注 抢答
- (void)requestOtherThree:(NSArray *)anArray
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//编辑个人资料
- (void)requestModifyProfile:(NSDictionary *)aParameter
          httpRequestSucceed:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed;

//提问详情
-(void)requestQuestionDetail:(NSArray *)anArray
          httpRequestSucceed:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed;

//取消收藏
-(void)requestCancelStoreQuestion:(NSString *)questionID
               httpRequestSucceed:(SEL)httpRequestSucceed
                httpRequestFailed:(SEL)httpRequestFailed;

//财富榜    财富总榜 aType=0  周榜 aType=1
- (void)requestWealthList:(NSString *)aType
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//收藏
-(void)requestStoreQuestion:(NSString *)questionID
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;
//第三方登录
- (void)requestThirdLogin:(NSString *)aParameter
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//第三方互绑
- (void)requestThirdBind:(NSString *)aParameter
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed;

//第三方退出
- (void)requestThirdLoginout:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed;

//返回个人信息
- (void)requestReturnUserInfo:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed;

//解除绑定
- (void)requestRemoveBind:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//返回微博好友列表
- (void)requestSinaFriendsList:(NSString *)aPage
                      pageSize:(NSString *)aPageSize
            httpRequestSucceed:(SEL)httpRequestSucceed
             httpRequestFailed:(SEL)httpRequestFailed;

//邀请新浪微博好友
- (void)requestSinaFriendsInvited:(NSArray *)anArray
               httpRequestSucceed:(SEL)httpRequestSucceed
                httpRequestFailed:(SEL)httpRequestFailed;

//邀请QQ或者微信好友
- (void)requestQQOrWXFriendsInvited:(NSString *)type
                 httpRequestSucceed:(SEL)httpRequestSucceed
                  httpRequestFailed:(SEL)httpRequestFailed;

//对问题点赞
-(void)requestVoteTheQuestion:(NSString *)aType
                   questionID:(NSString *)aQuestionID
           httpRequestSucceed:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed;
//取消对问题点赞
-(void)requestCancelVoteTheQuestion:(NSString *)questionID
                 httpRequestSucceed:(SEL)httpRequestSucceed
                  httpRequestFailed:(SEL)httpRequestFailed;

//回答问题
- (void)requestAnswerQuestion:(NSDictionary *)aParameter
                    dataArray:(NSArray *)aDataArray
           httpRequestSucceed:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed;

//金币详情
- (void)requestCoinsDetail:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//提问问题
- (void)requestAskQuestion:(NSDictionary *)aParameter
                 dataArray:(NSArray *)aDataArray
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//个人消息
- (void)requestMessages:(NSString *)aPage
               pageSize:(NSString *)aPageSize
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//我的提问
- (void)requestMyQuestionsList:(NSString *)aPage
                      pageSize:(NSString *)aPageSize
            httpRequestSucceed:(SEL)httpRequestSucceed
             httpRequestFailed:(SEL)httpRequestFailed;

//TA的提问
- (void)requestOtherQuestionsList:(NSString *)anUid
                             page:(NSString *)aPage
               httpRequestSucceed:(SEL)httpRequestSucceed
                httpRequestFailed:(SEL)httpRequestFailed;

//我的赞同
- (void)requestMyLoverList:(NSString *)aPage
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//TA的赞同
- (void)requestOtherLoverList:(NSString *)anUid
                         page:(NSString *)aPage
           httpRequestSucceed:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed;

//赞同我的
- (void)requestLoverMeList:(NSString *)aPage
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//赞同TA的
- (void)requestLoverOtherList:(NSString *)anUid
                         page:(NSString *)aPage
           httpRequestSucceed:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed;

//我的回答
- (void)requestMyAnswersList:(NSString *)aPage
          httpRequestSucceed:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed;

//TA的回答
- (void)requestOtherAnswersList:(NSString *)anUid
                           page:(NSString *)aPage
             httpRequestSucceed:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed;

//最新提问数量
- (void)requestLasttesdCount:(NSString *)lastId
                        udid:(NSString *)anUdid
          httpRequestSucceed:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed;

//修改头像
- (void)requestUpdateAvatar:(NSData *)aData
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;

//版本检查
- (void)checkVersion:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed;

//收藏列表
- (void)requestStoreList:(NSString *)aPage
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed;

//举报回答
- (void)requestReportAnswer:(NSString *)answerUid
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;

//回答删除
-(void)requestDeleteTheAnswer:(NSString *)answerId
           httpRequestSucceed:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed;

//提问删除
-(void)requestDeleteTheQuestion:(NSString *)questionId
             httpRequestSucceed:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed;

//腾讯微博不带图片分享、同步
- (void)requsetTencent_NoPic:(NSDictionary *)anUid
          httpRequestSucceed:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed;

//腾讯微博带图片分享、同步
- (void)requsetTencent_HavePic:(NSDictionary *)anUid
                          data:(NSData *)picData
            httpRequestSucceed:(SEL)httpRequestSucceed
             httpRequestFailed:(SEL)httpRequestFailed;

//关注/取消关注
- (void)followUser:(NSString *)anUid
httpRequestSucceed:(SEL)httpRequestSucceed
 httpRequestFailed:(SEL)httpRequestFailed;

//关注/粉丝列表
-(void)requestAttentionOrFanList:(NSArray *)anArray
              httpRequestSucceed:(SEL)httpRequestSucceed
               httpRequestFailed:(SEL)httpRequestFailed;

//应用下载网页链接 （微信）
- (void)requestAppDownLoadUrl:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed;

//砸蛋
-(void)requestZaDan:(SEL)httpRequestSucceed
  httpRequestFailed:(SEL)httpRequestFailed;

//删除消息
- (void)deleteMessages:(NSString *)msgIds
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed;

//金蛋记录
- (void)requestEggsRecord:(NSString *)anUid
                     page:(NSString *)aPage
                 pageSize:(NSString *)aPageSize
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//金币商城中兑换商品的列表
- (void)exchangeGoodsList:(NSArray *)anArray
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//金币商城中兑换商品记录
- (void)exchangeRecord:(NSArray *)anArray
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed;

//兑换商品
- (void)exchangeGoods:(NSString *)anUid
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed;

//用户最近使用的收货地址
-(void)recentlyReceiveAddress:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed;

//更改订单地址
- (void)changeOrderAddress:(NSDictionary *)aParameter
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//系统消息
-(void)requestSystemMessageDetail:(NSArray *)anArray
               httpRequestSucceed:(SEL)httpRequestSucceed
                httpRequestFailed:(SEL)httpRequestFailed;

//回复系统消息
- (void)requestReplyAnswerQuestion:(NSDictionary *)aParameter
                httpRequestSucceed:(SEL)httpRequestSucceed
                 httpRequestFailed:(SEL)httpRequestFailed;

//获取最新的金蛋提醒
- (void)requestNewestEggTips:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed;

//兑换商品分享加金币和砸中实物金蛋分享加金币
-(void)requestShareAddCoins:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;

//获取分类信息列表
- (void)requestCategoryInfo:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;

//具体分类列表
- (void)requestCategoryList:(NSString *)aType
                 categoryId:(NSString *)aCategoryId
                        tag:(NSString *)aTag
                       page:(NSString *)aPage
                   pageSize:(NSString *)aPageSize
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;

//试用商品列表
- (void)useGoodsList:(NSArray *)anArray
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed;

//申请试用
- (void)applyFreeUse:(NSString *)anId
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed;

//试用商品详情页
- (void)freeUseDetail:(NSString *)anId
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed;

//试用申请进度
- (void)applyAuditProgress:(NSString *)anId
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//我的适用
- (void)requestMyFreeUse:(NSString *)aType
                    page:(NSString *)aPage
                pageSize:(NSString *)aPageSize
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed;

//品牌商品详情
- (void)brandProductDetail:(NSString *)anId
                      type:(NSString *)aType
                      page:(NSString *)aPage
                  pageSize:(NSString *)aPageSize
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//点评
- (void)requestCommentProduct:(NSDictionary *)aParameter
                    dataArray:(NSArray *)aDataArray
           httpRequestSucceed:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed;

//我的点评
- (void)requestMyComments:(NSString *)aPage
                 pageSize:(NSString *)aPageSize
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//金币商城兑换金币砸蛋
-(void)requestMallZaDan:(NSString *)goodsId
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//品牌商品列表
- (void)requestBrandProduct:(NSString *)brand
                    andCat1:(NSString *)cat1
                    andCat2:(NSString *)cat2
                   andOrder:(NSString *)order
                       page:(NSString *)aPage
                   pageSize:(NSString *)aPageSize
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;

//获取品牌分类
- (void)requestBrandCategory:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed;

//对“产品详情”页面的点评投票
- (void)requestVoteComment:(NSString *)commentId
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//产品详情的点评删除
- (void)requestCommentDelete:(NSString *)commentId
          httpRequestSucceed:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed;

//设置/取消最佳答案
- (void)requestSetBestAnswer:(NSString *)answerId
          httpRequestSucceed:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed;

//邀请金蛋接口
- (void)requestInviteEgg:(NSString *)anUid
             deviceToken:(NSString *)aToken
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed;

//邀请金蛋接口
- (void)requestHitInviteEgg:(NSString *)anUid
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;

//首页列表带二级筛选
- (void)requestHomeList:(NSString *)aType
              subObject:(NSString *)aSubObject
               category:(NSString *)aCategory
                essence:(NSString *)aEssence
                  maxId:(NSString *)aMaxId
                   page:(NSString *)aPage
              aPageSize:(NSString *)aPageSize
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//关注/取消关注圈子
- (void)requestAttentionCircle:(NSString *)aType
                      category:(NSString *)aCategory
            httpRequestSucceed:(SEL)httpRequestSucceed
             httpRequestFailed:(SEL)httpRequestFailed;

//写心情日记
- (void)requestWriteDiary:(NSDictionary *)aParameter
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//问题分享记录
- (void)requestQuestionShareRecord:(NSString *)anUid
                          category:(NSString *)aType
                httpRequestSucceed:(SEL)httpRequestSucceed
                 httpRequestFailed:(SEL)httpRequestFailed;

//签到
- (void)requestCheckin:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed;

//今日金币详情
- (void)requestTodayCoinsDetail:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed;


@end
