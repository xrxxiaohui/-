//
//  AskQuestionViewController.m
//  ShunShunLiuXue
//
//  Created by 李晓辉 on 15/8/14.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "AskQuestionViewController.h"
#import "QHBasicViewController.h"
#import "PlaceholderTextView.h"
#import "SelectTeacherViewController.h"

@interface AskQuestionViewController (){

    PlaceholderTextView *myTextView;
    UIButton *mentionButton;
}

@property(nonatomic,retain)NSString *teacherName;

@end

@implementation AskQuestionViewController
@synthesize teacherName;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showHeaderView];
    self.view.backgroundColor = [UIColor whiteColor];
    myTextView=[[PlaceholderTextView alloc] initWithFrame:CGRectMake(13, 64, kScreenWidth -10*2, 280)];
    myTextView.placeholder=@"在这里写下你的问题...";
    myTextView.font=[UIFont boldSystemFontOfSize:16];
    myTextView.placeholderFont=[UIFont boldSystemFontOfSize:16];
    [myTextView becomeFirstResponder];
    
    //改字间距
//    NSMutableParagraphStyle *paragraphStyle = [[[NSMutableParagraphStyle alloc]init] autorelease];
//    paragraphStyle.lineSpacing = 6;
//    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:16], NSParagraphStyleAttributeName:paragraphStyle};
//    myTextView.attributedText = [[NSAttributedString alloc]initWithString:myTextView.text attributes:attributes];

//    view.layer.borderWidth=0.5;
//    view.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.view addSubview:myTextView];
//    [myTextView release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonHalf) name:@"changeButtonHalf" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonNormal) name:@"changeButtonNormal" object:nil];
}

-(void)showHeaderView{
    
    [self createNavWithTitle:@"提问" createMenuItem:^UIView *(int nIndex)
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
    
    UIButton *askSomeTeacher = [UIButton buttonWithType: UIButtonTypeCustom];
    [askSomeTeacher setBackgroundColor:[UIColor clearColor]];
    [askSomeTeacher setTitleColor:COLOR(84, 139, 255) forState:UIControlStateNormal];
    [askSomeTeacher setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [askSomeTeacher setTitle:@"向指定老师提问" forState:UIControlStateNormal];
//    [askSomeTeacher showsTouchWhenHighlighted];
    [askSomeTeacher setFrame:CGRectMake(kScreenWidth-150, kScreenHeight-280, 140, 18)];
    [askSomeTeacher addTarget:self action:@selector(selectTeacherPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:askSomeTeacher];
    
    UIImageView *lineImage = [[UIImageView alloc] init];
    [lineImage setBackgroundColor:COLOR(84, 139, 255)];
    [lineImage setFrame:CGRectMake(askSomeTeacher.origin.x-2, askSomeTeacher.bottom+2, askSomeTeacher.width+4, 0.5)];
    [self.view addSubview:lineImage];
    [lineImage release];
}

//提交问题
-(void)submitQuestion{

    if([myTextView.text length]>0){
    //走接口 提交问题  是否有向指定老师提问  teacherName
        
        [[ConstObject instance] setAskQuestionInfo:myTextView.text];
        SelectMarkViewController *selectMarkViewController = [[SelectMarkViewController alloc] init];
        [self.navigationController pushViewController:selectMarkViewController animated:YES];
        [selectMarkViewController release];
    }
}

-(void)selectTeacherPage{

    SelectTeacherViewController *selectTeacherViewController = [[SelectTeacherViewController alloc] init];
    [self.navigationController pushViewController:selectTeacherViewController animated:YES];
    [selectTeacherViewController release];
}

-(void)returnBack{

//    if([myTextView.text length]>0){
//    
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"尚有未发布的内容，确定退出吗？" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//        [alert show];
//        return;
//
//    }
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex==0){
    
        [myTextView resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];

    }
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

-(void)dealloc{

    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeButtonHalf" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeButtonNormal" object:nil];
    myTextView.text = nil;
    myTextView =nil;

    [super dealloc];
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
