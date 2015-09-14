//
//  AnswerDetailViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/24.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "AnswerDetailViewController.h"
#import "UIButton+WebCache.h"
#import "Define.h"

@interface AnswerDetailViewController (){

    UIButton *shareButton;
    NSString *mainTitle;
    NSDictionary *answerDictionary;
    BOOL hasZanIt;
    NSString *answerId;
    UILabel *agreeCountLabel;
}
@property(nonatomic,retain)NSString *answerId;

@end

@implementation AnswerDetailViewController
@synthesize answerId;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
}

-(void)initWithTitle:(NSString *)mainTitles andAnswerDic:(NSDictionary *)answerDic{

    mainTitle = mainTitles;
    answerDictionary = [NSDictionary dictionaryWithDictionary:answerDic];
    [self showHeaderView:mainTitle];
    self.answerId = [NSString stringWithFormat:@"%@",[answerDictionary objectForKey:@"answer_id"]];
    [self createMainView];

}

//主界面
-(void)createMainView{
    
    UIView *grayView = [[UIView alloc] init];
    [grayView setBackgroundColor:COLOR(0xf2, 0xf2, 0xf3)];
    [grayView setFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    [self.view addSubview:grayView];
    [grayView release];
    
    UILabel *questionLabel = [[UILabel alloc] init];
//    [questionLabel setBackgroundColor:COLOR(0xf2, 0xf2, 0xf3)];
    [questionLabel setFont:[UIFont systemFontOfSize:16]];
    questionLabel.numberOfLines = 0;
    
    [questionLabel setFrame:CGRectMake(15, 10, kScreenWidth-30, 30)];
    [questionLabel setTextColor:COLOR(0x7b, 0x83, 0x8e)];
    [grayView addSubview:questionLabel];
    [questionLabel release];
    
    CGSize qSize =[self getStringSizeWith:mainTitle boundingRectWithSize:(CGSizeMake(questionLabel.frame.size.width,0)) font:questionLabel.font];
    CGRect tempFrame = questionLabel.frame;
    tempFrame.size.height= qSize.height;
    questionLabel.frame = tempFrame;
    [grayView setFrame:CGRectMake(0, 64, kScreenWidth, qSize.height+20)];
    [questionLabel setText:mainTitle];

    mainScrollView = [[UIScrollView alloc] init];
    [mainScrollView setFrame:CGRectMake(0, grayView.bottom, kScreenWidth, self.view.frame.size.height-grayView.bottom)];
    [self.view addSubview:mainScrollView];
//    [mainScrollView setBackgroundColor:[UIColor blackColor]];
    [mainScrollView release];
    
    //createUserInfo  用户信息
    if(![self isBlankDictionary:answerDictionary]){
        NSString *avarStr = @"";
        NSString *answerName = @"匿名用户";

        if(![[ConstObject instance] isFromQusetionToAnswer]){
        NSDictionary *userDic = [answerDictionary objectForKey:@"user_info"];
       
            if(![self isBlankDictionary:userDic]){
                avarStr =[NSString stringWithFormat:@"%@%@",avatarUrl,[userDic objectForKey:@"avatar_file"]];
                answerName = [NSString stringWithFormat:@"%@",[userDic objectForKey:@"user_name"]];

            }
        }else{
            
            avarStr =[NSString stringWithFormat:@"%@%@",avatarUrl,[answerDictionary objectForKey:@"avatar_file"]];
            answerName = [NSString stringWithFormat:@"%@",[answerDictionary objectForKey:@"user_name"]];
            

        }
        
        UIButton *avarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [avarButton setFrame:CGRectMake(15, 10, 50, 50)];
        [avarButton setImageWithURL:[NSURL URLWithString:avarStr] placeholderImage:[UIImage imageNamed:@"avarImage"]];
        [avarButton setBackgroundColor:[UIColor clearColor]];
        [avarButton.layer setMasksToBounds:YES];
        avarButton.layer.cornerRadius = 4;
        avarButton.layer.borderColor = [UIColor grayColor].CGColor;
        avarButton.layer.borderWidth = 0.1;
        
        [mainScrollView addSubview:avarButton];
        [avarButton addTarget:self action:@selector(toUserInfoPage:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *userNameLabel = [[UILabel alloc] init];
        [userNameLabel setText:answerName];
        [userNameLabel setTextColor:[UIColor blackColor]];
        [userNameLabel setFont:[UIFont systemFontOfSize:18]];
        [userNameLabel setFrame:CGRectMake(avarButton.right+13, 25, kScreenWidth-80-75, 22)];
        [mainScrollView addSubview:userNameLabel];
        [userNameLabel release];
        
        //赞相关
        UIButton *zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *agree_status = [NSString stringWithFormat:@"%@",[answerDictionary objectForKey:@"agree_status"]];
        if([agree_status isEqualToString:@"0"]){
            
            //没有赞过
            [zanButton setBackgroundImage:[UIImage imageNamed:@"noZan"] forState:UIControlStateNormal];
            hasZanIt = NO;
        }else{
        
            [zanButton setBackgroundImage:[UIImage imageNamed:@"hasZan"] forState:UIControlStateNormal];
            hasZanIt = YES;
        }

        [zanButton addTarget:self action:@selector(tapZan:) forControlEvents:UIControlEventTouchUpInside];
        [zanButton setFrame:CGRectMake(kScreenWidth-13-61, 22, 61,28)];
        [mainScrollView addSubview:zanButton];
        
//        agree_count
        agreeCountLabel = [[UILabel alloc] init];
        [agreeCountLabel setFrame:CGRectMake(30, 7, 25, 14)];
        [agreeCountLabel setFont:kFontArial14];
        [agreeCountLabel setTextAlignment:NSTextAlignmentCenter];
        [agreeCountLabel setTextColor:COLOR(195, 198, 202)];
        [agreeCountLabel adjustsFontSizeToFitWidth];
        [agreeCountLabel setText:[NSString stringWithFormat:@"%@",[answerDictionary objectForKey:@"agree_count"]]];
//        [agreeCountLabel setText:@"999"];
        [zanButton addSubview:agreeCountLabel];
        [zanButton setTitle:[NSString stringWithFormat:@"%@",[answerDictionary objectForKey:@"agree_count"]] forState:UIControlStateNormal];
        [zanButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [agreeCountLabel release];
        
        
        UIImageView *bottomLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,75 , kScreenWidth-15, 0.5)];
        bottomLineImageView.backgroundColor = COLOR1(227, 227, 227);
        //        bottomLineImageView.image = [UIImage imageNamed:@"dixian"];
        [mainScrollView addSubview:bottomLineImageView];
        [bottomLineImageView release];
        
        //----------回答内容UI----------
        UIImageView *answerImageView = [[UIImageView alloc] init];
        [answerImageView setImage:[UIImage imageNamed:@"answerImage"]];
        [answerImageView setFrame:CGRectMake(15, 15+bottomLineImageView.bottom, 13, 13)];
        [mainScrollView addSubview:answerImageView];
        [answerImageView release];
        
        //回答的内容
        NSString *answerContentStr = [NSString stringWithFormat:@"%@",[answerDictionary objectForKey:@"answer_content"]];
        answerContentStr = [self trimString:answerContentStr];
        UILabel *answerLabel = [[UILabel alloc] init];
        [answerLabel setFrame:CGRectMake(35, 13.5+bottomLineImageView.bottom, kScreenWidth-50, 30)];
        answerLabel.numberOfLines= 0;
        [answerLabel setTextColor:[UIColor blackColor]];
        [answerLabel setFont:[UIFont systemFontOfSize:16]];
        [answerLabel setText:answerContentStr];
        answerLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [mainScrollView addSubview:answerLabel];
        [answerLabel release];
        
        CGSize tempSize  = [self getStringSizeWith:answerContentStr boundingRectWithSize:(CGSizeMake(answerLabel.frame.size.width,0)) font:answerLabel.font];
        
        CGRect answerFrame = answerLabel.frame;
        answerFrame.size.height = tempSize.height;
        answerLabel.frame = answerFrame;
        
        NSString *add_time = [NSString stringWithFormat:@"%@",[answerDictionary objectForKey:@"add_time"]];
        NSString *createTime = [super transformTime:add_time];
        
        NSString *finalCreateTimeStr = [NSString stringWithFormat:@"创建于 %@",createTime];
        UILabel *createTimeLabel = [[UILabel alloc] init];
        [createTimeLabel setFrame:CGRectMake(kScreenWidth-127, answerLabel.bottom+25, 114, 13)];
        [createTimeLabel setText:finalCreateTimeStr];
        [createTimeLabel setTextAlignment:NSTextAlignmentRight];
        [createTimeLabel setFont:[UIFont systemFontOfSize:12]];
        [createTimeLabel setTextColor:COLOR(196, 199, 203)];
        [mainScrollView addSubview:createTimeLabel];
        [createTimeLabel release];
        
        [mainScrollView setContentSize:CGSizeMake(kScreenWidth, 275+tempSize.height)];
    }
}

-(void)toUserInfoPage:(id)sender{

    
}

//点击赞按钮
-(void)tapZan:(id)sender{

    if([[super userToken] length]>10){
    //点赞
    UIButton *tempButton =(UIButton*)sender;
    NSString *zanNum = tempButton.titleLabel.text;
    int tempZanNum = [zanNum intValue];
    
    if(!hasZanIt){
        [tempButton setBackgroundImage:[UIImage imageNamed:@"hasZan"] forState:UIControlStateNormal];
        tempZanNum++;
        [tempButton setTitle:[NSString stringWithFormat:@"%d",tempZanNum] forState:UIControlStateNormal];
        hasZanIt = YES;
    }else{
    
         [tempButton setBackgroundImage:[UIImage imageNamed:@"noZan"] forState:UIControlStateNormal];
         tempZanNum--;
        [tempButton setTitle:[NSString stringWithFormat:@"%d",tempZanNum] forState:UIControlStateNormal];
        hasZanIt = NO;
    }
    [agreeCountLabel setText:[NSString stringWithFormat:@"%d",tempZanNum]];
    NSString *tokenStr = [super userToken];
    [commonModel requestVoteTheAnswer:answerId andToken:tokenStr httpRequestSucceed:@selector(requestVoteSuccess:) httpRequestFailed:@selector(requestVoteFailed:)];
    }else{
    
        //未登录
        [self deleteToken];
        [self toLoginPage];
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

-(void)shareQuestion:(id)sender{

    
}

//登录
-(void)toLoginPage{
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    //    [self.navigationController pushViewController:loginViewController animated:YES];
    [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
    [loginViewController release];
}

-(void)returnBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)requestVoteSuccess:(ASIHTTPRequest *)request{

    
    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
    NSDictionary *resultDic = [nsDic objectForKey:@"result"];
    NSDictionary *businessDataDic = [resultDic objectForKey:@"businessData"];
    if(![self isBlankDictionary:businessDataDic]){
    
        //投票数
        NSString *answer_vote = [businessDataDic objectForKey:@"answer_vote"];
        if(![self isBlankString:answer_vote]){
        
            [agreeCountLabel setText:[NSString stringWithFormat:@"%@",answer_vote]];
        }
    }
}

-(void)requestVoteFailed:(ASIHTTPRequest *)request{
    
    
    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
  
}

//计算字符串size
- (CGSize)getStringSizeWith:(NSString*)_mystr boundingRectWithSize:(CGSize)_boundSize font:(UIFont*)font{
    
    if ([_mystr isEqual: [NSNull null]] || _mystr == nil || [_mystr isEqualToString: @""] || [_mystr isEqualToString: @"<null>"]){
        return CGSizeMake(_boundSize.width, 20);
    }
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize size = [_mystr  boundingRectWithSize:_boundSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size;
    
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
