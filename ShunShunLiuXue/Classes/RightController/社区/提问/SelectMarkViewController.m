//
//  SelectMarkViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/9/7.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "SelectMarkViewController.h"

@interface SelectMarkViewController ()

@end

@implementation SelectMarkViewController
@synthesize dataArray;
@synthesize tagArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self showHeaderView];
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    self.tagArray = [NSMutableArray arrayWithCapacity:1];

    [self fetchTopicData];
    
    
}

-(void )fetchTopicData{

    [super showMBProgressHUD:@"加载中..."];
    
    NSString *tokenStr = [super userToken];
    [commonModel requestHotTopicInfo:@"" httpRequestSucceed:@selector(requestHotTopicInfoSuccess:) httpRequestFailed:@selector(requestHotTopicInfoFailed:)];
}

-(void)requestHotTopicInfoSuccess:(ASIHTTPRequest *)request{

    [super hideMBProgressHUD];
    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
    NSDictionary *resultDic = [nsDic objectForKey:@"result"];
    NSDictionary *businessDataDic = [resultDic objectForKey:@"businessData"];
    self.dataArray = [NSMutableArray arrayWithArray:[businessDataDic objectForKey:@"hot_topics"]];
    
    if([self.dataArray count]>0){
    
        //取回data
        for(int i=0; i<[self.dataArray count]; i++){
        
            NSDictionary *tagDic = [NSDictionary dictionaryWithDictionary:[self.dataArray objectAtIndex:i]];
            NSString *tagStr = [NSString stringWithFormat:@"%@",[tagDic objectForKey:@"topic_title"]];
            [tagArray addObject:tagStr];
        }
        
        tagList = [[DWTagList alloc] initWithFrame:CGRectMake(15.0f, 90.0f, kScreenWidth-30, 400.0f)];
//        NSArray *array = [[NSArray alloc] initWithObjects:@"美国高中", @"美国大学",@"美国高中",@"美国高中",@"美国高中",@"美国高中",@"美国高中",@"美国高中",@"美国高中",@"美国高中申请",@"美国高中",@"美国高中",@"美国高中",@"美国高中",@"美国高中",@"xxx",@"美国高中", @"美国大学",@"美国高中",@"美国高中", @"美国大学",@"美国高中",@"美国高中", @"美国大学",@"美国高中",nil];
        [tagList setTags:tagArray];
        [tagList setTapDelegate:self];
        [self.view addSubview:tagList];
    }

}

-(void)requestHotTopicInfoFailed:(ASIHTTPRequest *)request{
    
    [super hideMBProgressHUD];

}

-(void)showHeaderView{
    
    [self createNavWithTitle:@"选择话题" createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 1)
         {
             //右侧消息按钮
             mentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
             [mentionButton setFrame:CGRectMake(self.navView.width - 60, self.navView.height - 35, 50, 25)];
             //             [mentionButton setBackgroundImage:[UIImage imageNamed:@"withMessage"] forState:UIControlStateNormal];
             //             [mentionButton setBackgroundImage:[UIImage imageNamed:@"withMessageLighted"] forState:UIControlStateHighlighted];
             [mentionButton setTitle:@"发布" forState:UIControlStateNormal];
             [mentionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             [mentionButton addTarget:self action:@selector(submitQuestion) forControlEvents:UIControlEventTouchUpInside];
             mentionButton.showsTouchWhenHighlighted = YES;
//             mentionButton.alpha = 0.5;
             [mentionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             
             return mentionButton;


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
    
}

-(void)submitQuestion{

    NSString *question_content = [[ConstObject instance] askQuestionInfo];
    NSString *tokenStr = [self userToken];
    
    NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:question_content,@"question_content",tokenStr,@"token", nil];
    
    [commonModel requestFaBuQuestion:tempDic httpRequestSucceed:@selector(requestFaBuQuestionSuccess:) httpRequestFailed:@selector(requestFaBuQuestionFailed:)];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)requestFaBuQuestionSuccess:(ASIHTTPRequest *)request{

    
}

#pragma mark - TLTagsControlDelegate
- (void)tagsControl:(DWTagList *)tagsControl tappedAtIndex:(NSInteger)index {
    NSLog(@"Tag \"%@\" was tapped", tagsControl.textArray[index]);
    
    UILabel *tempLabel = [[UILabel alloc] init];
    tempLabel = (UILabel *)tagsControl.textLabelArray[index];
    
    //被选中的tag
    NSString *tempTag = [NSString stringWithFormat:@"%d",index];
    BOOL hasSelect = [self deleteTag:tempTag];
    if(hasSelect){
        
        tempLabel.backgroundColor = [UIColor whiteColor];
        [tempLabel setTextColor:[UIColor colorWithRed:76./255. green:175./255. blue:240./255. alpha:1]];
        
    }else{
        
        tempLabel.backgroundColor = [UIColor colorWithRed:100./255. green:179./255. blue:241./255. alpha:1];
        tempLabel.textColor = [UIColor whiteColor];
    }
    
}

-(BOOL)deleteTag:(NSString *)tempTag{
    
    //找到本地是否有该tag 有则删除
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [NSString stringWithFormat:@"%@",[documentsDirectory stringByAppendingPathComponent:@"tag.plist"]];
    
    NSMutableArray *listArray = [[NSMutableArray alloc ] initWithContentsOfFile:plistPath];
    if([listArray count]>0){
        
        for(int i=0; i<[listArray count];i++){
            
            NSString *tempStr = [NSString stringWithFormat:@"%@",[listArray objectAtIndex:i]];
            if([tempStr isEqualToString:tempTag]){
                
                [listArray removeObject:tempTag];
                [listArray writeToFile:plistPath atomically:YES];
                return YES;
            }
        }
        
    }
    //最多选择8个标签
    if([listArray count]>=8){
        
        UIFavoriteAlertView *noteView = [[UIFavoriteAlertView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 -80, [[UIScreen mainScreen] bounds].size.height/2 - 30, 160, 60)];
        
        [noteView setNoteText:@"最多选择8个标签！"];
        [noteView showNoteView];
        [self.view addSubview:noteView];
        
        return YES;
    }
    
    [self saveTag:tempTag];
    return NO;
}

//保存tag
-(void)saveTag:(NSString *)tagString{
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [NSString stringWithFormat:@"%@",[documentsDirectory stringByAppendingPathComponent:@"tag.plist"]];
    
    NSMutableArray *listArray = [[NSMutableArray alloc ] initWithContentsOfFile:plistPath];
    if([listArray count]>0){
        if([listArray count]>=8){
            
            
            return;
        }
        [listArray addObject:tagString];
    }else{
        
        listArray = [NSMutableArray arrayWithCapacity:1];
        [listArray addObject:tagString];
    }
    [listArray writeToFile:plistPath atomically:YES];
}

-(void)deleteAllTags{

    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [NSString stringWithFormat:@"%@",[documentsDirectory stringByAppendingPathComponent:@"tag.plist"]];
    
    NSMutableArray *listArray = [NSMutableArray arrayWithCapacity:1];
    [listArray writeToFile:plistPath atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)returnBack{
    
    [self.navigationController popViewControllerAnimated:YES];
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
