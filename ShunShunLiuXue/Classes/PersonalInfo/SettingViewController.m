//
//  SettingViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/9/8.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "SettingViewController.h"
#import "SSSettingTableViewCell.h"
#import "SSSetModel.h"
#import "AddressViewController.h"
#import "AddAnswerViewController.h"
@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UITableView *tableView;
/**数据源*/
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showHeaderView];
    self.tableView;
}


#pragma mark - 懒加载
- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat y = self.view.height - 43;
        _loginButton.frame = CGRectMake(0, y, self.view.width, 43);
        [_loginButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setBackgroundColor:RGBCOLOR(255, 62, 48)];

        [self.view addSubview:_loginButton];
    }
    return _loginButton;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        CGFloat y = 64;
        CGFloat height = self.view.height - self.loginButton.height - y;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, self.view.width, height) style:UITableViewStylePlain];
        
        // 去掉系统分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        // 设置数据源 代理
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSSettingTableViewCell class]) bundle:nil] forCellReuseIdentifier:SSSettingTableViewCellID];
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);

        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray array];
        NSMutableArray *section1 = [NSMutableArray array];
        SSSetModel *model = [SSSetModel modelWithTitle:@"意见反馈" type:SSSetModelTypeArrows isRetract:YES];
        [section1 addObject:model];
        model = [SSSetModel modelWithTitle:@"消息提醒" type:SSSetModelTypeSwitch isRetract:NO];
        [section1 addObject:model];
        [_datas addObject:section1];

        NSMutableArray *section2 = [NSMutableArray array];
        model = [SSSetModel modelWithTitle:@"法律条款" type:SSSetModelTypeArrows isRetract:YES];
        [section2 addObject:model];
        model = [SSSetModel modelWithTitle:@"关于顺顺" type:SSSetModelTypeArrows isRetract:NO];
        [section2 addObject:model];
        [_datas addObject:section2];
    }
    return _datas;
}

-(void)showHeaderView{
    
    [self createNavWithTitle:@"设置" createMenuItem:^UIView *(int nIndex)
     {
        if (nIndex == 2)
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
         }
         return nil;
     }];
}

-(void)returnBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - tableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.datas[section];
    return array.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = RGBCOLOR(242, 242, 242);
    UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(0, 9, self.view.width, 1)];
    dividerView.backgroundColor = RGBCOLOR(225, 225, 225);
    [headerView addSubview:dividerView];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SSSettingTableViewCellID];
    if ([self.datas[indexPath.section] isKindOfClass:[NSArray class]]) {
        NSArray *array = self.datas[indexPath.section];
        cell.setModel = array[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    AddressViewController *addressVc = [[AddressViewController alloc] init];
    if (indexPath.section == 1 && indexPath.row == 0) { // 法律条款
        [addressVc initWithUrl:kLawInfo andTitle:@"法律条款"];
        [self.navigationController pushViewController:addressVc animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 1) { // 关于顺顺
        [addressVc initWithUrl:kAboutShunshun andTitle:@"关于顺顺"];
        [self.navigationController pushViewController:addressVc animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 0) { // 意见反馈
        AddAnswerViewController *answerVc = [[AddAnswerViewController alloc] init];
        [self.navigationController pushViewController:answerVc animated:YES];
    }
}

#pragma mark - 退出点击事件
- (void)logout {
    
}


@end
