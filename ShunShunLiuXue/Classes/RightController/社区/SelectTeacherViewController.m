//
//  SelectTeacherViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/20.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "SelectTeacherViewController.h"
#import "SelectTeacherTableViewCell.h"


@interface SelectTeacherViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UISearchDisplayDelegate>{
    
    UISearchBar *_searchB;
    UISearchDisplayController *_searchDisplayC;
    UITableView *teacherListTableView;
}

@property(nonatomic,retain)NSMutableArray *teacherArray;
@end

@implementation SelectTeacherViewController
@synthesize teacherArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.teacherArray = [NSMutableArray arrayWithCapacity:1];
    
    [self showHeaderView];

}

-(void)showHeaderView{
    
    [self createNavWithTitle:@"选择老师" createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 1)
         {
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
         }
         
         return nil;
     }];
    
    _searchB = [[UISearchBar alloc] init];
    _searchB.delegate = self;
    [_searchB setPlaceholder:@"搜索您关注的老师"];
    _searchB.frame =CGRectMake(0, self.navView.bottom, kScreenWidth, 44);
    //    //设置选项
    //    [mySearchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"First",@"Last",nil]];
    [_searchB setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_searchB sizeToFit];
    _searchB.backgroundColor = [UIColor whiteColor];
    _searchB.backgroundImage = [self imageWithColor:[UIColor clearColor] size:_searchB.bounds.size];
    [_searchB setSearchFieldBackgroundImage:[UIImage imageNamed:@"searchTeacher"] forState:UIControlStateNormal];
    [_searchB setImage:[UIImage imageNamed:@"bigm"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    //加入列表的header里面
//    _tableView.tableHeaderView = mySearchBar;
//    
//    mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
//    mySearchDisplayController.delegate = self;
//    mySearchDisplayController.searchResultsDataSource = self;
//    mySearchDisplayController.searchResultsDelegate = self;

    
//    _searchB = [[UISearchBar alloc] initWithFrame:CGRectMake(15, self.navView.bottom, kScreenWidth-30, 28)];
//    [_searchB setPlaceholder:@"搜索您关注的老师"];
//    [_searchB setSearchBarStyle:UISearchBarStyleDefault];
//    [_searchB setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//      [[_searchB.subviews objectAtIndex:0]removeFromSuperview];  //去掉搜索框背景
//    [_searchB setBackgroundImage:[UIImage imageNamed:@"searchTeacher"]];

    _searchDisplayC = [[UISearchDisplayController alloc] initWithSearchBar:_searchB contentsController:self];
    _searchDisplayC.active = NO;
    _searchDisplayC.delegate = self;
    _searchDisplayC.searchResultsDataSource =self;
    _searchDisplayC.searchResultsDelegate =self;
    [self.view addSubview:_searchDisplayC.searchBar];
    
    teacherListTableView  = [[UITableView alloc] init];
    teacherListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchB.bottom+5, kScreenWidth, kScreenHeight-64+20)];
    teacherListTableView.delegate = self;
    teacherListTableView.dataSource = self;
    teacherListTableView.tag = 1111111;
    teacherListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:teacherListTableView];
    [teacherListTableView release];
    
    
    
}

-(void)returnBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (tableView == _searchDisplayC.searchResultsTableView)
//    {
//        return 0;
//    }
//    return [self.teacherArray count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (tableView == _searchDisplayC.searchResultsTableView)
//    {
//        return 0;
//    }
//    NSString *key = [_arKey objectAtIndex:section];
//    BOOL bShowRow = [[_dicShowRow objectForKey:key] boolValue];
//    if (bShowRow)
//    {
//        return [[_dicData objectForKey:[_arKey objectAtIndex:section]] count];
//    }
    return 10;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [_arKey objectAtIndex:section];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cell";
    SelectTeacherTableViewCell *cell = (SelectTeacherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {

        cell = [[[SelectTeacherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
    }

    NSString *answerText = [NSString stringWithFormat:@"已回答%@个问题",@""];
    NSMutableAttributedString *answerText1 = [[NSMutableAttributedString alloc] initWithString:answerText];
    [answerText1 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,3)];
    
//    NSString *answerText = [NSString stringWithFormat:@"%@",@"已回答"];
//    NSString *answerText1 = [NSString stringWithFormat:@"%@",@"个问题"];

    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 44;
//}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    int w = tableView.width/7;
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 44)];
    [headV setBackgroundColor:[UIColor whiteColor]];
    
//    NSString *key = [_arKey objectAtIndex:section];
//    BOOL bShowRow = [[_dicShowRow objectForKey:key] boolValue];
    
    UIImage *i = [QHCommonUtil imageNamed:@"buddy_header_arrow.png"];
    UIImageView *arrowIV = [[UIImageView alloc] initWithFrame:CGRectMake((w - i.size.width)/2, (44 - i.size.height)/2, i.size.width, i.size.height)];
    [arrowIV setImage:i];
    [headV addSubview:arrowIV];
//    if (bShowRow)
//        arrowIV.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(w, 2, w * 4, 40)];
//    [titleL setText:[_arKey objectAtIndex:section]];
    [titleL setFont:[UIFont systemFontOfSize:16]];
    [titleL setUserInteractionEnabled:NO];
    [headV addSubview:titleL];
    
    UIView *lineHV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 0.5)];
    [lineHV setBackgroundColor:[UIColor grayColor]];
    [headV addSubview:lineHV];
    
//    if (bShowRow)
//    {
//        UIView *lineBV = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.5, tableView.width, 0.5)];
//        [lineBV setBackgroundColor:[UIColor grayColor]];
//        [headV addSubview:lineBV];
//    }
    
    UILabel *sumL = [[UILabel alloc] initWithFrame:CGRectMake(w * 5, 2, w * 2 - 5, 40)];
    [sumL setTextColor:[UIColor grayColor]];
//    [sumL setText:[NSString stringWithFormat:@"%d/%d", 0, [[_dicData objectForKey:[_arKey objectAtIndex:section]] count]]];
    [sumL setTextAlignment:NSTextAlignmentRight];
    [sumL setFont:[UIFont systemFontOfSize:14]];
    [sumL setUserInteractionEnabled:NO];
    [headV addSubview:sumL];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:headV.bounds];
    btn.tag = section + 1;
    [headV addSubview:btn];
    [btn addTarget:self action:@selector(showRow:) forControlEvents:UIControlEventTouchUpInside];
    
    return headV;
}
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UISearchDisplayDelegate

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [UIView animateWithDuration:0.2 animations:^
     {
         self.navView.top -= 64;
         _searchB.top -= 44;
//         _tableV.top -= 44;
     }completion:^(BOOL finished)
     {
         [self.navView setHidden:YES];
//         _tableV.height += 44;
     }];
    
    controller.searchBar.showsCancelButton = YES;
    for(UIView *subView in [[controller.searchBar.subviews objectAtIndex:0] subviews])
    {
        if([subView isKindOfClass:UIButton.class])
        {
            [(UIButton*)subView setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}

- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    [self.navView setHidden:NO];
    [UIView animateWithDuration:0.2 animations:^
     {
         self.navView.top += 64;
         _searchB.top += 44;
//         _tableV.top += 44;
     }completion:^(BOOL finished)
     {
//         _tableV.height -= 44;
     }];
}

#pragma mark 搜索框的代理方法，搜索输入框获得焦点（聚焦）

//-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    [searchBar setShowsCancelButton:YES animated:YES];
//    
//    // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
//    for (UIView *searchbuttons in [searchBar subviews]){
//        if ([searchbuttons isKindOfClass:[UIButton class]]) {
//            UIButton *cancelButton = (UIButton*)searchbuttons;
//            // 修改文字颜色
//            [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//            
//            // 修改按钮背景searchCancelLighted@2x
//            [cancelButton setBackgroundImage:[UIImage imageNamed:@"searchCancel"] forState:UIControlStateNormal];
//            [cancelButton setBackgroundImage:[UIImage imageNamed:@"searchCancelLighted"] forState:UIControlStateHighlighted];
//        }
//    }
//}
//
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
