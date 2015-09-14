//
//  QuestionViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/25.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "QuestionViewController.h"
#import "MoreCell.h"
#import "QuestionAnsDetailTableViewCell.h"
#import "InviteViewController.h"
#import "AddAnswerViewController.h"
#import "AnswerDetailViewController.h"
#import "CareViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface QuestionViewController (){

    UIButton *shareButton;
    NSString *mainTitle;
    NSDictionary *answerDictionary;
    UITableView *questionTableView;
    int showMore;
    BOOL moreAction;
}

@end

@implementation QuestionViewController
@synthesize tagArray;
@synthesize answerListArray;
@synthesize backgroundViews;
@synthesize shareView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tagArray = [NSMutableArray arrayWithCapacity:1];
    self.answerListArray = [NSMutableArray arrayWithCapacity:1];
    page = 1;
    showMore = 20;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadAnswerListData) name:@"loadAnswerListData" object:nil];
}

-(void)initWithTitle:(NSString *)mainTitles andAnswerDic:(NSDictionary *)answerDic{
    
    mainTitle = mainTitles;
    answerDictionary = [NSDictionary dictionaryWithDictionary:answerDic];
    [self showHeaderView:mainTitle];
    
    [self createTopView];
    
    [self loadAnswerListData];
    
}

-(void)createTopView{
    
    [self createTipMarkView];
    
//    questionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topicLabel.bottom+15+14+40*kScreenWidth/320, kScreenWidth, kScreenHeight-64-44+20)];
    questionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64+20)];
    questionTableView.delegate = self;
    questionTableView.dataSource = self;
    questionTableView.tag = 1111111;
    questionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:questionTableView];
    [questionTableView release];
    
}

-(void)gotoCertainPage:(id)sender{

    UIButton *tempButton = (UIButton *)sender;
    if(tempButton.tag==0){
    
        //邀请回答
        
    }else if(tempButton.tag==1){
        //添加回答
        AddAnswerViewController *addAnswerViewController = [[AddAnswerViewController alloc] init];
        [self presentViewController:addAnswerViewController animated:YES completion:nil];
        [addAnswerViewController release];
        
    }else{
        //关注问题
//        if(i==2)
//        [tempButton setBackgroundImage:[UIImage imageNamed:tempStr] forState:UIControlStateHighlighted];
        if([[[ConstObject instance] questionFocus] isEqualToString:@"0"]){
            //没有关注变关注
            [tempButton setBackgroundImage:[UIImage imageNamed:@"hasFocus"] forState:UIControlStateNormal];
            [[ConstObject instance] setQuestionFocus:@"1"];
        }
        else{
            [tempButton setBackgroundImage:[UIImage imageNamed:@"button2"] forState:UIControlStateNormal];
             [[ConstObject instance] setQuestionFocus:@"0"];
        }
        
        NSString *userToken = [super userToken];
        if([userToken length]>10){
            NSString *questionID = [NSString stringWithFormat:@"%@",[[ConstObject instance] questionID]];
            [commonModel requestCareTheQuestion:questionID andToken:userToken httpRequestSucceed:@selector(requestCareTheQuestionSuccess:) httpRequestFailed:@selector(requestCareTheQuestionFailed:)];
        }else{
            
            //未登录
            [self deleteToken];
            [self toLoginPage];
        }
    }
}

//登录
-(void)toLoginPage{
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    //    [self.navigationController pushViewController:loginViewController animated:YES];
    [self presentViewController:loginViewController animated:YES completion:nil];
    [loginViewController release];
}

//关注(或取消)成功
-(void)requestCareTheQuestionSuccess:(ASIHTTPRequest *)request{

    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
    NSDictionary *resultDic = [nsDic objectForKey:@"result"];
    if([[resultDic objectForKey:@"status"] isEqualToString:@"00"]){
        
        //未登录
        [self deleteToken];
        [self toLoginPage];
        return;
    }

//    NSDictionary *messageDic = [resultDic objectForKey:@"error"];
//    NSString *messageStr = [NSString stringWithFormat:@"%@",[messageDic objectForKey:@"errorMessage"]];
//    [super showMBProgressHUD:messageStr];
    
}

-(void)requestCareTheQuestionFailed:(ASIHTTPRequest *)request{
    
    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
}

//创建标签view
-(void)createTipMarkView{

    
}

-(void)loadAnswerListData{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self fetchAnswerList];
    });
}

-(void)fetchAnswerList{
    
    [super showMBProgressHUD:@"加载中..."];
    NSString *questionId = [[ConstObject instance] questionID];
    NSString *userToken = [super userToken];
    
    [commonModel requestQuestionInfo:questionId andPage:page andToken:userToken httpRequestSucceed:@selector(requestInfoSuccess:) httpRequestFailed:@selector(requestInfoFailed:)];
}


-(void)requestInfoSuccess:(ASIHTTPRequest *)request{
    
    [super hideMBProgressHUD];
    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
    NSDictionary *resultDic = [nsDic objectForKey:@"result"];
    NSDictionary *businessDataDic = [resultDic objectForKey:@"businessData"];
//    if(![self isBlankDictionary:businessDataDic]){
//        
//        self.answerListArray = [businessDataDic objectForKey:@"answer_list"];
//        
//    }
    if(page==1){
        if([self.answerListArray count]>0){
            
            [self.answerListArray removeAllObjects];
            self.answerListArray = [NSMutableArray arrayWithCapacity:1];
        }
    }
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[businessDataDic objectForKey:@"answers"]];
    NSString *questionFocus = [NSString stringWithFormat:@"%@",[businessDataDic objectForKey:@"question_focus"]];
    [[ConstObject instance]setQuestionFocus:questionFocus];
    [self.answerListArray addObjectsFromArray:tempArray];
    [questionTableView reloadData];
    [moreCell stopAction];
}

-(void)requestInfoFailed:(ASIHTTPRequest *)request{
    
    [super hideMBProgressHUD];
    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
}


#pragma mark - UITableDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   
//    if([self.tagArray count]>0){
//        if(section==0)
//            return 1;
//        else if (section==1)
//            return 2;
//        else
//            return [answerListArray count]+1;
//    }else{
//    
//        if(section==0)
//            return 2;
//        else'
    if(section==0)
        return 2;
    else{
    if([answerListArray count]==0)
        return 0;
    
    if([answerListArray count]<=20)
        showMore=[answerListArray count];
        return [answerListArray count]+1;
    }
//    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //标签数组是否为空
//    if([self.tagArray count]>0){
//        return 3;
//    }
//    return 2;
    return 2;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier1 = @"MoreCell1";
    UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    
    if(indexPath.section==0){
        //放标签
//        static NSString *cellIdentifier1 = @"MoreCell1";
//        UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
        }
            cell.selectionStyle = UITableViewCellAccessoryNone;
        for(UIView *view in cell.subviews)
        {
            [view removeFromSuperview];
        }

        if(indexPath.row==0){
        
        }
        if(indexPath.row==1){
                NSString *topicText = [[ConstObject instance] questionText];
                NSLog(@"===%@",topicText);
                UILabel *topicLabel = [[UILabel alloc] init];
                [topicLabel setFont:[UIFont systemFontOfSize:16]];
                [topicLabel setTextColor:[UIColor blackColor]];
                [topicLabel setText:topicText];
                topicLabel.numberOfLines = 0;
                [topicLabel setFrame:CGRectMake(14, 15, kScreenWidth-28, 20)];
                [cell addSubview:topicLabel];
                
                CGSize tempSize = [self getStringSizeWith:topicText boundingRectWithSize:(CGSizeMake(kScreenWidth-28,0)) font:topicLabel.font];
                float tempHeight = tempSize.height;
                NSLog(@"%f",tempHeight);
                [topicLabel setFrame:CGRectMake(14, 15, kScreenWidth-28, tempHeight+5)];
                [topicLabel setBackgroundColor:[UIColor clearColor]];
                
                for(int i=0; i<3; i++){
                    
                    UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    tempButton.tag = i;
                    [tempButton addTarget:self action:@selector(gotoCertainPage:) forControlEvents:UIControlEventTouchUpInside];
                    [tempButton setFrame:CGRectMake(i*kScreenWidth/3, topicLabel.bottom+15, kScreenWidth/3, 40*kScreenWidth/320)];
                    NSString *tempStr = [NSString stringWithFormat:@"button%d",i];
                    [tempButton setBackgroundImage:[UIImage imageNamed:tempStr] forState:UIControlStateNormal];
                    if(i==2){
                    
                        if([[[ConstObject instance] questionFocus] isEqualToString:@"1"])
                            [tempButton setBackgroundImage:[UIImage imageNamed:@"hasFocus"] forState:UIControlStateNormal];
                    }
                   
                    [cell addSubview:tempButton];
                }
                [topicLabel release];
//                [lineImageView release];
                }
            }
            else{
                static NSString *cellIdentifier = @"MoreCell";
                if(indexPath.row==showMore){
                    moreCell = (MoreCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!moreCell) {
                        
                        moreCell = [[MoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                        moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
                        moreAction ? [moreCell setTips:@"上拉获取更多"] :[moreCell setTips:@"已加载全部"];
                    }
                    return moreCell;
                }
                
                static NSString* cellID = @"QuestionAnsDetailTableViewCell";
                QuestionAnsDetailTableViewCell* cell = (QuestionAnsDetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
                if (!cell) {
                    cell = [[[QuestionAnsDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
                }
                cell.selectionStyle = UITableViewCellAccessoryNone;
                
                if([self.answerListArray count]>indexPath.row){
                    
                NSDictionary *mainDic = [NSDictionary dictionaryWithDictionary:[self.answerListArray objectAtIndex:indexPath.row]];
                if(![self isBlankDictionary:mainDic]){
 
                NSString *avatarImage =[NSString stringWithFormat:@"%@%@",avatarUrl,[mainDic objectForKey:@"avatar_file"]];
                
                NSString *user_name = [NSString stringWithFormat:@"%@",[mainDic objectForKey:@"user_name"]];
                NSString *zanNum = [NSString stringWithFormat:@"%@",[mainDic objectForKey:@"agree_count"]];
                NSString *answer_content = [NSString stringWithFormat:@"%@",[mainDic objectForKey:@"answer_content"]];
            
                [cell.avarButton setImageWithURL:[NSURL URLWithString:avatarImage] placeholderImage:[UIImage imageNamed:@"avarImage"]];
                [cell.zanNumberLabel setText:zanNum];
                [cell.answerLabel setText:answer_content];
                [cell.nameLabel setText:user_name];
            
                CGSize tempSize = [self getStringSizeWith:answer_content boundingRectWithSize:(CGSizeMake(cell.answerLabel.width,0)) font:cell.answerLabel.font];
                CGRect tempFrame2 = cell.answerLabel.frame;
            
                tempFrame2.size.height = tempSize.height>85?85:tempSize.height;
                cell.answerLabel.frame = tempFrame2;
                    
                    CGRect ttFrame =  cell.lineImage.frame;
                    ttFrame.origin.y = cell.answerLabel.bottom+15;
                    cell.lineImage.frame = ttFrame;
            }
                    return cell;
        }
        
    }
    

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section ==0){
    
        if(indexPath.row==0){
            
            if([self.tagArray count]==0)
                return 0;
            return 36;
        }else{
            
            NSString *topicText = [[ConstObject instance] questionText];
            CGSize tempSize = [self getStringSizeWith:topicText boundingRectWithSize:(CGSizeMake(kScreenWidth-28,0)) font:[UIFont systemFontOfSize:16]];
            float tempHeight = tempSize.height;
            return tempHeight+35+40*kScreenWidth/320;
        }

    }else{
        if([self.answerListArray count]>indexPath.row){
            NSDictionary *mainDic = [NSDictionary dictionaryWithDictionary:[self.answerListArray objectAtIndex:indexPath.row]];
            NSString *answer_content = [NSString stringWithFormat:@"%@",[mainDic objectForKey:@"answer_content"]];
            
            if(indexPath.row==showMore)return 44;
            else{
                
                CGSize tempSize = [self getStringSizeWith:answer_content boundingRectWithSize:(CGSizeMake(kScreenWidth-65,0)) font:kFontArial14];
                float tempHeight = tempSize.height>85?85:tempSize.height;
                return 42+15+tempHeight;
                
            }
        }else
            return 44;

    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section==1){
    
        if(!(indexPath.row == [self.answerListArray count])){
        NSDictionary *mainDic = [NSDictionary dictionaryWithDictionary:[self.answerListArray objectAtIndex:indexPath.row]];
        if(![self isBlankDictionary:mainDic]){
            
            NSString *titleStr = [NSString stringWithFormat:@"%@",[[ConstObject instance] questionText]];
            AnswerDetailViewController *answerDetailViewController = [[AnswerDetailViewController alloc] init];
            [[ConstObject instance] setIsFromQusetionToAnswer:YES];
            [answerDetailViewController initWithTitle:titleStr andAnswerDic:mainDic];
            [self.navigationController pushViewController:answerDetailViewController animated:YES];
            }
        }
        
    }

}


-(void)showHeaderView:(NSString *)tempStr{
    
    [self createAnswerNavWithTitle:tempStr createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 1)
         {
             //右侧消息按钮
             shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
             [shareButton setFrame:CGRectMake(self.navView.width - 40, self.navView.height - 35, 25, 25)];
             [shareButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
             [shareButton setBackgroundImage:[UIImage imageNamed:@"shareLighted"] forState:UIControlStateHighlighted];
             //             [shareButton setTitle:@"分享" forState:UIControlStateNormal];
             [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             [shareButton addTarget:self action:@selector(shareQuestion:) forControlEvents:UIControlEventTouchUpInside];
             shareButton.showsTouchWhenHighlighted = YES;
             
             return shareButton;
         }else  if (nIndex == 2)
         {
             //左侧提问按钮
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             [btn setFrame:CGRectMake(10, self.navView.height - 35, 25, 25)];
             [btn setBackgroundImage:[UIImage imageNamed:@"returnPic"] forState:UIControlStateNormal];
             [btn setBackgroundImage:[UIImage imageNamed:@"returnPicLighted"] forState:UIControlStateHighlighted];
             [btn addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
             btn.showsTouchWhenHighlighted = YES;
             [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             
             return btn;
         }else  if (nIndex == 3)
         {
             //搜索按钮
             //             UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
             //             [searchButton setFrame:CGRectMake((kScreenWidth-188)/2, self.navView.height - 38, 188, 28)];
             //             [searchButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
             //             //             [searchButton setBackgroundImage:[UIImage imageNamed:@"askQuestionButtonLighted"] forState:UIControlStateHighlighted];
             //             [searchButton addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
             //             searchButton.showsTouchWhenHighlighted = YES;
             //             [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             //
             //             return searchButton;
         }
         
         return nil;
     }];
}

-(void)returnBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareQuestion:(id)sender
{
    
    UIView *backgroundview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+20)];
    backgroundview.backgroundColor =[UIColor colorWithRed:0./255. green:0./255. blue:0./255. alpha:0.5];
    
    UITapGestureRecognizer *fingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissShareView)];
    [backgroundview addGestureRecognizer: fingerTap];
    [fingerTap release];
    
    [self.view addSubview:backgroundview];
    self.backgroundViews = backgroundview;
    [backgroundview release];
    
     UIView *shareview = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenBounds.size.height, kScreenBounds.size.width, 225)];
    
//    UIView *shareview = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenBounds.size.height-225+20, kScreenBounds.size.width, 225)];
    shareview.backgroundColor =COLOR(0xf1, 0xf1, 0xf1);
    
    //微信button
    UIButton *weixinButton = [[UIButton alloc] initWithFrame:CGRectMake(35*kScreenWidth/320, 50, 50, 50)];
    UIImage *weixinImage = [UIImage imageNamed:@"wechat"];
    [weixinButton setBackgroundImage: weixinImage forState:UIControlStateNormal ];
    [weixinButton addTarget:self action:@selector(ShowShareView:)forControlEvents:UIControlEventTouchUpInside];
    weixinButton.tag = 0;
    [shareview addSubview:weixinButton];
    [weixinButton release];
    [self.view addSubview:shareview];
    
    UILabel *labelWeixin;
    if(iPhone6)
        labelWeixin = [[UILabel alloc] initWithFrame:CGRectMake(45*kScreenWidth/320-1, weixinButton.bottom+7, 33, 15)];
    else if (iPhone6p)
        labelWeixin = [[UILabel alloc] initWithFrame:CGRectMake(45*kScreenWidth/320-2, weixinButton.bottom+7, 33, 15)];
    else
        labelWeixin= [[UILabel alloc] initWithFrame:CGRectMake(45*kScreenWidth/320, weixinButton.bottom+7, 33, 15)];
    labelWeixin.textAlignment = NSTextAlignmentCenter;
    labelWeixin.backgroundColor = [UIColor clearColor];
    labelWeixin.textColor = [UIColor colorWithRed:48./255. green:48./255. blue:48./255. alpha:1];
    labelWeixin.font = [UIFont systemFontOfSize:13];
    labelWeixin.text = @"微信";
    [shareview addSubview:labelWeixin];
    [labelWeixin release];
    
    UIButton *friendsButton;
    friendsButton = [[UIButton alloc] initWithFrame:CGRectMake(weixinButton.right+50*kScreenWidth/320+kScreenWidth/320, 50, 50, 50)];
    
    UIImage *friendsButtonImage = [UIImage imageNamed:@"friendsShare"];
    [friendsButton setBackgroundImage: friendsButtonImage forState:UIControlStateNormal ];
    [friendsButton addTarget:self action:@selector(ShowShareView:)forControlEvents:UIControlEventTouchUpInside];
    friendsButton.tag = 3;
    [shareview addSubview:friendsButton];
    [friendsButton release];
    
    UILabel *friendsLabel;
    if(iPhone6)
        friendsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140*kScreenWidth/320-2-10, weixinButton.bottom+7, 48, 15)];
    else if (iPhone6p)
        friendsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140*kScreenWidth/320-2-16, weixinButton.bottom+7, 48, 15)];
    else
        friendsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140*kScreenWidth/320-2, weixinButton.bottom+7, 48, 15)];
    
    friendsLabel.textAlignment = NSTextAlignmentCenter;
    friendsLabel.backgroundColor = [UIColor clearColor];
    friendsLabel.textColor = [UIColor colorWithRed:48./255. green:48./255. blue:48./255. alpha:1];
    friendsLabel.font = [UIFont systemFontOfSize:13];
    friendsLabel.text = @"朋友圈";
    [shareview addSubview:friendsLabel];
    [friendsLabel release];
    
    UIButton *sinaButton;
    sinaButton  = [[UIButton alloc] initWithFrame:CGRectMake(friendsButton.right+50*kScreenWidth/320+kScreenWidth/320, 50, 50, 50)];
    UIImage *sinaButtonImage = [UIImage imageNamed:@"sinaShare"];
    [sinaButton setBackgroundImage: sinaButtonImage forState:UIControlStateNormal ];
    [sinaButton addTarget:self action:@selector(handleSinaWeibo)forControlEvents:UIControlEventTouchUpInside];
    sinaButton.tag = 2;
    [shareview addSubview:sinaButton];
    [sinaButton release];
    
    UILabel *sinaLabel;
    if(iPhone6)
        sinaLabel = [[UILabel alloc] initWithFrame:CGRectMake(230*kScreenWidth/320-9, weixinButton.bottom+6, 58, 15)];
    else if (iPhone6p)
        sinaLabel = [[UILabel alloc] initWithFrame:CGRectMake(230*kScreenWidth/320-20, weixinButton.bottom+7, 58, 15)];
    else
        sinaLabel = [[UILabel alloc] initWithFrame:CGRectMake(230*kScreenWidth/320+3, weixinButton.bottom+7, 58, 15)];
    sinaLabel.textAlignment = NSTextAlignmentCenter;
    sinaLabel.backgroundColor = [UIColor clearColor];
    sinaLabel.textColor = [UIColor colorWithRed:48./255. green:48./255. blue:48./255. alpha:1];
    sinaLabel.font = [UIFont systemFontOfSize:13];
    sinaLabel.text = @"新浪微博";
    [shareview addSubview:sinaLabel];
    [sinaLabel release];
    self.shareView = shareview;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(kScreenWidth/2-16, shareview.frame.size.height-50, 32, 32);
    [backButton addTarget:self action:@selector(dismissShareView) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundColor:[UIColor clearColor]];
    [backButton setBackgroundImage:[UIImage imageNamed:@"shareCancle"] forState:UIControlStateNormal];
    [shareview addSubview:backButton];
    
    [UIView animateWithDuration:0.2 animations:^{
        shareview.frame = CGRectMake(0, kScreenHeight - 225+20 - 5, kScreenWidth, 225);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^{
            shareview.frame = CGRectMake(0,kScreenHeight - 225+20,kScreenWidth, 225);
        } completion:^(BOOL finished) {
            
        }];
    }];

    
}

- (void)ShowShareView:(UIButton *)sender {
    ShareType type = 0;
    switch (sender.tag) {
        case 0:
            type = ShareTypeWeixiSession;
            break;
        case 1:
            type = ShareTypeQQSpace;
            break;
        case 2:
            type = ShareTypeSinaWeibo;
            break;
        case 3://朋友圈
            type = ShareTypeWeixiTimeline;
            break;
        default:
            break;
    }
    
    //1.定制分享的内容
    //    NSString *tempStr = [urlString substringFromIndex:25];
    //    NSString *shareString = [NSString stringWithFormat:@"http://app.xjlastmile.com/js/share.shtml?%@",tempStr];
    //    NSString *tempString = [NSString stringWithFormat:@"%@?",shareString];
    NSString *titleString = [[ConstObject instance] questionText];
    NSString *summaryStr =@"";
    if([self.answerListArray count]>0){
    
        NSDictionary *tempDic = [answerListArray objectAtIndex:0];
        NSString *contentStr = [tempDic objectForKey:@"answer_content"];
        summaryStr = contentStr;
    }
//        summaryStr = [answerListArray objectAtIndex:0];
    NSString *shareString = [NSString stringWithFormat:@"%@?",@"http://www.shunshunliuxue.com"];
    //    NSString *titleStr = [NSString stringWithFormat:@"%@%@",titleString,tempString];
    //    summaryStr = @"测试 摘要 测试 摘要测试 摘要测试 摘要测试 摘要测试 摘要测试 摘要";
    if(!([summaryStr length]>0))
        summaryStr = titleString;
    //    NSString* path = [[NSBundle mainBundle]pathForResource:@"icon" ofType:@"png"];
    id<ISSContent> publishContent = [ShareSDK content:summaryStr defaultContent:nil image:[ShareSDK imageWithUrl:nil] title:titleString url:shareString description:@"" mediaType:SSPublishContentMediaTypeNews];
    //2.分享
    [ShareSDK showShareViewWithType:type container:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        //如果分享成功
        if (state == SSResponseStateSuccess) {
            NSLog(@"分享成功");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"分享成功" message:@"分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            // UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            //[self presentViewController:alert animated:YES completion:nil];
            [self performSelector:@selector(dismissShareView) withObject:alert afterDelay:1.5];
            [alert show];
            
        }else if (state == SSResponseStateFail) {
            NSLog(@"分享失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
            //            NSString *failMetion = [NSString stringWithFormat:@"分享失败!%@",[error errorDescription]];
            //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"最后一公里" message:failMetion delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self performSelector:@selector(dismissShareView) withObject:nil afterDelay:1.5];
            
            //            [alert show];
        }else if (state == SSResponseStateCancel){
            NSLog(@"分享取消");
            [self performSelector:@selector(dismissShareView) withObject:nil afterDelay:1.5];
            
            //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:@"进入了分享取消状态" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //            [alert show];
        }
    }];
}

-(void)handleSinaWeibo{

    
}

-(void)performDismiss:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
}


- (void)dismissShareView
{
    
    CGFloat screenHeight=kScreenBounds.size.height;
    [UIView animateWithDuration:0.25 animations:^
     {
         self.shareView.center = CGPointMake(kScreenBounds.size.width/2, screenHeight);
         self.backgroundViews.backgroundColor = [UIColor clearColor];
     }
                     completion:^(BOOL finished)
     {
         
         [self.shareView removeFromSuperview];
         self.shareView = nil;
         
         [self.backgroundViews removeFromSuperview];
         self.backgroundViews = nil;
         
     }];
    
}


-(void)dealloc{

     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loadAnswerListData" object:nil];
    [super dealloc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
