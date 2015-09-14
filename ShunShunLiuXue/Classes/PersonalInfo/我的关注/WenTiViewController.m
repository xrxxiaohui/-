//
//  WenTiViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/9/8.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "WenTiViewController.h"
#import "MJRefresh.h"
#import "WenTiTableViewCell.h"

@interface WenTiViewController ()
@property(nonatomic,retain)NSMutableArray *dataArray;

@end

@implementation WenTiViewController
@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"问题";
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    showMore = 10;
    
    mainTableView = [[UITableView alloc] init];
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-44-64+20)];
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

-(void)setupTableview{
    //添加下拉的动画图片
    //设置下拉刷新回调
    [mainTableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; ++i) {
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
    
    [commonModel requestMyCareQuestion:tempDic httpRequestSucceed:@selector(requestMyQuestionSuccess:) httpRequestFailed:@selector(requestMyQuestionFailed:)];
}


-(void)requestMyQuestionSuccess:(ASIHTTPRequest *)request{
    
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
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[businessDataDic objectForKey:@"focus_question_list"]];
        
        [self.dataArray addObjectsFromArray:tempArray];
        [mainTableView reloadData];
        
        [moreCell stopAction];
        
    }
    [mainTableView.header endRefreshing];
}

-(void)requestMyQuestionFailed:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
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
    WenTiTableViewCell *cell = (WenTiTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[[WenTiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    if([self.dataArray count]>indexPath.row){
        NSDictionary *mainDic = [NSDictionary dictionaryWithDictionary:[self.dataArray objectAtIndex:indexPath.row]];
        NSDictionary *answerDic = [NSDictionary dictionaryWithDictionary:[mainDic objectForKey:@"question_info"]];
        
        NSDictionary *userInfoDic = nil;
        if([[answerDic objectForKey:@"user_info"] isKindOfClass:[NSNull class]]){}else
            userInfoDic = [NSDictionary dictionaryWithDictionary:[answerDic objectForKey:@"user_info"]];
        
        //问题
        NSString *question_content = [mainDic objectForKey:@"title"];
        [cell.questionLabel setText:question_content];
        CGSize questionSize =[self getStringSizeWith:question_content boundingRectWithSize:(CGSizeMake(cell.questionLabel.width,0)) font:cell.questionLabel.font];
        
        CGRect tempFrame = cell.questionLabel.frame;
        tempFrame.size.height = questionSize.height>36?36:questionSize.height;
        cell.questionLabel.frame = tempFrame;
        
        NSString *view_count = [NSString stringWithFormat:@"%@",[answerDic objectForKey:@"view_count"]];
        NSString *inviteText = [NSString stringWithFormat:@"%@个关注",view_count];
        NSMutableAttributedString *inviteText1 = [[NSMutableAttributedString alloc] initWithString:inviteText];
        int textLength1 = inviteText1.length;
        
        [inviteText1 addAttribute:NSForegroundColorAttributeName value:COLOR(0x7b, 0x83, 0x8e) range:NSMakeRange(textLength1-3,3)];
        [inviteText1 addAttribute:NSFontAttributeName value:kFontArial13 range:NSMakeRange(textLength1-3,3)];
        cell.careLabel.attributedText = inviteText1;
        [inviteText1 release];
        
        NSString *answer_count = [NSString stringWithFormat:@"%@",[answerDic objectForKey:@"answer_count"]];
        NSString *answerText = [NSString stringWithFormat:@"%@个关注",answer_count];
        NSMutableAttributedString *answerText1 = [[NSMutableAttributedString alloc] initWithString:answerText];
        int textLength2 = answerText1.length;
        
        [answerText1 addAttribute:NSForegroundColorAttributeName value:COLOR(0x7b, 0x83, 0x8e) range:NSMakeRange(textLength2-3,3)];
        [answerText1 addAttribute:NSFontAttributeName value:kFontArial13 range:NSMakeRange(textLength2-3,3)];
        cell.answerSomeQuestionLabel.attributedText = answerText1;
        [answerText1 release];

        [cell.careLabel setFrame:CGRectMake(15, cell.questionLabel.bottom+15, 70, 14)];
        [cell.answerSomeQuestionLabel setFrame:CGRectMake(100, cell.questionLabel.bottom+15, kScreenWidth-160, 14)];
        [cell.lineImage setFrame:CGRectMake(15,cell.answerSomeQuestionLabel.bottom+15 , kScreenWidth-15, 0.5)];
        
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataArray count]>indexPath.row){
    NSDictionary *mainDic = [NSDictionary dictionaryWithDictionary:[self.dataArray objectAtIndex:indexPath.row]];
    NSString *question_content = [mainDic objectForKey:@"title"];
    CGSize questionSize =[self getStringSizeWith:question_content boundingRectWithSize:(CGSizeMake(kScreenWidth-30,0)) font:[UIFont systemFontOfSize:15]];
    float tempHeight = questionSize.height>36?36:questionSize.height;
    
    return tempHeight+60;
    }return 44;
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
    NSDictionary *answerInfoDic = [tempInfoDic objectForKey:@"answer_info"];
    //    NSString *questionID = [NSString stringWithFormat:@"%@",[tempInfoDic objectForKey:@"question_id"]];
    NSDictionary *questionInfoDic = [tempInfoDic objectForKey:@"question_info"];
    NSString *answer_count = [NSString stringWithFormat:@"%@",[questionInfoDic objectForKey:@"answer_count"]];
    NSString *titleStr = [NSString stringWithFormat:@"共%@个回答",answer_count];
    NSString *questionID = [NSString stringWithFormat:@"%@",[questionInfoDic objectForKey:@"question_id"]];
    [[ConstObject instance] setQuestionID:questionID];
    NSString *question_content = [questionInfoDic objectForKey:@"question_content"];
    [[ConstObject instance] setQuestionText:question_content];
    
    QuestionViewController *questionViewController = [[QuestionViewController alloc] init];
    [questionViewController initWithTitle:titleStr andAnswerDic:answerInfoDic];
    [[SliderViewController sharedSliderController].navigationController pushViewController:questionViewController animated:YES];

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
