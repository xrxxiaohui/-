//
//  XueYouViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/9/8.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "XueYouViewController.h"
#import "SelectTeacherTableViewCell.h"
#import "MJRefresh.h"

@interface XueYouViewController ()

@property(nonatomic,retain)NSMutableArray *dataArray;
@end

@implementation XueYouViewController
@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学友";
    showMore = 10;
//    self.view.backgroundColor = [UIColor redColor];
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    
    mainTableView  = [[UITableView alloc] init];
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-44-64)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.tag = 1111111;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTableView];
    [mainTableView release];
}

-(void)viewWillAppear:(BOOL)animated{
    
    if(!isFirstEnter){
        [self setupTableview];
        isFirstEnter = YES;
    }
}
//requestMyCareFriend

-(void)setupTableview{
    //添加下拉的动画图片
    //设置下拉刷新回调
    [mainTableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; ++i) {
        //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd",i]];
        //        [idleImages addObject:image];
        UIImage *image = [UIImage imageNamed:@"icon_listheader_animation_1"];
        [idleImages addObject:image];
    }
    [mainTableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    //设置即将刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    //    UIImage *image1 = [UIImage imageNamed:@"icon_listheader_animation_1"];
    //    [refreshingImages addObject:image1];
    UIImage *image2 = [UIImage imageNamed:@"icon_listheader_animation_2"];
    [refreshingImages addObject:image2];
    [mainTableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    //设置正在刷新是的动画图片
    [mainTableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    
    //马上进入刷新状态
    [mainTableView.gifHeader beginRefreshing];
}

//刷新用的加载数据
-(void)loadNewData{
     [super showMBProgressHUD:@"加载中..."];
    [mainTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    page = 1;
    showMore = 10;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self fetchQuestionList];
    });
}

-(void)loadNewDatas{
 [super showMBProgressHUD:@"加载中..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self fetchQuestionList];
    });
}

-(void)fetchQuestionList{
    
    NSString *tokenStr = [super userToken];
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:pageStr,@"page",tokenStr,@"token", nil];
    
    [commonModel requestMyCareFriend:tempDic httpRequestSucceed:@selector(requestMyCareFriendSuccess:) httpRequestFailed:@selector(requestMyCareFriendFailed:)];
}

-(void)requestMyCareFriendSuccess:(ASIHTTPRequest *)request{

    [super hideMBProgressHUD];
    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
    NSDictionary *resultDic = [nsDic objectForKey:@"result"];
    NSString *loginStatus = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"status"]];
    if([loginStatus isEqualToString:@"01"]){
        //已经登陆
        NSDictionary *businessDataDic = [resultDic objectForKey:@"businessData"];
        if(page==1){
            if([self.dataArray count]>0){
                
                [self.dataArray removeAllObjects];
                self.dataArray = [NSMutableArray arrayWithCapacity:1];
            }
        }
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[businessDataDic objectForKey:@"get_user_friends"]];
        
        [self.dataArray addObjectsFromArray:tempArray];
        if([self.dataArray count]<showMore && [self.dataArray count]>0)
            showMore = self.dataArray.count;
        [mainTableView reloadData];
        
        [moreCell stopAction];

    }else if([loginStatus isEqualToString:@"00"]){
        //token失效
        
    }
    [mainTableView.header endRefreshing];
}

-(void)requestMyCareFriendFailed:(ASIHTTPRequest *)request{
    
    [mainTableView.header endRefreshing];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.dataArray count]==0) return 0;
       return [self.dataArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

    NSString *reuseIdentifier = @"cell";
    SelectTeacherTableViewCell *cell = (SelectTeacherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[[SelectTeacherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
    }
    
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    if([self.dataArray count]>indexPath.row){
        NSDictionary *mainDic = [NSDictionary dictionaryWithDictionary:[self.dataArray objectAtIndex:indexPath.row]];
       
        //回答者的姓名
        NSString *user_name = @"匿名用户";
        NSString *answerNum = @"0";
        NSString *inviteNum = @"0";
        NSString *zanNum = @"0";
        NSString *fansNum = @"0";
        NSString *avatarImage = @"";
        [cell.avarButton setImage:[UIImage imageNamed:@"avar"] forState:UIControlStateNormal];

        if(!([mainDic count]==0)){
            user_name = [mainDic objectForKey:@"user_name"];
            //agree_count 赞
            zanNum = [NSString stringWithFormat:@"%@",[mainDic objectForKey:@"agree_count"]];
            answerNum = [NSString stringWithFormat:@"%@",[mainDic objectForKey:@"answer_count"]];
            //头像
            avatarImage =[NSString stringWithFormat:@"%@%@",avatarUrl,[mainDic objectForKey:@"avatar_file"]];
            fansNum = [NSString stringWithFormat:@"%@",[mainDic objectForKey:@"fans_count"]];
            inviteNum = [NSString stringWithFormat:@"%@",[mainDic objectForKey:@"views_count"]];
        }
        [cell.avarButton setImageWithURL:[NSURL URLWithString:avatarImage] placeholderImage:[UIImage imageNamed:@"avar"]];
        [cell.nameLabel setText:user_name];
        [cell.zanNumberLabel setText:zanNum];
//        [cell.questionLabel setText:question_content];
//        [cell.answerLabel setText:answer_content];
        
        
        NSString *answerText = [NSString stringWithFormat:@"已回答%@个问题",answerNum];
        NSMutableAttributedString *answerText1 = [[NSMutableAttributedString alloc] initWithString:answerText];
        [answerText1 addAttribute:NSForegroundColorAttributeName value:COLOR(124, 132, 140) range:NSMakeRange(0,3)];
        [answerText1 addAttribute:NSFontAttributeName value:kFontArial13 range:NSMakeRange(0,3)];
        int textLength = answerText1.length;
    
        [answerText1 addAttribute:NSForegroundColorAttributeName value:COLOR(124, 132, 140) range:NSMakeRange(textLength-3,3)];
        [answerText1 addAttribute:NSFontAttributeName value:kFontArial13 range:NSMakeRange(textLength-3,3)];
        cell.answerSomeQuestionLabel.attributedText = answerText1;
        [answerText1 release];
    
    
        NSString *inviteText = [NSString stringWithFormat:@"%@次访问",inviteNum];
        NSMutableAttributedString *inviteText1 = [[NSMutableAttributedString alloc] initWithString:inviteText];
    
        int textLength1 = inviteText1.length;
    
        [inviteText1 addAttribute:NSForegroundColorAttributeName value:COLOR(141, 147, 156) range:NSMakeRange(textLength1-3,3)];
        [inviteText1 addAttribute:NSFontAttributeName value:kFontArial13 range:NSMakeRange(textLength1-3,3)];
        cell.inviteLabel.attributedText = inviteText1;
        [inviteText1 release];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==showMore)return 44;
    return 80;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (![super checkNetworkStatus]) {
//        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
        return;
    }
    
    if(scrollView.tag == 1111111){
        if (scrollView.contentOffset.y + scrollView.frame.size.height + 44.0f >= scrollView.contentSize.height) {
            
            if (!moreAction){
                [moreCell stopAction];
                [moreCell setTips:@"已加载全部"];
            }else{
                [moreCell startAction];
                [moreCell setTips:@"数据加载中..."];
                showMore+=10;
                page++;
                [self loadNewDatas];
            }
        }else {
            moreAction ? [moreCell setTips:@"上拉获取更多"] :[moreCell setTips:@"已加载全部"];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.view.window  showPopWithButtonTitles:@[@"私信",@"关注"] styles:@[YUDefaultStyle,YUDefaultStyle,YUDangerStyle] whenButtonTouchUpInSideCallBack:^(int index  ) {
        
    }];
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
