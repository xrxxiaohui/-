//
//  CommonModel.m
//  ChuanDaZhi
//
//  Created by hers on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommonModel.h"
#import "StringUtil.h"
#import "JSON.h"
#import "StringUtil.h"

@implementation CommonModel

-(id)initWithTarget:(id)aDelegate
{
    if ( self = [super initWithDelegate:aDelegate]){
        
    }
    return self;
}

//注册
- (void)requestRegister:(NSDictionary *)aParameter
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed{

    NSString *urlString = [NSString stringWithFormat:kRegister,kHeader];
    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//登陆
- (void)requestLogin:(NSDictionary *)aParameter
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed{

    NSString *urlString = [NSString stringWithFormat:kLogin,kHeader];
    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//发送验证码
- (void)requestYanZhengMa:(NSDictionary *)aParameter
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:kYanZhengMa,kHeader];
    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//获取category data
- (void)requestCategory:(NSString *)categoryUrl
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed{

    NSString *urlString = [NSString stringWithFormat:kCategoryUrl,kHeader];
    //    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//获取问题列表
- (void)requestQuestionSortType:(NSString *)sortType
                    andCategory:(NSString *)category
                        andPage:(int)page
                       andToken:userToken
             httpRequestSucceed:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed{
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    NSString *urlString = [NSString stringWithFormat:kQuestionUrl,kHeader,sortType,category,pageStr,userToken];
    //    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//对回答点赞和取消点赞
-(void)requestVoteTheAnswer:(NSString *)answerID
                   andToken:(NSString *)token
           httpRequestSucceed:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:kVoteTheAnswer,kHeader,answerID,token];
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//获取问题info列表
- (void)requestQuestionInfo:(NSString *)questionId
                    andPage:(int)page
                   andToken:userToken
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed{

    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    NSString *urlString = [NSString stringWithFormat:kQuestionInfo,kHeader,questionId,pageStr,userToken];
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//关注问题kCareQuestion
-(void)requestCareTheQuestion:(NSString *)questionID
                     andToken:(NSString *)token
           httpRequestSucceed:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed{

    NSString *urlString = [NSString stringWithFormat:kCareQuestion,kHeader,questionID,token];
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//提交回答
- (void)requestAnswerInfo:(NSDictionary *)aParameter
                     httpRequestSucceed:(SEL)httpRequestSucceed
                     httpRequestFailed:(SEL)httpRequestFailed{

    NSString *urlString = [NSString stringWithFormat:kSaveAnswer,kHeader];
    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];

}

//编辑更新回答
- (void)requestUpdateAnswerInfo:(NSDictionary *)aParameter
             httpRequestSucceed:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed{

    NSString *urlString = [NSString stringWithFormat:kSaveAnswer,kHeader];
    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//获取话题数据
//hot_topic
- (void)requestHotTopicInfo:(NSString *)urlString
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed{

    NSString *urlStrings = [NSString stringWithFormat:kHotTopic,kHeader];
    [super get:urlStrings  httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//发布问题
- (void)requestFaBuQuestion:(NSDictionary *)aParameter
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed{    
    
    NSString *urlStrings = [NSString stringWithFormat:kFaBuQuestion,kHeader];
    [super post:urlStrings params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//我关注的学友 get_user_friends
- (void)requestMyCareFriend:(NSDictionary *)aParameter
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:kFocusFriendList,kHeader];
    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//我关注的问题 focus_question_list
- (void)requestMyCareQuestion:(NSDictionary *)aParameter
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:kFocusQuestionList,kHeader];
    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//kFocusUserQuestion
- (void)requestUserQuestion:(NSDictionary *)aParameter
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed{

    NSString *urlString = [NSString stringWithFormat:kFocusUserQuestion,kHeader];
    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//kFocusUserQuestion
- (void)requestUserAnswer:(NSDictionary *)aParameter
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed{

    NSString *urlString = [NSString stringWithFormat:kFocusUserAnswer,kHeader];
    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}
//- (void)requestMyCareQuestion:(int)page
//                 andUserToken:(NSString *)userToken
//           httpRequestSucceed:(SEL)httpRequestSucceed
//            httpRequestFailed:(SEL)httpRequestFailed{
//
//    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
//    NSString *urlString = [NSString stringWithFormat:kFocusQuestionList,kHeader,pageStr,userToken];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}

//我关注的话题 focus_topics_list
- (void)requestMyCareTopic:(int)page
              andUserToken:(NSString *)userToken
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed{

    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    NSString *urlString = [NSString stringWithFormat:kFocusTopic,kHeader,pageStr,userToken];
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}
////启动收集若干用户信息
//- (void)requestGatherUserInformation:(NSDictionary *)aParameter
//                  httpRequestSucceed:(SEL)httpRequestSucceed
//                   httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kGatherUserInformation];
//    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////首页 最新
//-(void)requestNeweest:(NSArray *)anArray
//   httpRequestSucceed:(SEL)httpRequestSucceed
//    httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kHomePageNeweest,[anArray objectAtIndex:0],[anArray objectAtIndex:1],[anArray objectAtIndex:2],[anArray objectAtIndex:3]];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////首页的最热 关注 抢答
//-(void)requestOtherThree:(NSArray *)anArray
//      httpRequestSucceed:(SEL)httpRequestSucceed
//       httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kHomePageOtherThree,[anArray objectAtIndex:0],[anArray objectAtIndex:1],[anArray objectAtIndex:2],[anArray objectAtIndex:3]];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////提问详情
//-(void)requestQuestionDetail:(NSArray *)anArray
//          httpRequestSucceed:(SEL)httpRequestSucceed
//           httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kQuestionDetail,[anArray objectAtIndex:0],[anArray objectAtIndex:1],[anArray objectAtIndex:2],[anArray objectAtIndex:3]];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////系统消息
//-(void)requestSystemMessageDetail:(NSArray *)anArray
//               httpRequestSucceed:(SEL)httpRequestSucceed
//                httpRequestFailed:(SEL)httpRequestFailed{
//    
//    NSString *urlString = [NSString stringWithFormat:kSystemMessage,[anArray objectAtIndex:0],[anArray objectAtIndex:1],[anArray objectAtIndex:2]];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
//
////个人主页
//- (void)requestProfile:(NSString *)anUid
//    httpRequestSucceed:(SEL)httpRequestSucceed
//     httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kProfile,anUid];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////举报回答
//- (void)requestReportAnswer:(NSString *)answerUid
//         httpRequestSucceed:(SEL)httpRequestSucceed
//          httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kReport,answerUid];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////编辑个人资料
//- (void)requestModifyProfile:(NSDictionary *)aParameter
//          httpRequestSucceed:(SEL)httpRequestSucceed
//           httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kModifyProfile];
//    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
//
////回复系统消息
//- (void)requestReplyAnswerQuestion:(NSDictionary *)aParameter
//                httpRequestSucceed:(SEL)httpRequestSucceed
//                 httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kReplyAnswerQuestion];
//    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////提问问题
//- (void)requestAskQuestion:(NSDictionary *)aParameter
//                 dataArray:(NSArray *)aDataArray
//        httpRequestSucceed:(SEL)httpRequestSucceed
//         httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kAskQuestion];
//    if ([[ConstObject instance] isHavePic]) {
//        [super post:urlString dataArray:aDataArray extraParams:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//    }else{
//        [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//    }
//}
//
////回答问题
//- (void)requestAnswerQuestion:(NSDictionary *)aParameter
//                    dataArray:(NSArray *)aDataArray
//           httpRequestSucceed:(SEL)httpRequestSucceed
//            httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kAnswerQuestion];
//    if ([[ConstObject instance] isHavePic]) {
//        [super post:urlString dataArray:aDataArray extraParams:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//    }
//    else{
//        [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//    }
//}
//
//
////财富榜    财富总榜 aType=0  周榜 aType=1
//- (void)requestWealthList:(NSString *)aType
//       httpRequestSucceed:(SEL)httpRequestSucceed
//        httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kTotalWealth,aType];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////收藏
//-(void)requestStoreQuestion:(NSString *)questionID
//         httpRequestSucceed:(SEL)httpRequestSucceed
//          httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kStoreQuestion,questionID];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////kZaDan
//-(void)requestZaDan:(SEL)httpRequestSucceed
//  httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kZaDan];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////金币商城兑换金币砸蛋
//-(void)requestMallZaDan:(NSString *)goodsId
//     httpRequestSucceed:(SEL)httpRequestSucceed
//      httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kMallZaDan,goodsId];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////取消收藏
//-(void)requestCancelStoreQuestion:(NSString *)questionID
//               httpRequestSucceed:(SEL)httpRequestSucceed
//                httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kCancelStoreQuestion,questionID];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////回答删除
//-(void)requestDeleteTheAnswer:(NSString *)answerId
//           httpRequestSucceed:(SEL)httpRequestSucceed
//            httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kDeleteTheAnswer,answerId];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////提问删除
//-(void)requestDeleteTheQuestion:(NSString *)questionId
//             httpRequestSucceed:(SEL)httpRequestSucceed
//              httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kDeleteTheQuestion,questionId];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////对问题点赞
//-(void)requestVoteTheQuestion:(NSString *)aType
//                   questionID:(NSString *)aQuestionID
//           httpRequestSucceed:(SEL)httpRequestSucceed
//            httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kVoteTheQuestion,aType,aQuestionID];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////取消对问题点赞
//-(void)requestCancelVoteTheQuestion:(NSString *)questionID
//                 httpRequestSucceed:(SEL)httpRequestSucceed
//                  httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kCancleVoteTheQuestion,questionID];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////第三方登录
//- (void)requestThirdLogin:(NSString *)aParameter
//       httpRequestSucceed:(SEL)httpRequestSucceed
//        httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kThirdLogin,aParameter];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////第三方互绑
//- (void)requestThirdBind:(NSString *)aParameter
//      httpRequestSucceed:(SEL)httpRequestSucceed
//       httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kThirdBind,aParameter];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////金币详情
//- (void)requestCoinsDetail:(SEL)httpRequestSucceed
//         httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kCoinsDetail];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
////第三方退出
//- (void)requestThirdLoginout:(SEL)httpRequestSucceed
//           httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kThirdLoginout];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////返回个人信息
//- (void)requestReturnUserInfo:(SEL)httpRequestSucceed
//            httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kReturnUserInfo];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////解绑
//- (void)requestRemoveBind:(SEL)httpRequestSucceed
//        httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kRemoveBind];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////返回微博好友列表
//- (void)requestSinaFriendsList:(NSString *)aPage
//                      pageSize:(NSString *)aPageSize
//            httpRequestSucceed:(SEL)httpRequestSucceed
//             httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kSinaFriendsList,aPage,aPageSize];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////邀请新浪微博好友
//- (void)requestSinaFriendsInvited:(NSArray *)anArray
//               httpRequestSucceed:(SEL)httpRequestSucceed
//                httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kSinaFriendsInvite,[anArray objectAtIndex:0],[anArray objectAtIndex:1]];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////邀请QQ或者微信好友
//- (void)requestQQOrWXFriendsInvited:(NSString *)type
//                 httpRequestSucceed:(SEL)httpRequestSucceed
//                  httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kQQOrWeixinFriendsInvite,type];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////个人消息
//- (void)requestMessages:(NSString *)aPage
//               pageSize:(NSString *)aPageSize
//     httpRequestSucceed:(SEL)httpRequestSucceed
//      httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kMessages,aPage,aPageSize];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////我的提问
//- (void)requestMyQuestionsList:(NSString *)aPage
//                      pageSize:(NSString *)aPageSize
//            httpRequestSucceed:(SEL)httpRequestSucceed
//             httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kMyQuestions,aPage,aPageSize];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////TA的提问
//- (void)requestOtherQuestionsList:(NSString *)anUid
//                             page:(NSString *)aPage
//               httpRequestSucceed:(SEL)httpRequestSucceed
//                httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kOtherQuestions,anUid,aPage,kCount];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////我的回答
//- (void)requestMyAnswersList:(NSString *)aPage
//          httpRequestSucceed:(SEL)httpRequestSucceed
//           httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kMyAnswers,aPage,kCount];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////TA的回答
//- (void)requestOtherAnswersList:(NSString *)anUid
//                           page:(NSString *)aPage
//             httpRequestSucceed:(SEL)httpRequestSucceed
//              httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kOtherAnswers,anUid,aPage,kCount];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////我的赞同
//- (void)requestMyLoverList:(NSString *)aPage
//        httpRequestSucceed:(SEL)httpRequestSucceed
//         httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kMyLover,aPage,kCount];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////TA的赞同
//- (void)requestOtherLoverList:(NSString *)anUid
//                         page:(NSString *)aPage
//           httpRequestSucceed:(SEL)httpRequestSucceed
//            httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kOtherLover,anUid,aPage,kCount];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////赞同我的
//- (void)requestLoverMeList:(NSString *)aPage
//        httpRequestSucceed:(SEL)httpRequestSucceed
//         httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kLoverMe,aPage,kCount];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////赞同TA的
//- (void)requestLoverOtherList:(NSString *)anUid
//                         page:(NSString *)aPage
//           httpRequestSucceed:(SEL)httpRequestSucceed
//            httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kOtherLoverMe,anUid,aPage,kCount];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////最新提问数量
//- (void)requestLasttesdCount:(NSString *)lastId
//                        udid:(NSString *)anUdid
//          httpRequestSucceed:(SEL)httpRequestSucceed
//           httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kNewestCount,lastId,anUdid];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//    //隐藏网络加载标志，避免用户疑惑网络老处于请求状态
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//}
//
////修改头像
//- (void)requestUpdateAvatar:(NSData *)aData
//         httpRequestSucceed:(SEL)httpRequestSucceed
//          httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kModifyProfile];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super postAvatar:urlString data:aData httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////版本检查
//- (void)checkVersion:(SEL)httpRequestSucceed
//   httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [kCheckVersion stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////收藏列表
//- (void)requestStoreList:(NSString *)aPage
//      httpRequestSucceed:(SEL)httpRequestSucceed
//       httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kStoreList,aPage,kCount];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////腾讯微博不带图片分享、同步
//- (void)requsetTencent_NoPic:(NSDictionary *)anUid
//          httpRequestSucceed:(SEL)httpRequestSucceed
//           httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kTencentShare_NoPic];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super post:urlString params:anUid httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////腾讯微博带图片分享、同步
//- (void)requsetTencent_HavePic:(NSDictionary *)anUid
//                          data:(NSData *)picData
//            httpRequestSucceed:(SEL)httpRequestSucceed
//             httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kTencentShare_HavePic];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super post:urlString data:picData extraParams:anUid httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
//- (void)followUser:(NSString *)anUid
//httpRequestSucceed:(SEL)httpRequestSucceed
// httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kFollowUser,anUid];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////关注/粉丝列表
//-(void)requestAttentionOrFanList:(NSArray *)anArray
//              httpRequestSucceed:(SEL)httpRequestSucceed
//               httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:KAttentionOrFanList,[anArray objectAtIndex:0],[anArray objectAtIndex:1],[anArray objectAtIndex:2],[anArray objectAtIndex:3]];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////应用下载网页链接 （微信）
//- (void)requestAppDownLoadUrl:(SEL)httpRequestSucceed
//            httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [kAppDownloadURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////删除消息
//- (void)deleteMessages:(NSString *)msgIds
//    httpRequestSucceed:(SEL)httpRequestSucceed
//     httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kDeleteMessage,msgIds];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////金蛋记录
//- (void)requestEggsRecord:(NSString *)anUid
//                     page:(NSString *)aPage
//                 pageSize:(NSString *)aPageSize
//       httpRequestSucceed:(SEL)httpRequestSucceed
//        httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kEggsRecord,anUid,aPage,aPageSize];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
//
////金币商城中兑换商品的列表
//- (void)exchangeGoodsList:(NSArray *)anArray
//       httpRequestSucceed:(SEL)httpRequestSucceed
//        httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kExchageGoodsList,[anArray objectAtIndex:0],[anArray objectAtIndex:1],[anArray objectAtIndex:2]];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////金币商城中兑换商品记录
//- (void)exchangeRecord:(NSArray *)anArray
//    httpRequestSucceed:(SEL)httpRequestSucceed
//     httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kExchangeRecord,[anArray objectAtIndex:0],[anArray objectAtIndex:1]];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////兑换商品
//- (void)exchangeGoods:(NSString *)anUid
//   httpRequestSucceed:(SEL)httpRequestSucceed
//    httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kExchangeGoods,anUid];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////用户最近使用的收货地址
//-(void)recentlyReceiveAddress:(SEL)httpRequestSucceed
//            httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [kRecentlyReceiveAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////更改订单地址
//- (void)changeOrderAddress:(NSDictionary *)aParameter
//        httpRequestSucceed:(SEL)httpRequestSucceed
//         httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kChangeOrderAddress];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////获取最新的金蛋提醒
//- (void)requestNewestEggTips:(SEL)httpRequestSucceed
//           httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [kNewestEggTips stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//    //隐藏网络加载标志，避免用户疑惑网络老处于请求状态
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//}
//
////获取分类信息列表
//- (void)requestCategoryInfo:(SEL)httpRequestSucceed
//          httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [kCategoryInfo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////兑换商品分享加金币和砸中实物金蛋分享加金币
//-(void)requestShareAddCoins:(SEL)httpRequestSucceed
//          httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [kShareAddCoins stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////具体分类列表
//- (void)requestCategoryList:(NSString *)aType
//                 categoryId:(NSString *)aCategoryId
//                        tag:(NSString *)aTag
//                       page:(NSString *)aPage
//                   pageSize:(NSString *)aPageSize
//         httpRequestSucceed:(SEL)httpRequestSucceed
//          httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kCategoryList,aType,aCategoryId,aTag,aPage,aPageSize];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////试用商品列表
//- (void)useGoodsList:(NSArray *)anArray
//  httpRequestSucceed:(SEL)httpRequestSucceed
//   httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kUseGoodsList,[anArray objectAtIndex:0],[anArray objectAtIndex:1]];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////申请试用
//- (void)applyFreeUse:(NSString *)anId
//  httpRequestSucceed:(SEL)httpRequestSucceed
//   httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kApplyFreeUse,anId];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////试用商品详情页
//- (void)freeUseDetail:(NSString *)anId
//   httpRequestSucceed:(SEL)httpRequestSucceed
//    httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kFreeUseDetail,anId];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////试用申请进度
//- (void)applyAuditProgress:(NSString *)anId
//        httpRequestSucceed:(SEL)httpRequestSucceed
//         httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kAuditQuery,anId];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////我的试用
//- (void)requestMyFreeUse:(NSString *)aType
//                    page:(NSString *)aPage
//                pageSize:(NSString *)aPageSize
//      httpRequestSucceed:(SEL)httpRequestSucceed
//       httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kMyFreeUse,aType,aPage,aPageSize];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////品牌商品详情
//- (void)brandProductDetail:(NSString *)anId
//                      type:(NSString *)aType
//                      page:(NSString *)aPage
//                  pageSize:(NSString *)aPageSize
//        httpRequestSucceed:(SEL)httpRequestSucceed
//         httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kBrandProductDetail,anId,aType,aPage,aPageSize];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////品牌商品列表
//- (void)requestBrandProduct:(NSString *)brand
//                    andCat1:(NSString *)cat1
//                    andCat2:(NSString *)cat2
//                   andOrder:(NSString *)order
//                       page:(NSString *)aPage
//                   pageSize:(NSString *)aPageSize
//         httpRequestSucceed:(SEL)httpRequestSucceed
//          httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kProductList,brand,cat1,cat2,order,aPage,aPageSize];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////点评
//- (void)requestCommentProduct:(NSDictionary *)aParameter
//                    dataArray:(NSArray *)aDataArray
//           httpRequestSucceed:(SEL)httpRequestSucceed
//            httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kCommentProduct];
//    if ([[ConstObject instance] isHavePic]) {
//        [super post:urlString dataArray:aDataArray extraParams:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//    }else{
//        [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//    }
//}
////我的点评
//- (void)requestMyComments:(NSString *)aPage
//                 pageSize:(NSString *)aPageSize
//       httpRequestSucceed:(SEL)httpRequestSucceed
//        httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kMyComment,aPage,aPageSize];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////获取品牌分类
//- (void)requestBrandCategory:(SEL)httpRequestSucceed
//           httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kBrandCategory];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////对“产品详情”页面的点评投票
//- (void)requestVoteComment:(NSString *)commentId
//        httpRequestSucceed:(SEL)httpRequestSucceed
//         httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kVote_Comment,commentId];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////产品详情的点评删除
//- (void)requestCommentDelete:(NSString *)commentId
//          httpRequestSucceed:(SEL)httpRequestSucceed
//           httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kComment_Delete,commentId];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////设置/取消最佳答案
//- (void)requestSetBestAnswer:(NSString *)answerId
//          httpRequestSucceed:(SEL)httpRequestSucceed
//           httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kSetBestAnswer,answerId];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////邀请金蛋接口
//- (void)requestInviteEgg:(NSString *)anUid
//             deviceToken:(NSString *)aToken
//      httpRequestSucceed:(SEL)httpRequestSucceed
//       httpRequestFailed:(SEL)httpRequestFailed;{
//    NSString *urlString = [NSString stringWithFormat:kInviteEgg,anUid,aToken];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////邀请金蛋接口
//- (void)requestHitInviteEgg:(NSString *)anUid
//         httpRequestSucceed:(SEL)httpRequestSucceed
//          httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kHitInviteEgg,anUid];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////首页列表带二级筛选
//- (void)requestHomeList:(NSString *)aType
//              subObject:(NSString *)aSubObject
//               category:(NSString *)aCategory
//                essence:(NSString *)aEssence
//                  maxId:(NSString *)aMaxId
//                   page:(NSString *)aPage
//              aPageSize:(NSString *)aPageSize
//     httpRequestSucceed:(SEL)httpRequestSucceed
//      httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kHomeList,aType,aSubObject,aCategory,aEssence,aMaxId,aPage,aPageSize];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////关注/取消关注圈子
//- (void)requestAttentionCircle:(NSString *)aType
//                      category:(NSString *)aCategory
//            httpRequestSucceed:(SEL)httpRequestSucceed
//             httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kAttentionCircle,aType,aCategory];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////写心情日记
//- (void)requestWriteDiary:(NSDictionary *)aParameter
//       httpRequestSucceed:(SEL)httpRequestSucceed
//        httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kWriteDiary];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super post:urlString params:aParameter httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////问题分享记录
//- (void)requestQuestionShareRecord:(NSString *)anUid
//                          category:(NSString *)aType
//                httpRequestSucceed:(SEL)httpRequestSucceed
//                 httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kQuestionShareRecord,anUid,aType];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////签到
//- (void)requestCheckin:(SEL)httpRequestSucceed
//     httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kUserCheckin];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}
//
////今日金币详情
//- (void)requestTodayCoinsDetail:(SEL)httpRequestSucceed
//              httpRequestFailed:(SEL)httpRequestFailed{
//    NSString *urlString = [NSString stringWithFormat:kTodayCoinsDetail];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}

@end
