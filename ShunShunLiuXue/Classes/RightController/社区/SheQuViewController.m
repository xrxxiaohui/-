//
//  SheQuViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/11.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "SheQuViewController.h"
#import "SearchViewController.h"
#import "AskQuestionViewController.h"
#import "SheQuTableViewCell.h"
#import "MessageViewController.h"
#import "JSDropDownMenu.h"
#import "MJRefresh.h"
#import "MoreCell.h"
#import "AnswerDetailViewController.h"
#import "QuestionViewController.h"
#import "GMDCircleLoader.h"
#import "UIButton+WebCache.h"

@interface SheQuViewController ()<JSDropDownMenuDataSource,JSDropDownMenuDelegate>{

    UITableView *mainTableView;
    
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
    JSDropDownMenu *dropMenu;
    NSString *sortType;
    NSString *qCategory;
    float lastPosition;
}

@property(nonatomic,retain) NSMutableArray *rightDataArray;
@property(nonatomic,retain) NSMutableArray *allDataArray;

@property(nonatomic,retain) NSMutableArray *bigCategoryArray;
@property(nonatomic,retain) NSMutableArray *smallCategoryArray;

@property(nonatomic,retain) NSMutableArray *questionListArray;
@property(nonatomic,retain) NSString *sortType;
@property(nonatomic,retain) NSString *qCategory;


@end

@implementation SheQuViewController
@synthesize rightDataArray;
@synthesize allDataArray;
@synthesize bigCategoryArray;
@synthesize smallCategoryArray;
@synthesize questionListArray;
@synthesize sortType;
@synthesize qCategory;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self showHeaderView];
    self.sortType = @"";
    self.qCategory = @"";
    showMore = 10;
    page = 1;
    moreAction = YES;
    lastPosition = 0;
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+44, kScreenWidth, kScreenHeight-64-20)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.tag = 1111111;
    [self.view addSubview:mainTableView];
    
    self.rightDataArray = [NSMutableArray arrayWithCapacity:1];
    self.bigCategoryArray = [NSMutableArray arrayWithCapacity:1];
    self.smallCategoryArray = [NSMutableArray arrayWithCapacity:1];
    self.allDataArray = [NSMutableArray arrayWithCapacity:1];
    self.questionListArray = [NSMutableArray arrayWithCapacity:1];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self fetchCategoryData];
    });

    [self createCategory];
    [self setupTableview];
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
    [mainTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    page = 1;
    showMore = 10;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self fetchQuestionList];
    });
}

-(void)loadNewDatas{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self fetchQuestionList];
    });
}


-(void)fetchCategoryData{

    [commonModel requestCategory:kCategoryUrl httpRequestSucceed:@selector(requestCategorySuccess:) httpRequestFailed:@selector(requestCategoryFailed:)];
}

-(void)fetchQuestionList{
    [super showMBProgressHUD:@"加载中..."];

    NSString *tokenStr = [super userToken];
    [commonModel requestQuestionSortType:self.sortType
                             andCategory:self.qCategory
                                 andPage:page
                                andToken:tokenStr
                      httpRequestSucceed:@selector(requestQuestionListSuccess:)httpRequestFailed:@selector(requestQuestionListFailed:)];
}

-(void)createCategory{
    
    
//    self.bigCategoryArray = @[@"美国高中", @"美国初中", @"美国大学", @"美国小学", @"美国社区"];
//    self.smallCategoryArray = @[@"全部旅游", @"周边游", @"景点门票", @"国内游", @"境外游",@"全部旅游", @"周边游", @"景点门票", @"国内游", @"境外游"];
    if([self.rightDataArray count]==0)
        [self.rightDataArray addObject: @{@"title":@"全部话题", @"data":@[]}];
    if([self.bigCategoryArray count]>0){
    
        for(int i=0;i<[self.bigCategoryArray count];i++){
        
            NSDictionary *bigCategoryDic =[NSDictionary dictionaryWithDictionary:[self.bigCategoryArray objectAtIndex:i]];
            
            NSArray *smallArray = [NSArray arrayWithArray:[self.smallCategoryArray objectAtIndex:i]];
            
            //重新取出    该类目下所有子类目
            NSMutableArray *finalArray = [NSMutableArray arrayWithCapacity:1];
            for(int i=0;i<[smallArray count];i++){
            
                NSDictionary *tempDic = [smallArray objectAtIndex:i];
                NSString *titleStr = [tempDic objectForKey:@"topic_title"];
                [finalArray addObject:titleStr];
            }
            
//            NSDictionary *smallCategoryDic =[NSDictionary dictionaryWithDictionary:[self.smallCategoryArray objectAtIndex:i]];
            
            
            NSString *bigCategory   = [bigCategoryDic objectForKey:@"name"];
//            NSString *smallCategory = [smallCategoryDic objectForKey:@"topic_title"];
            
//             [NSMutableArray arrayWithObjects:@{@"title":@"全部话题", @"data":food}, @{@"title":@"美国高中", @"data":travel},@{@"title":@"美食", @"data":food},@{@"title":@"美食", @"data":food},@{@"title":@"美食", @"data":food},@{@"title":@"美食", @"data":food},@{@"title":@"美食", @"data":food}, nil];
//
            [self.rightDataArray addObject: @{@"title":bigCategory, @"data":finalArray}];
        }
    }
    
    self.allDataArray = [NSMutableArray arrayWithObjects:@"推荐", @"最新", @"热门", @"等待回复", nil];
    
    dropMenu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    dropMenu.indicatorColor = [UIColor whiteColor];//箭头颜色
    dropMenu.separatorColor = COLOR(0xe6, 0x32, 0x14);
    dropMenu.textColor = [UIColor whiteColor];
    dropMenu.dataSource = self;
    dropMenu.delegate = self;
    dropMenu.hidden = NO;
    
    UIImageView *lineImage = [[UIImageView alloc] init];
    [lineImage setFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    [lineImage setBackgroundColor:COLOR(0xd4, 0x2d, 0x10)];
    [dropMenu addSubview:lineImage];
    [lineImage release];
    
//    [mainTableView addSubview:menu];
    [self.view addSubview:dropMenu];
}

-(void)showHeaderView{

    [self createNavWithTitle:@"" createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 1)
         {
             //右侧消息按钮
             UIButton *mentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
             [mentionButton setFrame:CGRectMake(self.navView.width - 35, self.navView.height - 35, 25, 25)];
             [mentionButton setBackgroundImage:[UIImage imageNamed:@"withMessage"] forState:UIControlStateNormal];
             [mentionButton setBackgroundImage:[UIImage imageNamed:@"withMessageLighted"] forState:UIControlStateHighlighted];
             [mentionButton addTarget:self action:@selector(showMessagePage) forControlEvents:UIControlEventTouchUpInside];
             
//             mentionButton.showsTouchWhenHighlighted = YES;
             [mentionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             
             return mentionButton;
         }else  if (nIndex == 2)
         {
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             //            UIImage *i = [UIImage imageNamed:@"group_right_btn.png"];
             //            [btn setImage:i forState:UIControlStateNormal];
             //            [btn setFrame:CGRectMake(self.navView.width - i.size.width - 10, (self.navView.height - i.size.height)/2, i.size.width, i.size.height)];
             [btn setFrame:CGRectMake(0, (self.navView.height - 45)/2, 45, 45)];
             [btn setBackgroundImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
             [btn setBackgroundImage:[UIImage imageNamed:@"menuButtonLighted"] forState:UIControlStateHighlighted];
             [btn addTarget:self action:@selector(toShowMenu) forControlEvents:UIControlEventTouchUpInside];
             [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             
             return btn;
         }else if(nIndex == 3)
         {
             //搜索按钮
             UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
             [searchButton setFrame:CGRectMake((kScreenWidth-188)/2, self.navView.height - 38, 188, 28)];
             [searchButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
             //             [searchButton setBackgroundImage:[UIImage imageNamed:@"askQuestionButtonLighted"] forState:UIControlStateHighlighted];
             [searchButton addTarget:self action:@selector(tosearchPage) forControlEvents:UIControlEventTouchUpInside];
             searchButton.showsTouchWhenHighlighted = YES;
             [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             
             return searchButton;
         }else if(nIndex==4){
         
             //左侧提问按钮
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             [btn setFrame:CGRectMake(self.navView.width - 60, self.navView.height - 35, 25, 25)];
             [btn setBackgroundImage:[UIImage imageNamed:@"askQuestionButton"] forState:UIControlStateNormal];
             [btn setBackgroundImage:[UIImage imageNamed:@"askQuestionButtonLighted"] forState:UIControlStateHighlighted];
             [btn addTarget:self action:@selector(toAskQuestion) forControlEvents:UIControlEventTouchUpInside];
             btn.showsTouchWhenHighlighted = YES;
             [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             
             return btn;

         }
         return nil;
     }];

}

-(void)showMessagePage{

    MessageViewController *messageViewController = [[MessageViewController alloc] init];
    [[SliderViewController sharedSliderController].navigationController pushViewController:messageViewController animated:YES];
    [messageViewController release];
}

//跳search页面
-(void)tosearchPage{

    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    [[SliderViewController sharedSliderController].navigationController pushViewController:searchViewController animated:YES];
    [searchViewController release];
    
}

//提问
-(void)toAskQuestion{
    AskQuestionViewController *askViewController = [[AskQuestionViewController alloc] init];

    [[SliderViewController sharedSliderController].navigationController pushViewController:askViewController animated:YES];
    [askViewController release];
}

#pragma mark - UITableDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(questionListArray.count == 0) return 0;
    return [self.questionListArray count]+1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

    static NSString* cellID = @"SheQuTableViewCell";
    SheQuTableViewCell* cell = (SheQuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[SheQuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    if([self.questionListArray count]>indexPath.row){
        NSDictionary *mainDic = [NSDictionary dictionaryWithDictionary:[self.questionListArray objectAtIndex:indexPath.row]];
        NSDictionary *answerDic = [NSDictionary dictionaryWithDictionary:[mainDic objectForKey:@"answer_info"]];
    
        NSDictionary *question_usersDic =[NSDictionary dictionaryWithDictionary:[mainDic objectForKey:@"question_users"]];
        
    
        NSDictionary *userInfoDic = nil;
        if([[answerDic objectForKey:@"user_info"] isKindOfClass:[NSNull class]]){}else
            userInfoDic = [NSDictionary dictionaryWithDictionary:[answerDic objectForKey:@"user_info"]];
        if([userInfoDic count]==0){
        
            cell.zanNumberLabel.hidden = YES;
            cell.answerButton.hidden = YES;
            cell.answerLabel.hidden = YES;
        }else{
        
            cell.zanNumberLabel.hidden = NO;
            cell.answerButton.hidden = NO;
            cell.answerLabel.hidden = NO;
        }
        
        //问题
        NSString *question_content = [mainDic objectForKey:@"question_content"];
        //回答
        NSString *answer_content = [answerDic objectForKey:@"answer_content"];
        //回答者的姓名
        NSString *user_name = @"匿名用户";
        NSString *zanNum = @"0";
        NSString *avatarImage = @"";
        [cell.avarButton setImage:[UIImage imageNamed:@"avar"] forState:UIControlStateNormal];
        if(!([question_usersDic count]==0)){
            user_name = [question_usersDic objectForKey:@"user_name"];
        //agree_count 赞
            zanNum = [NSString stringWithFormat:@"%@",[question_usersDic objectForKey:@"agree_count"]];
            //头像
            avatarImage =[NSString stringWithFormat:@"%@%@",avatarUrl,[question_usersDic objectForKey:@"avatar_file"]];

        }
        [cell.avarButton setImageWithURL:[NSURL URLWithString:avatarImage] placeholderImage:[UIImage imageNamed:@"avar"]];
        [cell.nameLabel setText:user_name];
        [cell.zanNumberLabel setText:zanNum];
        [cell.questionLabel setText:question_content];
        [cell.answerLabel setText:answer_content];
        
        CGSize nameSize =[self getStringSizeWith:user_name boundingRectWithSize:(CGSizeMake(0,cell.nameLabel.height)) font:cell.nameLabel.font];
        CGRect tempFrame = cell.nameLabel.frame;
        tempFrame.size.width = nameSize.width;
        cell.nameLabel.frame = tempFrame;
        
        CGRect tempFrame1 = cell.normalLabel.frame;
        tempFrame1.origin.x = cell.nameLabel.origin.x+cell.nameLabel.width+10;
        cell.normalLabel.frame = tempFrame1;
        
        
        CGSize tempSize = [self getStringSizeWith:answer_content boundingRectWithSize:(CGSizeMake(cell.answerLabel.width,0)) font:cell.answerLabel.font];
        CGRect tempFrame2 = cell.answerLabel.frame;

        tempFrame2.size.height = tempSize.height>32?32:tempSize.height;
        cell.answerLabel.frame = tempFrame2;
        
        [cell.questionButton addTarget:self action:@selector(toQuestionDetailPage:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *questionImage = [self imageWithColor:COLOR(189, 217, 247) size:cell.questionLabel.frame.size];
        [cell.questionButton setBackgroundImage:questionImage forState:UIControlStateHighlighted];
        
        [cell.answerButton addTarget:self action:@selector(toAnswerDetailPage:) forControlEvents:UIControlEventTouchUpInside];
        [cell.answerButton setTitle:question_content forState:UIControlStateNormal];
        [cell.answerButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        
        UIImage *answerImage = [self imageWithColor:COLOR(189, 217, 247) size:cell.answerLabel.frame.size];
        [cell.answerButton setBackgroundImage:answerImage forState:UIControlStateHighlighted];
        
        cell.answerButton.tag = indexPath.row;
        cell.questionButton.tag = indexPath.row;
    }
    
    return cell;
}

//toQuestionDetailPage 点击问题
-(void)toQuestionDetailPage:(id)sender{

    UIButton *tempButton = (UIButton *)sender;
    int userid = tempButton.tag;
    NSDictionary *tempInfoDic = [self.questionListArray objectAtIndex:userid];
    
    NSDictionary *userInfoDic = [tempInfoDic objectForKey:@"answer_info"];
    NSString *questionID = [NSString stringWithFormat:@"%@",[tempInfoDic objectForKey:@"question_id"]];
    [[ConstObject instance] setQuestionID:questionID];
    
    //问题
    NSString *question_content = [tempInfoDic objectForKey:@"question_content"];
    [[ConstObject instance] setQuestionText:question_content];
    NSString *answer_count = [NSString stringWithFormat:@"%@",[tempInfoDic objectForKey:@"answer_count"]];
    NSString *titleStr = [NSString stringWithFormat:@"共%@个回答",answer_count];
    
    QuestionViewController *questionViewController = [[QuestionViewController alloc] init];
    [questionViewController initWithTitle:titleStr andAnswerDic:userInfoDic];
    [[SliderViewController sharedSliderController].navigationController pushViewController:questionViewController animated:YES];
//    [tempButton setBackgroundColor:[UIColor blueColor]];
    
}

//toAnswerDetailPage 点击回答内容
-(void)toAnswerDetailPage:(id)sender{
 
    UIButton *tempButton = (UIButton *)sender;
//    [tempButton setBackgroundColor:[UIColor blueColor]];
    int userid = tempButton.tag;
    NSDictionary *tempInfoDic = [self.questionListArray objectAtIndex:userid];
    NSDictionary *userInfoDic = [tempInfoDic objectForKey:@"answer_info"];
    [[ConstObject instance] setIsFromQusetionToAnswer:NO];
    AnswerDetailViewController *answerDetailViewController = [[AnswerDetailViewController alloc] init];
    [answerDetailViewController initWithTitle:tempButton.titleLabel.text andAnswerDic:userInfoDic];
    [[SliderViewController sharedSliderController].navigationController pushViewController:answerDetailViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row==showMore)return 44;
    
    if([self.questionListArray count]>indexPath.row){
        
        NSDictionary *mainDic = [NSDictionary dictionaryWithDictionary:[self.questionListArray objectAtIndex:indexPath.row]];
            NSDictionary *answerDic = [NSDictionary dictionaryWithDictionary:[mainDic objectForKey:@"answer_info"]];
            NSDictionary *userInfoDic = nil;
            if([[answerDic objectForKey:@"user_info"] isKindOfClass:[NSNull class]]){}else
                userInfoDic = [NSDictionary dictionaryWithDictionary:[answerDic objectForKey:@"user_info"]];
            
            if([userInfoDic count]==0){
                
                return 72;
            }else
                return 104;
    }
        return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - lastPosition > 44) {
        lastPosition = currentPostion;
        NSLog(@"ScrollUp now");
//        dropMenu.hidden = YES;
//        [mainTableView setFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-44)];
    }
    else if (lastPosition - currentPostion > 44)
    {
        lastPosition = currentPostion;
        NSLog(@"ScrollDown now");
//        dropMenu.hidden = NO;
//       mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+44, kScreenWidth, kScreenHeight-64-64-10)];

    }
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


#pragma mark - 类目代理
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 2;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    if (column==2) {
        
        return YES;
    }
    
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    //yes 有右边
    if (column==1) {
        return YES;
    }
    return NO;
}

//左边tableview所占比例
-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column==1) {
        return 0.4375;
    }
    
    return 1;
}

//缺右边被选中的☑️
-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==1) {
        
        return _currentData1Index;
        
    }
    if (column==0) {
        
        return _currentData2Index;
    }
    
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    //每一列的行数
    if (column==1) {
        if (leftOrRight==0) {
            
            return self.rightDataArray.count;
        } else{
            if(self.rightDataArray.count>0){
                NSDictionary *menuDic = [self.rightDataArray objectAtIndex:leftRow];
                return [[menuDic objectForKey:@"data"] count];
            }else
                return 0;
        }
    } else if (column==0){
        
        return self.allDataArray.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0:
            //            return [[suggestDataArray[0] objectForKey:@"data"] objectAtIndex:0];
            return @"推荐排序";
            break;
        case 1:
            return @"全部话题";
            //            return allDataArray[0];
            break;
            //        case 2: return _data3[0];
            //            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==1) {
        if([self.rightDataArray count]>0){
            if (indexPath.leftOrRight==0) {
            
                NSDictionary *menuDic = [self.rightDataArray objectAtIndex:indexPath.row];
                return [menuDic objectForKey:@"title"];
            } else{
                NSInteger leftRow = indexPath.leftRow;
                NSDictionary *menuDic = [self.rightDataArray objectAtIndex:leftRow];
                return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
            }
        }else{
            return nil;
        }
    } else{
        return allDataArray[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 1) {
        
        if(indexPath.leftOrRight==0){
            //            leftOrRight＝＝1 右边  0 左边
            
            _currentData1Index = indexPath.row;
            if(indexPath.row == 0){
            
                self.qCategory = @"1";
                [self loadNewData];
            }
        
            return;
        }else{
        
                NSString *selectID = @"";
                NSInteger leftRow = indexPath.leftRow;
                NSDictionary *menuDic = [self.rightDataArray objectAtIndex:leftRow];
                NSString *selectText =   [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
            if(_currentData1Index>0){
            
             NSArray *smallArray = [NSArray arrayWithArray:[self.smallCategoryArray objectAtIndex:_currentData1Index-1]];
            
            for(int i=0;i<smallArray.count;i++){
            
                NSDictionary *tempDic =[NSDictionary dictionaryWithDictionary:[smallArray objectAtIndex:i]];
                if([[tempDic objectForKey:@"topic_title"] isEqualToString:selectText]){
                
                    selectID = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"topic_id"]];
                    break;
                }
            }
            }
            self.qCategory = selectID;
            [self loadNewData];
            
            }
        
    } else if(indexPath.column == 0){
        
        _currentData2Index = indexPath.row;
        switch (_currentData2Index) {
            case 0:
                self.sortType = @"";
                break;
            case 1:
                self.sortType = @"new";
                break;
            case 2:
                self.sortType = @"hot";
                break;
            case 3:
                self.sortType = @"unresponsive";
                break;
                
            default:
                break;
        }
            [self loadNewData];
        
    } else{
        
//        _currentData3Index = indexPath.row;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//request代理
-(void)requestCategorySuccess:(ASIHTTPRequest *)request{
    
    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
    NSDictionary *resultDic = [nsDic objectForKey:@"result"];
    NSDictionary *businessDataDic = [resultDic objectForKey:@"businessData"];
    self.bigCategoryArray = [NSMutableArray arrayWithArray:[businessDataDic objectForKey:@"big_catalog"]];
    self.smallCategoryArray = [NSMutableArray arrayWithArray:[businessDataDic objectForKey:@"small_catalog"]];
    
    [self createCategory];
    
    //    NSString *result = [nsDic objectForKey: @"resultList"];
}

-(void)requestCategoryFailed:(ASIHTTPRequest *)request{
    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
    
}

-(void)requestQuestionListSuccess:(ASIHTTPRequest *)request{
    
    [super hideMBProgressHUD];
    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
    NSDictionary *resultDic = [nsDic objectForKey:@"result"];
    NSDictionary *businessDataDic = [resultDic objectForKey:@"businessData"];
    if(page==1){
    if([self.questionListArray count]>0){
    
        [self.questionListArray removeAllObjects];
        self.questionListArray = [NSMutableArray arrayWithCapacity:1];
    }
    }
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[businessDataDic objectForKey:@"question_list"]];

    [self.questionListArray addObjectsFromArray:tempArray];
    [mainTableView reloadData];
    [mainTableView.header endRefreshing];
    [moreCell stopAction];
//    self.bigCategoryArray = [NSMutableArray arrayWithArray:[businessDataDic objectForKey:@"big_catalog"]];
//    self.smallCategoryArray = [NSMutableArray arrayWithArray:[businessDataDic objectForKey:@"small_catalog"]];
//    
//    [self createCategory];
    
    //    NSString *result = [nsDic objectForKey: @"resultList"];
}

-(void)requestQuestionListFailed:(ASIHTTPRequest *)request{
   
    [super hideMBProgressHUD];
    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
    [mainTableView.header endRefreshing];
}

//返回主页左侧栏
- (void)toShowMenu{
    //    [MobClick event:@"left_menu_count"];
    //[self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    [[SliderViewController sharedSliderController] showLeftViewController];
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

-(void)dealloc{

    [rightDataArray release];
    [allDataArray release];
    
    [bigCategoryArray release];
    [smallCategoryArray release];
    [questionListArray release];
    [super dealloc];
}

@end
