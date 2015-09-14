//
//  HomePageViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/10.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "HomePageViewController.h"
#import "SliderViewController.h"
//#import "UIViewController+MMDrawerController.h"

@interface HomePageViewController () {

    UISearchBar *_searchB;
    UISearchDisplayController *_searchDisplayC;
}

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [super initNavBarItems:@"顺顺留学"];
//    [super addButtonReturn:@"menuButton.png" lightedImage:@"menuButtonLighted.png" selector:@selector(toShowMenu)];
    [self createNavWithTitle:@"首页" createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 1)
         {
             UIButton *mentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
             //            UIImage *i = [UIImage imageNamed:@"group_right_btn.png"];
             //            [btn setImage:i forState:UIControlStateNormal];
             //            [btn setFrame:CGRectMake(self.navView.width - i.size.width - 10, (self.navView.height - i.size.height)/2, i.size.width, i.size.height)];
             [mentionButton setFrame:CGRectMake(self.navView.width - 60, (self.navView.height - 40)/2, 60, 40)];
             [mentionButton setTitle:@"提醒" forState:UIControlStateNormal];
             [mentionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             
             return mentionButton;
         }else  if (nIndex == 2)
         {
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             //            UIImage *i = [UIImage imageNamed:@"group_right_btn.png"];
             //            [btn setImage:i forState:UIControlStateNormal];
             //            [btn setFrame:CGRectMake(self.navView.width - i.size.width - 10, (self.navView.height - i.size.height)/2, i.size.width, i.size.height)];
             [btn setFrame:CGRectMake(10, (self.navView.height - 45)/2, 45, 45)];
             [btn setBackgroundImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
             [btn setBackgroundImage:[UIImage imageNamed:@"menuButtonLighted"] forState:UIControlStateHighlighted];
             [btn addTarget:self action:@selector(toShowMenu) forControlEvents:UIControlEventTouchUpInside];
             [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             
             return btn;
         }

         return nil;
     }];

    _searchB = [[UISearchBar alloc] initWithFrame:CGRectMake(0, self.navView.bottom, self.view.width, 44)];
    [_searchB setPlaceholder:@"搜索"];
    [_searchB setSearchBarStyle:UISearchBarStyleDefault];
    _searchB.userInteractionEnabled = NO;
    
//    _searchDisplayC = [[UISearchDisplayController alloc] initWithSearchBar:_searchB contentsController:self];
//    _searchDisplayC.active = NO;
//    _searchDisplayC.delegate = self;
//    _searchDisplayC.searchResultsDataSource =self;
//    _searchDisplayC.searchResultsDelegate =self;
//    [self.view addSubview:_searchDisplayC.searchBar];
    [self.view addSubview:_searchB];
    self.view.backgroundColor = [UIColor grayColor];
    
    // Do any additional setup after loading the view.
}


//返回主页左侧栏
- (void)toShowMenu{
//    [MobClick event:@"left_menu_count"];
    //[self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    [[SliderViewController sharedSliderController] showLeftViewController];
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
