//
//  AnswerSortByTimeViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/9/10.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "AnswerSortByTimeViewController.h"

@interface AnswerSortByTimeViewController ()
@property(nonatomic,retain)NSMutableArray *dataArray;

@end

@implementation AnswerSortByTimeViewController
@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"按时间排序";
    showMore = 10;
    //    self.view.backgroundColor = [UIColor redColor];
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    
    mainTableView  = [[UITableView alloc] init];
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-44-64+20)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.tag = 1111111;
//    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTableView];
    [mainTableView release];
}

-(void)viewWillAppear:(BOOL)animated{
    
    if(!isFirstEnter){
        [self setupTableview];
        isFirstEnter = YES;
    }
}


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
    NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:@"new",@"type",pageStr,@"page",tokenStr,@"token", nil];
    
    [commonModel requestUserAnswer:tempDic httpRequestSucceed:@selector(requestMyCareFriendSuccess:) httpRequestFailed:@selector(requestMyCareFriendFailed:)];
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
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[businessDataDic objectForKey:@"user_answer"]];
        
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
    SheQuTableViewCell *cell = (SheQuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[[SheQuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if([self.dataArray count]>indexPath.row){
        NSDictionary *mainDic = [NSDictionary dictionaryWithDictionary:[self.dataArray objectAtIndex:indexPath.row]];
        NSDictionary *answerDic = [NSDictionary dictionaryWithDictionary:[mainDic objectForKey:@"answer_info"]];
        NSDictionary *questionInfoDic =[NSDictionary dictionaryWithDictionary:[mainDic objectForKey:@"question_info"]];
        
        NSDictionary *userInfoDic = nil;
        if([[answerDic objectForKey:@"user_info"] isKindOfClass:[NSNull class]]){}else
            userInfoDic = [NSDictionary dictionaryWithDictionary:[answerDic objectForKey:@"user_info"]];
        
        //问题
        NSString *question_content = [questionInfoDic objectForKey:@"question_content"];
        //回答
        NSString *answer_content = [answerDic objectForKey:@"answer_content"];
        //回答者的姓名
        NSString *zanNum = @"0";
        if(!([userInfoDic count]==0)){
            //agree_count 赞
            zanNum = [NSString stringWithFormat:@"%@",[userInfoDic objectForKey:@"agree_count"]];
        }
        [cell.avarButton setHidden:YES];
        cell.nameLabel.hidden = YES;
        cell.normalLabel.hidden = YES;
        
        [cell.zanNumberLabel setText:zanNum];
        [cell.questionLabel setText:question_content];
        [cell.answerLabel setText:answer_content];
        
        CGRect tempFrame = CGRectMake(15.0f, 15, kScreenWidth-30, 16);
        cell.questionButton.frame = tempFrame;
        cell.questionLabel.frame =CGRectMake(15.0f, 15, kScreenWidth-30, 16);
        
        CGRect tempFrame3 = cell.zanNumberLabel.frame;
        tempFrame3.origin.y = cell.questionLabel.bottom+11;
        [cell.zanNumberLabel setFrame:tempFrame3];
        
        CGSize tempSize = [self getStringSizeWith:answer_content boundingRectWithSize:(CGSizeMake(cell.answerLabel.width,0)) font:cell.answerLabel.font];
        CGRect tempFrame2 = cell.answerLabel.frame;
        
        tempFrame2.size.height = tempSize.height>32?32:tempSize.height;
        cell.answerLabel.frame = tempFrame2;
        
        UIImage *questionImage = [self imageWithColor:COLOR(189, 217, 247) size:cell.questionLabel.frame.size];
        [cell.questionButton setBackgroundImage:questionImage forState:UIControlStateHighlighted];
        [cell.answerButton setTitle:question_content forState:UIControlStateNormal];
        [cell.answerButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        
        CGRect tempFrame1 = cell.answerLabel.frame;
        tempFrame1.origin.y = cell.questionLabel.bottom+10;
        cell.answerLabel.frame = tempFrame1;

        
        UIImage *answerImage = [self imageWithColor:COLOR(189, 217, 247) size:cell.answerLabel.frame.size];
        [cell.answerButton setBackgroundImage:answerImage forState:UIControlStateHighlighted];
        
        cell.answerButton.tag = indexPath.row;
        cell.questionButton.tag = indexPath.row;
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
    
    NSDictionary *tempInfoDic = [self.dataArray objectAtIndex:indexPath.row];
    NSDictionary *mainDic = [NSDictionary dictionaryWithDictionary:[self.dataArray objectAtIndex:indexPath.row]];
    NSDictionary *questionInfoDic =[NSDictionary dictionaryWithDictionary:[mainDic objectForKey:@"question_info"]];
    NSString *question_content = [questionInfoDic objectForKey:@"question_content"];

    
    NSDictionary *userInfoDic = [tempInfoDic objectForKey:@"answer_info"];
    [[ConstObject instance] setIsFromQusetionToAnswer:NO];
    AnswerDetailViewController *answerDetailViewController = [[AnswerDetailViewController alloc] init];
    [answerDetailViewController initWithTitle:question_content andAnswerDic:userInfoDic];
    [[SliderViewController sharedSliderController].navigationController pushViewController:answerDetailViewController animated:YES];
    
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
