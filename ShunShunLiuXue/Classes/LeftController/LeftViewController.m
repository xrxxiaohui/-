//
//  LeftViewController.m
//  Mei Zhuang
//
//  Created by Apple on 13-10-29.
//  Copyright (c) 2013年 Apple. All rights reserved.
//
#import "LeftViewController.h"

#import "SliderViewController.h"
#import "LeftTableViewCell.h"
#import "LoginViewController.h"
//#import "SelectThemeViewController.h"

@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_arData;
    NSDictionary *_dicData;
    UITableView *_tableView;
    UITableView *centerTableView;
    UIButton *avatarButton;
    
    UILabel *nameLabel;
    UILabel *haveAnswerQuestionNum;
    UILabel *zanNumLabel;
    UILabel *zanTextLabel;
    UILabel *fansNumLabel;
    UILabel *fansTextLabel;
    UILabel *inviteNumLabel;
    UILabel *inviteTextLabel;
    UIImageView *lineImage;
    UIImageView *lineImage1;
    
    UIButton *loginButton;
}

@property(nonatomic,retain)NSMutableArray *dataArray;

@end

@implementation LeftViewController
@synthesize dataArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(0x19, 0x46, 0x7a);
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    [self addObserver];
    
   UIImageView *_statusBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 0.f)];
    if (isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)
    {
        _statusBarView.frame = CGRectMake(_statusBarView.frame.origin.x, _statusBarView.frame.origin.y, _statusBarView.frame.size.width, 20.f);
        _statusBarView.backgroundColor = [UIColor clearColor];
        //        ((UIImageView *)_statusBarView).backgroundColor = [UIColor clearColor];
        ((UIImageView *)_statusBarView).backgroundColor =  COLOR(0x5d, 0x92, 0xd0);
        [self.view addSubview:_statusBarView];
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        
    }

    
    if (kSystemIsIOS7) {
        centerTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x,20.0f, kScreenBounds.size.width, kScreenBounds.size.height) style:UITableViewStyleGrouped];
    }
    else{
        centerTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x,0.0f, kScreenBounds.size.width, kScreenBounds.size.height) style:UITableViewStylePlain];
    }
//    centerTableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"viewBackGround.png"]] autorelease];
    centerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    centerTableView.backgroundColor = COLOR(0x19, 0x46, 0x7a);
    centerTableView.backgroundColor = [UIColor whiteColor];
    centerTableView.delegate = self;
    centerTableView.dataSource = self;
//    centerTableView.backgroundColor = [UIColor clearColor];
    
    //设置表头部个人信息
    centerTableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 175)];
        view.backgroundColor = COLOR(0x5d, 0x92, 0xd0);
        // 透明大背景,点击进入个人主页
//        UIButton *profileBackgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        profileBackgroundButton.frame = CGRectMake(0, 0.0f, kScreenBounds.size.width, 2*74.0f);
//        profileBackgroundButton.backgroundColor = [UIColor clearColor];
//        profileBackgroundButton.adjustsImageWhenHighlighted = NO;
////        [profileBackgroundButton addTarget:self action:@selector(toProfileViewController) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:profileBackgroundButton];
        
        // 头像
        avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        avatarButton.backgroundColor = [UIColor clearColor];
        avatarButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        avatarButton.frame = CGRectMake(23.0f, 40.0f-20, 66.0f, 66.0f);
        avatarButton.layer.masksToBounds = YES;
        avatarButton.layer.cornerRadius = 33.0;
        avatarButton.layer.borderColor = COLOR(0x19, 0x46, 0x7a).CGColor;
        avatarButton.layer.borderWidth = 2.0f;
        avatarButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
        avatarButton.layer.shouldRasterize = YES;
        avatarButton.clipsToBounds = YES;
        avatarButton.backgroundColor = [UIColor redColor];
//        [avatarButton setBackgroundImage:[UIImage imageNamed:@"menuAvatar.png"] forState:UIControlStateNormal];
//        [avatarButton addTarget:self action:@selector(toProfileViewController) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:avatarButton];
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setText:@"未登录"];
        [nameLabel setFrame:CGRectMake(0, 0, 120, 17)];
        nameLabel.textAlignment= NSTextAlignmentLeft;
        [nameLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [nameLabel setTextColor:[UIColor whiteColor]];
//        [view addSubview:nameLabel];
        
        loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [loginButton setTitle:@"未登录" forState:UIControlStateNormal];
        [loginButton setFrame:CGRectMake(avatarButton.right+10, avatarButton.origin.y+12, 120, 17)];
//        [loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
//        [loginButton.titleLabel setTextColor:[UIColor whiteColor]];
        loginButton.titleLabel.textAlignment= NSTextAlignmentLeft;
        [loginButton addTarget:self action:@selector(toLoginPage) forControlEvents:UIControlEventTouchUpInside];
        [loginButton addSubview:nameLabel];
        [view addSubview:loginButton];
        
        haveAnswerQuestionNum = [[UILabel alloc] init];
        [haveAnswerQuestionNum setText:@"已回答     个问题"];
        [haveAnswerQuestionNum setFrame:CGRectMake(avatarButton.right+10, avatarButton.origin.y+40, 120, 13)];
        haveAnswerQuestionNum.textAlignment= NSTextAlignmentLeft;
        [haveAnswerQuestionNum setFont:kFontArial13];
        [haveAnswerQuestionNum setTextColor:COLOR1(0xb5, 0xca, 0xe7)];
        [view addSubview:haveAnswerQuestionNum];

        lineImage = [[UIImageView alloc] init];
        lineImage.backgroundColor = COLOR1(0x74, 0xa1, 0xd7);
        [lineImage setFrame:CGRectMake(30, avatarButton.bottom+20, kScreenWidth-30, 0.8)];
        [view addSubview:lineImage];
        
        zanNumLabel= [[UILabel alloc] init];
        [zanNumLabel setText:@"0"];
        [zanNumLabel setFrame:CGRectMake(37, avatarButton.bottom+30, 60, 17)];
        [zanNumLabel setFont:kFontArial17];
        zanNumLabel.textAlignment= NSTextAlignmentLeft;
        [zanNumLabel setTextColor:[UIColor whiteColor]];
        [view addSubview:zanNumLabel];
        
        zanTextLabel= [[UILabel alloc] init];
        [zanTextLabel setText:@"赞"];
        [zanTextLabel setFrame:CGRectMake(35, zanNumLabel.bottom+10, 14, 12)];
        [zanTextLabel setFont:kFontArial12];
        zanTextLabel.textAlignment= NSTextAlignmentLeft;
        [zanTextLabel setTextColor:COLOR1(0xb5, 0xca, 0xe7)];
        [view addSubview:zanTextLabel];
        
        fansNumLabel= [[UILabel alloc] init];
        [fansNumLabel setText:@"0"];
        [fansNumLabel setFrame:CGRectMake(100, avatarButton.bottom+30, 60, 17)];
        [fansNumLabel setFont:kFontArial17];
        fansNumLabel.textAlignment= NSTextAlignmentLeft;
        [fansNumLabel setTextColor:[UIColor whiteColor]];
        [view addSubview:fansNumLabel];
        
        fansTextLabel= [[UILabel alloc] init];
        [fansTextLabel setText:@"粉丝"];
        [fansTextLabel setFrame:CGRectMake(94, zanNumLabel.bottom+10, 28, 12)];
        [fansTextLabel setFont:kFontArial12];
        fansTextLabel.textAlignment= NSTextAlignmentLeft;
        [fansTextLabel setTextColor:COLOR1(0xb5, 0xca, 0xe7)];
        [view addSubview:fansTextLabel];
        
        inviteNumLabel= [[UILabel alloc] init];
        [inviteNumLabel setText:@"0"];
        [inviteNumLabel setFrame:CGRectMake(167, avatarButton.bottom+30, 60, 17)];
        [inviteNumLabel setFont:kFontArial17];
        inviteNumLabel.textAlignment= NSTextAlignmentLeft;
        [inviteNumLabel setTextColor:[UIColor whiteColor]];
        [view addSubview:inviteNumLabel];

        inviteTextLabel= [[UILabel alloc] init];
        [inviteTextLabel setText:@"访问"];
        [inviteTextLabel setFrame:CGRectMake(162, zanNumLabel.bottom+10, 28, 12)];
        [inviteTextLabel setFont:kFontArial12];
        inviteTextLabel.textAlignment= NSTextAlignmentLeft;
        [inviteTextLabel setTextColor:COLOR1(0xb5, 0xca, 0xe7)];
        [view addSubview:inviteTextLabel];
        
//        lineImage1 = [[UIImageView alloc] init];
//        lineImage1.backgroundColor = COLOR1(0x2f, 0x57, 0x86);
//        [lineImage1 setFrame:CGRectMake(30, zanTextLabel.bottom+10, kScreenWidth-30, 0.8)];
//        [view addSubview:lineImage1];
        view;
    });
    [self.view addSubview:centerTableView];
    

    _arData = @[@[@"我的关注", @"mycare.png"],
                @[@"我的提问", @"mymention.png"],
                @[@"我的回答", @"myanswer.png"],
                @[@"我的消息", @"mymessage.png"],
                @[@"设置", @"mysetting.png"]];
//
//    [self.view setBackgroundColor:[UIColor clearColor]];
//    
//    float hHeight = 90;
//    UIImageView *imageBgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height/4 + 10)];
//    imageBgV.tag = 18;
//    [imageBgV setBackgroundColor:COLOR(0x19, 0x46, 0x7a)];
//    [self.view addSubview:imageBgV];
//    
//    
//    
//    hHeight = imageBgV.bottom - 80;
//    UIImageView *imageBgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, hHeight, self.view.width, self.view.height - hHeight)];
//    imageBgV2.tag = 19;
//    [imageBgV2 setBackgroundColor:COLOR(0x19, 0x46, 0x7a)];
//    [self.view addSubview:imageBgV2];
    
//    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
//    _contentView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:_contentView];
//    NSLog(@"%f", _contentView.layer.anchorPoint.x);
//    
//    UIImageView *headerIV = [[UIImageView alloc] initWithFrame:CGRectMake(25, 60, 70, 70)];
//    headerIV.layer.cornerRadius = headerIV.width/2;
//    headerIV.tag = 20;
//    [_contentView addSubview:headerIV];
//    
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, imageBgV.bottom + 10, self.view.width, self.view.height - imageBgV.bottom - 80) style:UITableViewStylePlain];
//    _tableView.dataSource = self;
//    _tableView.delegate = self;
//    [_tableView setBackgroundColor:[UIColor clearColor]];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [_contentView addSubview:_tableView];
    
    [self reloadImage];
}

-(void)refreshData{

    NSDictionary *personInfo = [self accountInfo];
    
    if([personInfo count]>0){
    
        NSString *userName = [NSString stringWithFormat:@"%@",[personInfo objectForKey:@"user_name"]];
        NSString *agree_count = [NSString stringWithFormat:@"%@",[personInfo objectForKey:@"agree_count"]];
        NSString *fans_count = [NSString stringWithFormat:@"%@",[personInfo objectForKey:@"fans_count"]];
        NSString *views_count = [NSString stringWithFormat:@"%@",[personInfo objectForKey:@"views_count"]];
        NSString *answerCount =[NSString stringWithFormat:@"%@",[personInfo objectForKey:@"answer_count"]];
        
        [nameLabel setText:userName];
        [zanNumLabel setText:agree_count];
        [fansNumLabel setText:fans_count];
        [inviteNumLabel setText:views_count];
        [haveAnswerQuestionNum setText:[NSString stringWithFormat:@"已回答%@个问题",answerCount]];

        [centerTableView reloadData];
        
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //设置状态栏字颜色为黑色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)backAction:(UIButton *)btn
{
    [[SliderViewController sharedSliderController] closeSideBar];
}

- (void)toNewViewbtn:(UIButton *)btn
{
    [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
     {
     }];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex{
    return 24.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenBounds.size.width, 24.0f)];
    sectionView.backgroundColor = [UIColor clearColor];
    return sectionView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdetify = @"left";
    
    LeftTableViewCell *leftTableViewCell = (LeftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    
    if (leftTableViewCell == nil)
    {
        leftTableViewCell = [[LeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        [leftTableViewCell setBackgroundColor:[UIColor whiteColor]];
        [leftTableViewCell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    
    NSArray *ar = [_arData objectAtIndex:indexPath.row];
//    leftTableViewCell.backgroundColor =COLOR(0x19, 0x46, 0x7a);
    leftTableViewCell.backgroundColor = [UIColor whiteColor];
    [leftTableViewCell.categoryImageView setImage:[UIImage imageNamed:[ar objectAtIndex:1]]];
    [leftTableViewCell.myTitleLabel setText:[ar objectAtIndex:0]];
//    cell.imageView.image = [QHCommonUtil imageNamed:[ar objectAtIndex:1]];
//    cell.textLabel.text = [ar objectAtIndex:0];
//    cell.textLabel.textColor = COLOR(0xcd, 0xd3, 0xdd);
    return leftTableViewCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
    NSString *userToken = [self userToken];
    if(!([userToken length]>10)){
        //未登录
        [self deleteToken];
        [self toLoginPage];
        return;
    }
   
    switch (indexPath.row)
    {
        case 0:
        {
            MyCareViewController *myCareVC = [[MyCareViewController alloc] init];
//            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
//             {
            [self backAction:nil];
            [[SliderViewController sharedSliderController].navigationController pushViewController:myCareVC animated:YES];
//             }];
            break;
        }
        case 1:
        {
            MyMentionViewController *mentionVC = [[MyMentionViewController alloc] init];
//            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
//             {
            [self backAction:nil];
            [[SliderViewController sharedSliderController].navigationController pushViewController:mentionVC animated:YES];
//             }];
            break;
        }
        case 2:
        {
            MyAnswerViewController *myAnswerVC = [[MyAnswerViewController alloc] init];
//            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
//             {
            [self backAction:nil];
            [[SliderViewController sharedSliderController].navigationController pushViewController:myAnswerVC animated:YES];
//             }];
            break;
        }
        case 3:
        {
            MyMessageViewController *messageVC = [[MyMessageViewController alloc] init];
//            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
//             {
            [self backAction:nil];
            [[SliderViewController sharedSliderController].navigationController pushViewController:messageVC animated:YES];
//             }];
            break;
        }
        case 4:
        {
            SettingViewController *messageVC = [[SettingViewController alloc] init];
//            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
//             {
            [self backAction:nil];
                 [[SliderViewController sharedSliderController].navigationController pushViewController:messageVC animated:YES];
//             }];
            break;
        }

        default:
            [self backAction:nil];
            break;
    }
}

#pragma mark - super

- (void)reloadImage
{
//    [super reloadImage];
    
//    UIImageView *imageBgV = (UIImageView *)[self.view viewWithTag:18];
//    UIImage *image = [QHCommonUtil imageNamed:@"sidebar_bg.jpg"];
//    [imageBgV setImage:image];
//    
//    UIImageView *imageBgV2 = (UIImageView *)[self.view viewWithTag:19];
//    UIImage *image2 = [QHCommonUtil imageNamed:@"sidebar_bg_mask.png"];
//    [imageBgV2 setImage:[image2 resizableImageWithCapInsets:UIEdgeInsetsMake(image2.size.height - 1, 0, 1, 0)]];
//    
//    UIImageView *headerIV = (UIImageView *)[self.view viewWithTag:20];
//    UIImage *headerI = [QHCommonUtil imageNamed:@"chat_bottom_smile_nor.png"];
//    [headerIV setImage:headerI];
//    [_tableView reloadData];
}

-(void)addObserver{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"refreshLeftView" object:nil];
}
//登录
-(void)toLoginPage{
    
    NSString *userToken = [self userToken];
    if(!([userToken length]>10)){
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
    //    [self.navigationController pushViewController:loginViewController animated:YES];
        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
    }
//    [loginViewController release];
}

- (void)reloadImage:(NSNotificationCenter *)notif
{
    [self reloadImage];
}

@end
