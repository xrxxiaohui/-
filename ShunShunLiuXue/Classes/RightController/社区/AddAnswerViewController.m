//
//  AddAnswerViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/27.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "AddAnswerViewController.h"
#import "PlaceholderTextView.h"

@interface AddAnswerViewController (){

    UIButton *mentionButton;
    PlaceholderTextView *myTextView;
}

@end

@implementation AddAnswerViewController
@synthesize question_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showHeaderView:@"添加回答"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    myTextView=[[PlaceholderTextView alloc] initWithFrame:CGRectMake(13, 64, kScreenWidth -10*2, 280)];
    myTextView.placeholder=@"在这里写下你的问题...";
    myTextView.font=[UIFont boldSystemFontOfSize:16];
    myTextView.placeholderFont=[UIFont boldSystemFontOfSize:16];
    [myTextView becomeFirstResponder];
    [self.view addSubview:myTextView];
    [myTextView release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonHalf) name:@"changeButtonHalf" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonNormal) name:@"changeButtonNormal" object:nil];
}

-(void)showHeaderView:(NSString *)tempStr{
    
    [self createAnswerNavWithTitle:tempStr createMenuItem:^UIView *(int nIndex)
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
             mentionButton.userInteractionEnabled = NO;
             mentionButton.alpha = 0.5;
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

-(void)returnBack{

    [self dismissViewControllerAnimated:YES completion:nil];
}

//提交回答 question_id  answer_content  attach_access_key
-(void)submitQuestion{
      NSString *userToken = [self userToken];
    if([userToken length]>10){
    if([myTextView.text length]>0){
        //提交回答
      
        NSString *textStr = [myTextView text];
        NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:[[ConstObject instance] questionID],@"question_id",textStr,@"answer_content",userToken,@"token", nil];
        [commonModel requestAnswerInfo:tempDic httpRequestSucceed:@selector(requestSubmitSuccess:) httpRequestFailed:@selector(requestSubmitFailed:)];
    }
    }else{
    
        //未登录
        [self deleteToken];
        [self toLoginPage];
    }
}

-(void)requestSubmitSuccess:(ASIHTTPRequest *)request{

    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
    NSDictionary *resultDic = [nsDic objectForKey:@"result"];
    if([[resultDic objectForKey:@"status"] isEqualToString:@"00"]){
    
        //未登录
        [self deleteToken];
         [self toLoginPage];
        return;
    }
    NSDictionary *businessDataDic = [resultDic objectForKey:@"businessData"];
    if(![self isBlankDictionary:businessDataDic]){
     
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadAnswerListData" object:nil];
    }
}

-(void)requestSubmitFailed:(ASIHTTPRequest *)request{
    
    
}

//登录
-(void)toLoginPage{
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
//    [self.navigationController pushViewController:loginViewController animated:YES];
    [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
    [loginViewController release];
}
-(void)changeButtonHalf{
    
    mentionButton.alpha = 0.5;
    mentionButton.userInteractionEnabled = NO;
}

-(void)changeButtonNormal{
    
    mentionButton.alpha = 1;
    mentionButton.userInteractionEnabled = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
